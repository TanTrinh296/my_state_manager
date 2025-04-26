import 'package:example/core/utils/media_helper.dart';
import 'package:example/src/domain/interfaces/user_interface.dart';
import 'package:example/src/domain/models/user.dart';
import 'package:example/src/infrastructure/repositories/user_repo.dart';
import 'package:example/src/presentation/page/profile/profile_page.dart';
import 'package:example/src/presentation/page/search/search_page.dart';
import 'package:example/src/presentation/page/user/child_widgets/add_user_dialog.dart';
import 'package:flutter/material.dart';
import 'package:my_state_manager/my_state_manager.dart';

class UserController extends RxController {
  late final RxAsync<List<User>> users;
  final userApi = RxControllerStore().put<UserInterface>(UserRepo());
  final mediaHelper = RxControllerStore().put(MediaHelper());
  @override
  void onInit() {
    super.onInit();
    users =
        RxAsync<List<User>>(loadData: _fetchUsers); // Gọi API để lấy dữ liệu
    users.load(); // Gọi API để lấy dữ liệu
  }

  Future<List<User>> _fetchUsers() async {
    return userApi.getUsers();
  }

  Future<void> addUser(String name, String email, String avatar) async {
    final newUser = User()
      ..name = name
      ..email = email
      ..avatar = avatar;
    userApi.addUser(user: newUser);
    users.refresh();
  }

  Future<void> deleteUser(int id) async {
    await userApi.deleteUser(id: id);
    users.refresh();
  }

  Future<void> updateUser(User user) async {
    await userApi.updateUser(user: user);
    users.refresh();
  }

  Future<void> showAddUserDialog({required BuildContext context}) async {
    await showDialog(
      context: context,
      builder: (_) => AddUserDialog(),
    );
  }

  Future<void> goProfile({required int id}) async {
    final result =
        await RxNavigator().pushWithArgs<bool?>(ProfilePage(), arguments: id);
    if (result == true) {
      users.refresh();
    }
  }

  Future<void> goSearchPage() => RxNavigator().pushWithArgs(const SearchPage());

}
