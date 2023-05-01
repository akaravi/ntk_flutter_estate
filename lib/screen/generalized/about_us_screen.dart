import 'package:flutter/material.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:base/src/index.dart';
import 'package:ntk_flutter_estate/screen/generalized/sub_empty_screen.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            GlobalString.aboutUs,
            style: TextStyle(color: GlobalColor.colorAccent),
          ),
          leading: IconButton(
              icon:
              const Icon(Icons.arrow_back, color: GlobalColor.colorAccent),
              onPressed: () => BaseController().close(context))),
      body: FutureBuilder<AboutUsModel?>(
          future: MainScreenCache().aboutUs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                return widget(snapshot.data ?? AboutUsModel());
              }
            }
            return const SubEmptyScreen();
          }),
    );
  }

  Widget widget(AboutUsModel a) {
    return Column(children: [
      if (a.aboutUsLinkImageId != null) ...[
        const SizedBox(
          height: 25,
        ),
        Image.network(
          a.aboutUsLinkImageId ?? "",
          width: 70,
          height: 70,
        )
      ],
      if ((a.aboutUsDescription ?? "").isNotEmpty) ...[
        Text(
          a.aboutUsDescription ?? "",
          style: const TextStyle(
              color: GlobalColor.colorTextPrimary, fontSize: 16),
        ),
        const SizedBox(
          height: 16,
        ),
        line()
      ],
      if((a.aboutUsAddress ?? "").isNotEmpty)...[
        title(GlobalString.address),
        subTitle(a.aboutUsAddress ?? ""),
        line()
      ],
      if((a.aboutUsAddress ?? "").isNotEmpty)...[
        title(GlobalString.address),
        subTitle(a.aboutUsAddress ?? ""),
        line()
      ],
      if(telIsValid(a))...[
        title(GlobalString.contactUs),
        if((a.aboutUsTel ?? "").isNotEmpty)
          iconText(Icons.phone, GlobalString.telephone, a.aboutUsTel ?? ""),
        if((a.aboutUsFax ?? "").isNotEmpty)
          iconText(Icons.fax, GlobalString.fax, a.aboutUsFax ?? ""),
        if((a.aboutUsEmail ?? "").isNotEmpty)
          iconText(Icons.email, GlobalString.fax, a.aboutUsEmail ?? ""),
        line(),
      ]
      , title(GlobalString.build)
      , subTitle("نسخه ی 1.7 نگارش دوم")
    ]);
  }

  line() {
    return const Divider(color: Colors.black45);
  }

  title(String t) {
    return Text("$t :", style: const TextStyle(
        fontWeight: FontWeight.bold, color: GlobalColor.colorAccentDark),);
  }

  subTitle(String t) {
    return Text(t, style: const TextStyle(
        fontWeight: FontWeight.normal, color: GlobalColor.colorPrimary),);
  }

  bool telIsValid(AboutUsModel a) {
    bool x = false;
    if ((a.aboutUsTel ?? "").isNotEmpty) {
      x = true;
    }
    if ((a.aboutUsFax ?? "").isNotEmpty) {
      x = true;
    }
    if ((a.aboutUsEmail ?? "").isNotEmpty) {
      x = true;
    }
    return x;
  }

  iconText(IconData iconData, String t1, String t2) {
    return Row(children: [Icon(iconData), subTitle(t1), subTitle(t2)],);
  }

}
