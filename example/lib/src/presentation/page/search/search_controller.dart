import 'package:example/src/domain/models/user.dart';
import 'package:example/src/infrastructure/repositories/user_repo.dart';
import 'package:example/src/presentation/page/profile/profile_page.dart';
import 'package:example/src/presentation/page/user/user_controller.dart';
import 'package:my_state_manager/my_state_manager.dart';

class SearchUserController extends RxController {
  late final RxAsync<List<User>> searchAsync;
  String keyword = ''; //
  final searchDebounce = RxDebounce<String>(
    '',
    duration: Duration(milliseconds: 400),
  );
  final userApi = RxControllerStore().find<UserRepo>();
  @override
  void onInit() {
    searchAsync =
        RxAsync<List<User>>(loadData: () => searchUser(name: keyword));
    searchDebounce.listen((value) {
      keyword = value;
      searchAsync.load();
    });
    super.onInit();
  }

  @override
  void onClose() {
    searchDebounce.dispose();
    super.onClose();
  }

  Future<List<User>> searchUser({required String name}) async {
    return userApi.searchUser(name: name);
  }

  Future<void> goProfile({required int id}) async {
    final result =
        await RxNavigator().pushWithArgs<bool?>(ProfilePage(), arguments: id);
    if (result == true) {
      searchAsync.refresh();
      RxControllerStore().find<UserController>().users.refresh(); // refresh user
    }
  }
}
