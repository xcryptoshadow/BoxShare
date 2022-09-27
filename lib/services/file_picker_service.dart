// ignore_for_file: prefer_const_constructors

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:giga_share/config/config.dart';
import 'package:giga_share/models/user_model.dart';
import 'package:giga_share/services/ipfs/ipfs_service.dart';
import 'package:giga_share/upload/qr_screen.dart';
import 'package:giga_share/widgets/boxes.dart';
import 'package:giga_share/widgets/progress_dialog.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class FilePickerService {

  @protected
  @mustCallSuper
  void dispose() {
    Hive.close();
  }

//PICKER
  static Future<FilePickerResult?> pickFile(BuildContext context) async {

    try {
      // Pick an file
      FilePickerResult? file = await FilePicker.platform.pickFiles(allowMultiple: false);

      //Nothing picked
      if (file == null) {
        Fluttertoast.showToast(
          msg: 'No File Selected',
        );
        return null;
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => ProgressDialog(
            status: 'Uploading to IPFS',
          ),
        );

        final bytes = file.files.single.bytes!;
        // upload video to ipfs
        final cid = await IpfsService().uploadToIpfs(/*file.files.single.path!*/ bytes);

        // Saving the transaction to database
        final transactionMap = UserModel()
          ..url = ipfsURL + cid
          ..date = DateFormat.yMMMd().format(DateTime.now())
          ..received = false;

        final box = Boxes.getTransactions();
        box.add(transactionMap);

        // Popping out the dialog box
        Navigator.pop(context);

        // Take to QrScreen
        await Get.to(() => QrScreen(cid: cid));

        //Return Path
        return file;
      }
    } catch (e) {
      debugPrint('Error at file picker: $e');
      SnackBar(
        content: Text(
          'Error at file picker: $e',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
      );
      return null;
    }
  }
}
