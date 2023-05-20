import 'dart:math';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_1.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ntk_flutter_estate/screen/generalized/sub_loading_screen.dart';
import 'package:ntk_flutter_estate/widget/wrap_widget_model.dart';
import '../../controller/new_estate_controller.dart';
import 'package:ntk_cms_flutter_base/src/index.dart';

// import 'package:ntk_cms_flutter_base/src/backend/api/file/dio_uploader.dart';
class SubNewEstate5 extends SubNewEstateBase {
  SubNewEstate5({Key? key, required NewEstateController controller})
      : super(key: key, controller: controller);

  @override
  State<SubNewEstate5> createState() => _Container1State();
}

class _Container1State extends State<SubNewEstate5> {
  @override
  Widget build(BuildContext context) {
    if (widget.screenWidth == -1) {
      widget.screenWidth = MediaQuery.of(context).size.width;
    }
    return Column(
      children: [
        widget.card(children: [
          widget.box(
              fitContainer: true,
              title: GlobalString.mainPic,
              widget: (widget.controller.mainImage == null)
                  ? Container(
                      color:
                          GlobalColor.colorAccent.withOpacity(.9).withAlpha(50),
                      child: InkWell(
                        onTap: selectMainImage,
                        child: const Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Icon(
                            Icons.add_a_photo,
                            color: GlobalColor.colorPrimary,
                          ),
                        ),
                      ))
                  : imageWidget(
                      widget.controller.mainImage ?? ImageUpload("", "", false),
                      onDelete: () {
                      widget.controller.mainImage = null;
                      setState(() {});
                    }))
        ]),
        if (widget.controller.mainImage != null &&
            widget.controller.mainImage?.path != null)
          widget.card(children: [
            Row(
              children: [
                Expanded(
                  child: widget.box(
                    title: GlobalString.morePic,
                    widget: (widget.controller.otherImage.isNotEmpty)
                        ? Wrap(runSpacing: 10, spacing: 12, children: [
                            ...(widget.controller.otherImage)
                                .map((e) => imageWidget(
                                      e,
                                      onDelete: () {
                                        widget.controller.otherImage.remove(e);
                                        setState(() {});
                                      },
                                    ))
                                .toList()
                          ])
                        : const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(GlobalString.noImageAdded),
                          ),
                  ),
                ),
                //add button
                Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: InkWell(
                        child: Material(
                          elevation: 12,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                    color: GlobalColor.colorAccent, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(
                              Icons.add_a_photo,
                              size: 24,
                              color: GlobalColor.colorAccent,
                            ),
                          ),
                        ),
                        onTap: () => selectOtherImage()))
              ],
            )
          ]),
      ],
    );
  }

  void selectMainImage() async {
    List<PlatformFile> file = (await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      onFileLoading: (FilePickerStatus status) => print(status),
    ))!
        .files;
    // var upload =await ChunkedUploader()
    //     .upload(filePlatform: file.elementAt(0) );
    SubLoadingScreen.showProgress(context);
    if (await widget.controller
        .uploadMainImage(context: context, file: File(file.first.path ?? ""))) {
      setState(() {});
    }
    SubLoadingScreen.dismiss(context);
  }

  selectOtherImage() async {
    List<PlatformFile> file = (await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      onFileLoading: (FilePickerStatus status) => print(status),
    ))!
        .files;
    SubLoadingScreen.showProgress(context);
    if (await widget.controller.uploadOtherImage(
        context: context, file: File(file.first.path ?? ""))) {
      setState(() {});
    }
    SubLoadingScreen.dismiss(context);
  }

  imageWidget(ImageUpload e, {required void Function() onDelete}) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.fromBorderSide(
              BorderSide(color: GlobalColor.colorPrimary))),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(8),
              child: e.isFromWeb
                  ? Image.network(e.path)
                  : Image.file(File(e.path))),
          Align(
            child: TextButton(
                onPressed: onDelete, child: const Text(GlobalString.delete)),
          )
        ],
      ),
    );
  }
}
