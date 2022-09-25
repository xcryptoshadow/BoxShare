import 'package:giga_share/models/user_model.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<UserModel> getTransactions() => Hive.box<UserModel>('user_model');
}
