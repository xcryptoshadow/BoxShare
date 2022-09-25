
import 'package:hive_flutter/adapters.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)

class UserModel extends HiveObject {
  @HiveField(0)
  late String url;

  @HiveField(1)
  late String date;

  @HiveField(2)
  late bool received;

}

