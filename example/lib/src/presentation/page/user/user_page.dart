import 'dart:io';

import 'package:example/src/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:my_state_manager/my_state_manager.dart';
import 'user_controller.dart';

class UserAsyncWidget extends StatelessWidget {
  const UserAsyncWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = RxControllerStore().find<UserController>();

    return RxAsyncBuilder<List<User>>(
      rxAsync: controller.users,
      builder: (context, snapshot, refresh) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: const CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Error: ${snapshot.error}'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: refresh, // gọi lại API khi cần
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            if (snapshot.hasData) {
              final users = snapshot.data ?? [];
              if (users.isEmpty) {
                return Center(child: const Text('No data'));
              }
              return RefreshIndicator(
                onRefresh: () => controller.users.refresh(),
                child: ListView.separated(
                  itemCount: users.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: (user.avatar.isNotEmpty)
                            ? FileImage(File(user.avatar))
                            : null,
                      ),
                      title: Text(user.name),
                      subtitle: Text(user.email),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => controller.deleteUser(user.id),
                      ),
                      onTap: () => controller.goProfile(id: user.id),
                    );
                  },
                ),
              );
            }
            return const Text('No data');
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
