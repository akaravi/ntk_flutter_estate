import 'package:base/src/controller/base/intro_controller.dart';
import 'package:base/src/models/entity/application/application_intro_model.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/auth/auth_sms_screen.dart';
import 'package:ntk_flutter_estate/screen/generalized/sub_loading_screen.dart';

class IntroScreen extends StatelessWidget {
  bool asHelpScreen;

  IntroScreen({Key? key, bool? asHelpScreen})
      : asHelpScreen = asHelpScreen ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ApplicationIntroModel>>(
          future: IntroController().getIntro(),
          builder: (context, snapshot) {
            Widget widget;
            //todo add error page
            if (snapshot.hasData) {
              widget = IntroWidget(
                asHelpScreen: asHelpScreen,
                createSlides(snapshot.data),
                key: ValueKey(0),
              );
            } else
              widget = SubLoadingScreen(key: ValueKey(1));
            return AnimatedSwitcher(
                duration: const Duration(seconds: 1), child: widget);
          }),
    );
  }

  createSlides(List<ApplicationIntroModel>? data) {
    List<Slide> list = [];
    data = data ?? [];
    for (var element in data) {
      Slide slide = Slide(
        title: element.title,
        maxLineTitle: 2,
        styleTitle: const TextStyle(
          color: GlobalColor.colorTextPrimary,
          fontSize: 23.0,
          fontWeight: FontWeight.bold,
        ),
        styleDescription: const TextStyle(
          color: GlobalColor.colorTextSecondary,
          fontSize: 16.0,
          fontStyle: FontStyle.italic,
        ),
        marginDescription: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
      );
      if (element.linkMainImageIdSrc != null &&
          (element.linkMainImageIdSrc?.isNotEmpty ?? false)) {
        slide.centerWidget = Container(
            constraints: const BoxConstraints(minHeight: 40, maxHeight: 200),
            child: Image.network(
              element.linkMainImageIdSrc ?? "",
            ));
      }
      slide.description = element.description;
      list.add(slide);
    }
    return list;
  }
}

class IntroWidget extends StatelessWidget {
  List<Slide> slides;

  bool asHelpScreen;

  IntroWidget(this.slides, {Key? key, required this.asHelpScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      // List slides
      slides: slides,

      // Skip button
      renderSkipBtn: renderSkipBtn(),
      skipButtonStyle: myButtonStyle(),

      // Next button
      renderNextBtn: renderNextBtn(),
      nextButtonStyle: myButtonStyle(),
      // Done button
      renderDoneBtn: renderDoneBtn(),
      onDonePress: () => onDonePress(context),
      doneButtonStyle: myButtonStyle(),
      //prev btn
      showPrevBtn: true,
      renderPrevBtn: renderPrevBtn(),
      prevButtonStyle: myButtonStyle(),

      scrollPhysics: const BouncingScrollPhysics(),
      // Dot indicator
      showDotIndicator: true,
      colorDot: GlobalColor.colorAccent.withOpacity(.5),
      colorActiveDot: GlobalColor.colorAccentDark,
      sizeDot: 5.0,

      // Show or hide status bar
      hideStatusBar: true,
      backgroundColorAllSlides: GlobalColor.colorBackground,
    );
  }

  void onDonePress(BuildContext context) {
    //navigate to next page if frist open go to intro page
    //otherwise this page open from features click
    if (asHelpScreen) {
      IntroController().close(context);
    }
    else{
      Future.microtask(() {
        IntroController().nextPage(context, newWidget: AuthSmsScreen());
      });
    }
  }

  Widget renderNextBtn() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            GlobalString.next,
            style: TextStyle(color: GlobalColor.colorOnAccent, fontSize: 13),
          ),
          Icon(
            Icons.navigate_next,
            color: GlobalColor.colorOnAccent,
            size: 35.0,
          ),
        ],
      ),
    );
  }

  Widget renderPrevBtn() {
    return const Icon(
      Icons.navigate_before,
      color: GlobalColor.colorOnAccent,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return const Icon(
      Icons.done,
      color: GlobalColor.colorOnAccent,
    );
  }

  Widget renderSkipBtn() {
    return const Icon(
      Icons.skip_next,
      color: GlobalColor.colorOnAccent,
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      backgroundColor:
      MaterialStateProperty.all<Color>(GlobalColor.colorAccent),
    );
  }
}
