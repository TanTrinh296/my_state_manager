import 'dart:io';

import 'package:example/src/presentation/page/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_state_manager/my_state_manager.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RxControllerBuilder(
        init: () => ProfileController(),
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: Text('Profile'),
              ),
              body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Obx(
                    builder: () {
                      if (controller.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (controller.user.value == null) {
                        return Text('No data');
                      }
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            children: [
                              Obx(
                                builder: () => CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        controller.avatar.value.isNotEmpty
                                            ? FileImage(
                                                File(controller.avatar.value),
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
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Icon(Icons.edit)),
                                  ))
                            ],
                          ),
                          TextField(
                              controller: controller.nameCtrl,
                              decoration:
                                  const InputDecoration(labelText: 'Name')),
                          TextField(
                              controller: controller.emailCtrl,
                              decoration:
                                  const InputDecoration(labelText: 'Email')),
                          SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
                            onPressed: () => controller.updateUser(),
                            child: Text('Update'),
                          ),
                        ],
                      );
                    },
                  )),
            ));
  }

  Future<void> _selectAvatar() async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null) {
      final controller = RxControllerStore().find<ProfileController>();
      controller.avatar.value = result.path;
    }
  }
}
