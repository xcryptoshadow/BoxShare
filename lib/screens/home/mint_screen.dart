import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giga_share/services/mint_service.dart';

import '../../resources/color_constants.dart';
import '../../resources/image_resources.dart';
import '../../services/file_picker_service.dart';

class MintingScreen extends StatefulWidget {
  const MintingScreen({Key? key}) : super(key: key);

  @override
  State<MintingScreen> createState() => _MintingScreenState();
}

class _MintingScreenState extends State<MintingScreen> {
  final _fileNameController = TextEditingController();
  final _textController = TextEditingController();
  final _nftAddressController = TextEditingController();
  FilePickerResult? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.appColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.appColor,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'Minting',
          style: TextStyle(
            letterSpacing: 1.2,
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: InkWell(
                onTap: () async {
                  file = await FilePicker.platform.pickFiles(allowMultiple: false, withData: true);
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
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                            ),
                          ),
                          onPressed: () {},
                          label: const Text(
                            'Upload File',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          icon: const Icon(
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
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Nft Name',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _fileNameController,
              keyboardType: TextInputType.multiline,
              maxLines: 1,
              cursorColor: Colors.white,
              style: const TextStyle(fontSize: 14, color: Colors.white),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  hintStyle: TextStyle(color: Colors.white)),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'NFT Description',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: TextField(
                controller: _textController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
                style: const TextStyle(fontSize: 14, color: Colors.white),
                cursorColor: Colors.white,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    hintStyle: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Mint to address',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: TextField(
                controller: _nftAddressController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
                style: const TextStyle(fontSize: 14, color: Colors.white),
                cursorColor: Colors.white,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    hintStyle: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                primary: ColorConstants.messageErrorBgColor,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () async {
                if (file == null) {
                  Fluttertoast.showToast(msg: 'Please select File');
                } else if (_fileNameController.text.isEmpty) {
                  Fluttertoast.showToast(msg: 'Please  enter NFT Name');
                } else if (_textController.text.isEmpty) {
                  Fluttertoast.showToast(msg: 'Please  enter NFT description');
                } else if (_nftAddressController.text.isEmpty) {
                  Fluttertoast.showToast(msg: 'Please  enter mint to address');
                } else {
                  await MintService.uploadMint(context, _fileNameController.text,
                      _textController.text, _nftAddressController.text, file);

                  _textController.text = '';
                  _fileNameController.text = '';
                  _nftAddressController.text = '';
                  file = null;
                }
              },
              label: const Text(
                'Create Mint',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              icon: Image.asset(
                ImageResources.pasteBinIcon,
                height: 16,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
