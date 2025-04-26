import 'package:flutter/material.dart';
import 'package:my_state_manager/core/rx/rx_controller.dart';
import 'package:my_state_manager/core/rx/rx_controller_store.dart';

/// RxStatelessWidget giống như GetView
class RxStatelessWidget<T extends RxController> extends StatelessWidget {
  final Widget Function(BuildContext context, T controller) builder;

  const RxStatelessWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    // Lấy controller từ RxControllerStore
    final controller = RxControllerStore().find<T>();
    // Trả về builder với controller
    return builder(context, controller);
  }
}
