/// response : "OK"
/// chain : "polygon"
/// contract_address : "0x55a8dbe6f191b370885d01e30cb7d36d0fa99f16"
/// transaction_hash : "0x571f5c2570eeeac1f6537ca3634a368c3e543d6e4f30d8509be7c6546c7d06dc"
/// transaction_external_url : "https://polygonscan.com/tx/0x571f5c2570eeeac1f6537ca3634a368c3e543d6e4f30d8509be7c6546c7d06dc"
/// mint_to_address : "0xfbe7a5e17568dbe7d1705307b5d1b59e458c768b"
/// name : "Account 1"
/// description : "Type your NFT description here"

class MintResponseModel {
  MintResponseModel({
    String? response,
    String? chain,
    String? contractAddress,
    String? transactionHash,
    String? transactionExternalUrl,
    String? mintToAddress,
    String? name,
    String? description,
  }) {
    _response = response;
    _chain = chain;
    _contractAddress = contractAddress;
    _transactionHash = transactionHash;
    _transactionExternalUrl = transactionExternalUrl;
    _mintToAddress = mintToAddress;
    _name = name;
    _description = description;
  }

  MintResponseModel.fromJson(dynamic json) {
    _response = json['response'];
    _chain = json['chain'];
    _contractAddress = json['contract_address'];
    _transactionHash = json['transaction_hash'];
    _transactionExternalUrl = json['transaction_external_url'];
    _mintToAddress = json['mint_to_address'];
    _name = json['name'];
    _description = json['description'];
  }

  String? _response;
  String? _chain;
  String? _contractAddress;
  String? _transactionHash;
  String? _transactionExternalUrl;
  String? _mintToAddress;
  String? _name;
  String? _description;

  String? get response => _response;

  String? get chain => _chain;

  String? get contractAddress => _contractAddress;

  String? get transactionHash => _transactionHash;

  String? get transactionExternalUrl => _transactionExternalUrl;

  String? get mintToAddress => _mintToAddress;

  String? get name => _name;

  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response'] = _response;
    map['chain'] = _chain;
    map['contract_address'] = _contractAddress;
    map['transaction_hash'] = _transactionHash;
    map['transaction_external_url'] = _transactionExternalUrl;
    map['mint_to_address'] = _mintToAddress;
    map['name'] = _name;
    map['description'] = _description;
    return map;
  }
}
