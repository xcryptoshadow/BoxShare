// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:giga_share/resources/color_constants.dart';
import 'package:giga_share/resources/image_resources.dart';
import 'package:giga_share/services/file_picker_service.dart';
import 'package:giga_share/services/image_picker_service.dart';
import 'package:giga_share/services/video_picker_service.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.appColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: ColorConstants.appColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'UPLOAD',
          style: TextStyle(
            letterSpacing: 1.2,
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  await ImagePickerService.pickImage(context);
                },
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          ImageResources.uploadImage,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: ColorConstants.messageErrorBgColor,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                            ),
                          ),
                          onPressed: () async {
                            await ImagePickerService.pickImage(context);
                          },
                          label: Text(
                            'Upload Photo',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          icon: Icon(
                            Icons.image, size: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: InkWell(
                onTap: () async {
                  await VideoPickerService.pickVideo(context);
                },
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          ImageResources.uploadVideoImage,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: ColorConstants.messageErrorBgColor,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                            ),
                          ),
                          onPressed: () async {
                            await VideoPickerService.pickVideo(context);
                          },
                          label: Text(
                            'Upload Video',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          icon: Icon(
                              Icons.video_call_rounded, size: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: InkWell(
                onTap: () async {
                  await FilePickerService.pickFile(context);
                },
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          ImageResources.uploadFileImage,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: ColorConstants.messageErrorBgColor,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                            ),
                          ),
                          onPressed: () async {
                            await FilePickerService.pickFile(context);
                          },
                          label: Text(
                            'Upload File',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          icon: Icon(
                            Icons.file_copy_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
