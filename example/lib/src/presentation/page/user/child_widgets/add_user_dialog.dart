import 'dart:io';

import 'package:example/core/utils/media_helper.dart';
import 'package:example/src/presentation/page/user/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_state_manager/my_state_manager.dart';

class AddUserDialog extends StatefulWidget {
  const AddUserDialog({super.key});

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final controller = RxControllerStore().find<UserController>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final avatar = ''.rx;
  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add User"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Obx(
                builder: () => CircleAvatar(
                    radius: 50,
                    backgroundImage: avatar.value.isNotEmpty
                        ? FileImage(
                            File(avatar.value),
                          )
                        : null),
              ),
              Positioned(
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () => _selectAvatar(),
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(100)),
                        child: Icon(Icons.edit)),
                  ))
            ],
          ),
          TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Name')),
          TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: 'Email')),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            controller.addUser(nameCtrl.text, emailCtrl.text, avatar.value);
            Navigator.pop(context);
          },
          child: const Text("Save"),
        ),
      ],
    );
  }

  Future<void> _selectAvatar() async {
    final mediaHelp = RxControllerStore().find<MediaHelper>();
    final result = await mediaHelp.pickImage();
    if (result != null) {
      avatar.value = result.path;
    }
  }
}
