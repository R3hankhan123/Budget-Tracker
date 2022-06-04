import 'package:hive/hive.dart';

class DbHelper {
  late Box box;
  DbHelper() {
    openBox();
  }
  openBox() {
    box = Hive.box('Money');
  }

  Future addData(
      int amount, String description, String type, DateTime date) async {
    var value = {
      'amount': amount,
      'description': description,
      'type': type,
      'date': date,
    };
    box.add(value);
  }

  Future<Map> fetch() {
    if (box.values.isEmpty) {
      return Future.value({});
    } else {
      return Future.value(box.toMap());
    }
  }
}
