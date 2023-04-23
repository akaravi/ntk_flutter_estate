import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:base/src/index.dart';

class LiveLocationPage extends StatefulWidget {
  static const String route = '/live_location';

  static Widget attributionWidgetDefault() {
    return const Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(right: 4.0),
          child: ColoredBox(
              color: Color(0xCCFFFFFF),
              child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Text(
                    'OpenStreetMap contributors',
                    style: TextStyle(color: Color(0xFF0078a8)),
                  ))),
        ));
  }

  const LiveLocationPage({Key? key}) : super(key: key);

  @override
  _LiveLocationPageState createState() => _LiveLocationPageState();
}

class _LiveLocationPageState extends State<LiveLocationPage> {
  LocationData? _currentLocation;
  LatLng? selectLatLng;
  late final MapController _mapController;

  bool _liveUpdate = false;
  bool _permission = false;

  String? _serviceError = '';

  int interActiveFlags = InteractiveFlag.all;

  final Location _locationService = Location();

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    initLocationService();
  }

  void initLocationService() async {
    LocationData? location;
    bool serviceEnabled;
    bool serviceRequestResult;

    try {
      serviceEnabled = await _locationService.serviceEnabled();

      if (serviceEnabled) {
        final permission = await _locationService.requestPermission();
        _permission = permission == PermissionStatus.granted;

        if (_permission) {
          await _locationService.changeSettings(
            accuracy: LocationAccuracy.high,
            interval: 1000,
          );
          location = await _locationService.getLocation();
          _currentLocation = location;
          _locationService.onLocationChanged
              .listen((LocationData result) async {
            if (mounted) {
              setState(() {
                _currentLocation = result;

                // If Live Update is enabled, move map center
                if (_liveUpdate) {
                  _mapController.move(
                      LatLng(_currentLocation!.latitude!,
                          _currentLocation!.longitude!),
                      _mapController.zoom);
                }
              });
            }
          });
        }
      } else {
        serviceRequestResult = await _locationService.requestService();
        if (serviceRequestResult) {
          initLocationService();
          return;
        }
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      if (e.code == 'PERMISSION_DENIED') {
        _serviceError = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        _serviceError = e.message;
      }
      location = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    LatLng currentLatLng;

    // Until currentLocation is initially updated, Widget can locate to 0, 0
    // by default or store previous location value to show.
    if (_currentLocation != null) {
      currentLatLng =
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
    } else {
      currentLatLng = LatLng(0, 0);
    }

    // final markers = <Marker>[
    //   Marker(
    //     width: 80,
    //     height: 80,
    //     point: currentLatLng,
    //     builder: (ctx) => const FlutterLogo(
    //       textColor: Colors.blue,
    //       key: ObjectKey(Colors.blue),
    //     ),
    //   ),
    // ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          GlobalString.back,
          style: TextStyle(color: GlobalColor.colorAccent),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: GlobalColor.colorAccent),
          onPressed: () => BaseController().close(context),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: LatLng(currentLatLng.latitude, currentLatLng.longitude),
                zoom: 12,
                onTap: (tapPos, latLng) {
                  CustomPoint? pt1 = _mapController.latLngToScreenPoint(latLng);
                  selectLatLng = latLng;
                  setState(() {});
                },
                interactiveFlags: interActiveFlags,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
                MarkerLayer(markers: [
                  if (_currentLocation != null)
                    Marker(
                      height: 150,
                      width: 150,
                      point: currentLatLng,
                      builder: (context) {
                        return Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: new BoxDecoration(
                                  color:
                                      GlobalColor.colorAccent.withOpacity(.9),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const Text(
                                GlobalString.estimateLoc,
                                style: TextStyle(
                                    color: GlobalColor.colorPrimary,
                                    fontSize: 16),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  if (selectLatLng != null)
                    Marker(
                      width: 60,
                      height: 60,
                      point: selectLatLng ?? LatLng(0, 0),
                      builder: (ctx) => const FlutterLogo(
                        textColor: Colors.blue,
                        key: ObjectKey(Colors.blue),
                      ),
                    )
                ]),
              ],
            ),
          ),
          Positioned(
            bottom: 15,
            right: 15,
            left: 40,
            child: Center(
              child: TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0)),
                    elevation: 17,
                    backgroundColor: GlobalColor.colorPrimary),
                onPressed: () {
                  if (selectLatLng == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(GlobalString.noLocSelected),
                    ));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: const Text(GlobalString.submitLocation,
                      style: TextStyle(
                          color: GlobalColor.colorTextOnPrimary, fontSize: 16)),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Builder(builder: (BuildContext context) {
        return FloatingActionButton(
            backgroundColor: GlobalColor.colorPrimary,
            onPressed: () {
              if (currentLatLng != null)
                _mapController.move(
                    LatLng(_currentLocation!.latitude!,
                        _currentLocation!.longitude!),
                    _mapController.zoom);
            },
            child: const Icon(Icons.location_searching));
      }),
    );
  }
}
