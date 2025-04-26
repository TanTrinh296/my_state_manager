import 'package:flutter/widgets.dart';
import 'package:my_state_manager/core/observable.dart';
import 'package:my_state_manager/my_state_manager.dart';
class StateBuilder<T> extends StatefulWidget {
  final Observable<T> observable;
  final Widget Function(BuildContext context, T value) builder;

  const StateBuilder({
    super.key,
    required this.observable,
    required this.builder,
  });

  @override
  State<StateBuilder<T>> createState() => _StateBuilderState<T>();
}

class _StateBuilderState<T> extends State<StateBuilder<T>> {
  late T _value;

  @override
  void initState() {
    super.initState();
    _value = widget.observable.value;
    widget.observable.listen(_listener);
  }

  void _listener(T newValue) {
    setState(() {
      _value = newValue;
    });
  }

  @override
  void dispose() {
    widget.observable.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _value);
  }
}
