// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';

import 'package:flutter/foundation.dart';
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

class ImagePickerService {

  @protected
  @mustCallSuper
  void dispose() {
    Hive.close();
  }

//PICKER
  static Future<XFile?> pickImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final List<UserModel> transactions  = [];

    try {
      // Pick an images
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      //Nothing picked
      if (image == null) {
        Fluttertoast.showToast(
          msg: 'No Image Selected',
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

        final Uint8List bytes = await image.readAsBytes();

        // upload images to ipfs
        final cid = await IpfsService().uploadToIpfs(bytes);
        // debugPrint(cid);

        // Saving the transaction to database
        // DatabaseReference transaction =
        //     FirebaseDatabase.instance.ref().child('transactions');

        // String uploadID = transaction.push().key!;

        // Map transactionMap = {
        //   'url': ipfsURL + cid,
        //   'date': DateFormat.yMMMd().format(DateTime.now()),
        //   'received': false,
        // };

        // transaction.child(uploadID).set(transactionMap);

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
        return image;
      }
    } catch (e) {
      debugPrint('Error at images picker: $e');
      SnackBar(
        content: Text(
          'Error at images picker: $e',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
      );
      return null;
    }
  }
}
