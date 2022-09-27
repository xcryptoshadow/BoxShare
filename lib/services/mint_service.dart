// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giga_share/config/config.dart';
import 'package:giga_share/models/user_model.dart';
import 'package:giga_share/services/ipfs/ipfs_service.dart';
import 'package:giga_share/services/mint_response_model.dart';
import 'package:giga_share/widgets/boxes.dart';
import 'package:giga_share/widgets/progress_dialog.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MintService {
  @protected
  @mustCallSuper
  void dispose() {
    Hive.close();
  }

  static Future<void> uploadMint(BuildContext context, String nftName, String nftDescription,
      String mintToAddress, FilePickerResult? file) async {
    try {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => ProgressDialog(
          status: 'Minting....',
        ),
      );

      // upload video to ipfs
      String cid = "";
      if (file != null) {
        final bytes = file.files.single.bytes;
        cid = await IpfsService().uploadToIpfs(/*file.files.single.path!*/ bytes!);
      }

      // Saving the transaction to database
      final transactionMap = UserModel()
        ..url = ipfsURL + cid
        ..date = DateFormat.yMMMd().format(DateTime.now())
        ..received = false;

      final box = Boxes.getTransactions();
      box.add(transactionMap);

      final jsonData = {
        'chain': 'polygon',
        'name': nftName,
        'description': nftDescription,
        'file_url': transactionMap.url,
        "mint_to_address": "0xfbE7A5e17568dBE7D1705307b5d1B59E458c768B"
      };
      const url = 'https://api.nftport.xyz/v0/mints/easy/urls';
      final mainResponse = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            'Authorization': '08365241-ba71-4a12-8129-e10829ab69b3'
          },
          body: jsonEncode(jsonData));
      final response = json.decode(mainResponse.body);
      if (response != null) {
        print(response.toString());
        final data = MintResponseModel.fromJson(response);
        Fluttertoast.showToast(msg: 'Minting Successful');
      }

      Navigator.pop(context);
    } catch (e) {
      print(e);
      Navigator.pop(context);
      return;
    }
  }
}
