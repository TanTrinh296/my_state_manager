import 'package:example/src/domain/interfaces/user_interface.dart';
import 'package:example/src/domain/models/user.dart';
import 'package:example/src/infrastructure/data/local_database/isar_config.dart';
import 'package:isar/isar.dart';

class UserRepo implements UserInterface {
  final _isar = IsarConfig().isar;
  @override
  Future<User?> updateUser({required User user}) async {
    try {
      await _isar.writeTxn(() async {
        final current = await _isar.users.get(user.id);
        if (current != null) {
          current.name = user.name;
          current.email = user.email;
          current.avatar = user.avatar;
          await _isar.users.put(current);
          return current;
        }
        return null;
      });
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User?> getUser({required int id}) async {
    await Future.delayed(const Duration(seconds: 2));
    return await _isar.users.get(id);
  }

  @override
  Future<List<User>> getUsers() async {
    await Future.delayed(const Duration(seconds: 2));
    final users = await _isar.users.where().findAll();
    return users;
  }

  @override
  Future<User?> addUser({required User user}) async {
    try {
      final id = await _isar.writeTxn(() async {
        await _isar.users.put(user);
      });
      if (id != null) {
        return user;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> updateAvatar({required int id, required String avatar}) async{
    try {
      await _isar.writeTxn(() async {
        final current = await _isar.users.get(id);
        if (current != null) {
          current.avatar = avatar;
          await _isar.users.put(current);
          return current;
        }
        return null;
      });
      return avatar;
    } catch (e) {
      rethrow;
    }
  }
}
