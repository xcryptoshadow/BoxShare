import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../config/config.dart';
import '../models/user_model.dart';
import '../upload/qr_screen.dart';
import '../widgets/boxes.dart';
import '../widgets/progress_dialog.dart';
import 'ipfs/ipfs_service.dart';

class TextFileService {
  @protected
  @mustCallSuper
  void dispose() {
    Hive.close();
  }

//PICKER
  static Future<void> uploadTextFile(BuildContext context, String text, String fileName) async {
    final List<UserModel> transactions = [];

    try {
      //Nothing picked
      if (text.isEmpty) {
        Fluttertoast.showToast(
          msg: 'Please enter text',
        );
        return;
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => const ProgressDialog(
            status: 'Uploading to IPFS',
          ),
        );

        late final File file;
        late final Uint8List bytes;
        if (kIsWeb) {
          List<int> list = text.codeUnits;
          bytes = Uint8List.fromList(list);
        } else {
          final String? dir = Platform.isIOS
              ? (await getApplicationDocumentsDirectory()).path
              : (await getExternalStorageDirectory())?.path;
          String mainFileName = fileName.isEmpty ? 'myText' : fileName;
          final String path = '$dir/${DateTime.now()}$mainFileName.txt';
          file = File.fromUri(Uri.parse(path));
          await file.writeAsString(text);
          bytes = await file.readAsBytes();
        }

        // upload images to ipfs
        final cid = await IpfsService().uploadToIpfs(/*file.path*/ bytes);
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
