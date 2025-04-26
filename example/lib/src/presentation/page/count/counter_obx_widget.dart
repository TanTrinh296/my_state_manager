import 'package:flutter/material.dart';
import 'package:my_state_manager/my_state_manager.dart';
import 'counter_controller.dart';

class CounterObxWidget extends StatelessWidget {
  const CounterObxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = RxControllerStore().find<CounterController>();

    return Obx(
      builder: () {
        return Text(
          'Count: ${controller.count.value}',
          style: const TextStyle(fontSize: 24),
        );
      },
    );
  }
}
