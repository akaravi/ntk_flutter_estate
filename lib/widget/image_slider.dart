import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ntk_flutter_estate/global_data.dart';

class ImageSilder extends StatefulWidget {
  List<String> images;

  ImageSilder({super.key, required this.images}) {
    imageSliders = images
        .map(
          (item) =>
              // Stack(fit: StackFit.expand,
              //       children: <Widget>[

              Container(
                decoration: BoxDecoration(
                    color: Colors.amber
                ),
            width: double.infinity,
            child: Image.network(
              item,
              fit: BoxFit.cover,
            ),
          ),
          //         Positioned(
          //           bottom: 0.0,
          //           left: 0.0,
          //           right: 0.0,
          //           child: Container(height: 140,
          // decoration: const BoxDecoration(
          //   gradient: LinearGradient(
          //     colors: [
          //       Color.fromARGB(200, 0, 0, 0),
          //       Color.fromARGB(0, 0, 0, 0)
          //     ],
          //     begin: Alignment.bottomCenter,
          //     end: Alignment.topCenter,
          //   ),
          // ),
          //
          //           ),
          //         ),
          //       ],
          //     )
        )
        .toList();
  }

  late List<Widget> imageSliders;

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<ImageSilder> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CarouselSlider(
        items: widget.imageSliders,
        carouselController: _controller,
        options: CarouselOptions(  viewportFraction: 1,
            // enlargeCenterPage: true,
            onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        }),
      ),
      Positioned(
        bottom: 0,right: 0,left: 0,
        child: Row(mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imageSliders.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 6.0,
                height: 6.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? GlobalColor.colorAccent
                            : GlobalColor.colorAccent.withOpacity(.5))
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ),
    ]);
  }
}
