## IPFS : [click here to see the code](https://github.com/xcryptoshadow/BoxShare/blob/63534549becb3424aef62f10ce1bfeeeafe21c03/lib/services/mint_service.dart)


![uploading file to ipfs](https://user-images.githubusercontent.com/102347045/192480160-1e3b1c51-dc28-4180-b356-606156ceaa33.JPEG)

```
 final cid = await IpfsService().uploadToIpfs(/*file.files.single.path!*/ bytes);

        // Saving the transaction to database
        final transactionMap = UserModel()
          ..url = ipfsURL + cid
          ..date = DateFormat.yMMMd().format(DateTime.now())
          ..received = false;

        final box = Boxes.getTransactions();
        box.add(transactionMap);
```


