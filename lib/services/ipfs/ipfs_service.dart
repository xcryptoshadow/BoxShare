import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:giga_share/config/config.dart';
import 'package:http/http.dart' as http;

class IpfsService {
  Future<String> uploadToIpfs(/*String uploadPath,*/ Uint8List bytes) async {
    try {
      //final bytes = File(uploadPath).readAsBytesSync();

      final response = await http.post(
        Uri.parse('https://api.nft.storage/upload'),
        headers: {'Authorization': 'Bearer $nftStorageKey', 'content-type': 'images/*'},
        body: bytes,
      );

      final data = jsonDecode(response.body);

      final cid = data['value']['cid'];

      // debugPrint('CID OF IMAGE -> $cid');

      return cid;
    } catch (e) {
      debugPrint('Error at IPFS Service - uploadImage: $e');
      rethrow;
    }
  }
}
