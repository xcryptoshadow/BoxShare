// ignore_for_file: prefer_const_constructors

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
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class VideoPickerService {
  @protected
  @mustCallSuper
  void dispose() {
    Hive.close();
  }

//PICKER
  static Future<XFile?> pickVideo(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();

    try {
      // Pick an video
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.gallery,
      );

      //Nothing picked
      if (video == null) {
        Fluttertoast.showToast(
          msg: 'No Video Selected',
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

        final bytes = await video.readAsBytes();
        // upload video to ipfs
        final cid = await IpfsService().uploadToIpfs(bytes);

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
        return video;
      }
    } catch (e) {
      debugPrint('Error at video picker: $e');
      SnackBar(
        content: Text(
          'Error at video picker: $e',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
      );
      return null;
    }
  }
}
