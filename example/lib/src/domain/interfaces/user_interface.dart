import 'package:example/src/domain/models/user.dart';

interface class UserInterface {
  Future<List<User>> getUsers() => throw UnimplementedError();
  Future<User?> getUser({required int id}) => throw UnimplementedError();
  Future<User?> updateUser({required User user}) => throw UnimplementedError();
  Future<User?> addUser({required User user}) => throw UnimplementedError();
  Future<String?> updateAvatar({required int id, required String avatar}) =>
      throw UnimplementedError();
  Future<List<User>> searchUser({required String name}) =>
      throw UnimplementedError();
  Future<bool> deleteUser({required int id}) => throw UnimplementedError();
}
