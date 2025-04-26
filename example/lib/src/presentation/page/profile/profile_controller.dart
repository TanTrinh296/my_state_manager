import 'dart:developer';
import 'package:example/src/domain/interfaces/user_interface.dart';
import 'package:example/src/domain/models/user.dart';
import 'package:example/src/infrastructure/repositories/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:my_state_manager/my_state_manager.dart';

class ProfileController extends RxController {
  final id = RxNavigator().arguments() as int;
  final userApi = RxControllerStore().find<UserRepo>();
  final user = RxNullable<User>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final avatar = ''.rx;
  final isLoading = false.rx;
  @override
  void onInit() {
    _fetchUser();
    super.onInit();
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    super.onClose();
  }

  Future<void> _fetchUser() async {
    isLoading.value = true;
    try {
      final userRes = await userApi.getUser(id: id);
      if (userRes != null) {
        user.value = userRes;
        avatar.value = userRes.avatar;
        nameCtrl.text = userRes.name;
        emailCtrl.text = userRes.email;
      }
    } catch (e) {
      log(e.toString());
    }
    isLoading.value = false;
  }

  Future<void> updateUser() async {
    final newUser = user.value!
      ..name = nameCtrl.text
      ..email = emailCtrl.text
      ..avatar = avatar.value;
    try {
      final result = await userApi.updateUser(user: newUser);
      if (result != null) {
        RxNavigator().back(true);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateAvatar(String avatar) async {
    await userApi.updateAvatar(id: id, avatar: avatar);
  }
}
