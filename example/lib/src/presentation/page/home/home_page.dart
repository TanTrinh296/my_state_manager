import 'package:example/src/presentation/page/count/counter_controller.dart';
import 'package:example/src/presentation/page/count/counter_obx_widget.dart';
import 'package:example/src/presentation/page/user/user_page.dart';
import 'package:example/src/presentation/page/user/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:my_state_manager/my_state_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return RxMultiWidget(controllers: [
      () => CounterController(),
      () => UserController(),
    ], builder: (context) => HomeProvider());
  }
}

class HomeProvider extends StatefulWidget {
  const HomeProvider({super.key});

  @override
  State<HomeProvider> createState() => _HomeProviderState();
}

class _HomeProviderState extends State<HomeProvider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My State Manager')),
      body: UserAsyncWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          RxControllerStore()
              .find<UserController>()
              .showAddUserDialog(context: context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
