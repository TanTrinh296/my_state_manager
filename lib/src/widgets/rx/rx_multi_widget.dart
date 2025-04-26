import 'package:flutter/widgets.dart';
import 'package:my_state_manager/core/rx/rx_controller.dart';
import 'package:my_state_manager/core/rx/rx_controller_store.dart';

class RxMultiWidget extends StatefulWidget {
  final List<RxController Function()> controllers;
  final WidgetBuilder builder;

  const RxMultiWidget({
    super.key,
    required this.controllers,
    required this.builder,
  });

  @override
  State<RxMultiWidget> createState() => _RxMultiWidgetState();
}

class _RxMultiWidgetState extends State<RxMultiWidget> {
  final List<_ControllerEntry> _entries = [];

  @override
  void initState() {
    super.initState();
    for (var create in widget.controllers) {
      final controller = create();
      final type = controller.runtimeType.toString();
      final tag = type;
      _entries.add(_ControllerEntry(type, tag));
      RxControllerStore().put(controller, tag: tag);
    }
  }

  @override
  void dispose() {
    for (var entry in _entries) {
      RxControllerStore().remove(tag: entry.tag);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}

class _ControllerEntry {
  final String type;
  final String tag;

  _ControllerEntry(this.type, this.tag);
}
