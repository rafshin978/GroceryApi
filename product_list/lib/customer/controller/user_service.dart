import 'package:hive/hive.dart';
import 'package:product_list/customer/user_model.dart';

class UserService {
  static const String _boxName = 'userBox';

  Future<void> saveUser(User user) async {
    var box = await Hive.openBox<User>(_boxName);
    await box.put('user', user);
  }

  Future<User?> getUser() async {
    var box = await Hive.openBox<User>(_boxName);
    return box.get('user');
  }

  Future<void> deleteUser() async {
    var box = await Hive.openBox<User>(_boxName);
    await box.delete('user');
  }
}
