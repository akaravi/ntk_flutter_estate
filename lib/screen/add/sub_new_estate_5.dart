import 'dart:math';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ntk_flutter_estate/global_data.dart';
import 'package:ntk_flutter_estate/screen/add/sub_new_estate_1.dart';
import 'package:file_picker/file_picker.dart';
import '../../controller/new_estate_controller.dart';
import 'package:base/src/index.dart';

// import 'package:base/src/backend/api/file/dio_uploader.dart';
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
              widget: Container(
                  color: GlobalColor.colorAccent.withOpacity(.9).withAlpha(50),
                  child: InkWell(
                    onTap: getFile,
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Icon(
                        Icons.add_a_photo,
                        color: GlobalColor.colorPrimary,
                      ),
                    ),
                  )))
        ]),
        if (widget.controller.mainGUID != "")
          widget.card(children: [
            widget.box(title: GlobalString.morePic, widget: widget)
          ])
      ],
    );
  }

  void getFile() async {
    List<PlatformFile> file = (await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      onFileLoading: (FilePickerStatus status) => print(status),
    ))!
        .files;
    // var upload =await ChunkedUploader()
    //     .upload(filePlatform: file.elementAt(0) );
    var upload =await FileUploadService().upload(File(file.first.path ?? ""));
    print(upload.toString());
  }
}
