## NFT Port :

![NFT Port](https://user-images.githubusercontent.com/102347045/192469127-630a407b-b2b5-4167-83cd-e73cb3746170.JPEG)


```
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
```

[click here to see the code](https://github.com/xcryptoshadow/BoxShare/blob/63534549becb3424aef62f10ce1bfeeeafe21c03/lib/services/mint_service.dart)
