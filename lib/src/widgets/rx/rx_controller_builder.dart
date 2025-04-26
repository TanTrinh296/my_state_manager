import 'package:flutter/widgets.dart';
import 'package:my_state_manager/core/rx/rx_controller.dart';
import 'package:my_state_manager/core/rx/rx_controller_store.dart';

typedef ControllerBuilder<T extends RxController> = Widget Function(T controller);

class RxControllerBuilder<T extends RxController> extends StatefulWidget {
  final T Function() init;
  final ControllerBuilder<T> builder;
  final String? tag;
  final bool autoRemove;

  const RxControllerBuilder({
    super.key,
    required this.init,
    required this.builder,
    this.tag,
    this.autoRemove = true,
  });

  @override
  State<RxControllerBuilder<T>> createState() => _RxControllerBuilderState<T>();
}

class _RxControllerBuilderState<T extends RxController> extends State<RxControllerBuilder<T>> {
  late T _controller;

  @override
  void initState() {
    super.initState();
    _controller = RxControllerStore().put<T>(widget.init(), tag: widget.tag);
  }

  @override
  void dispose() {
    if (widget.autoRemove) {
      RxControllerStore().remove<T>(tag: widget.tag);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_controller);
  }
}
