import 'package:flutter/widgets.dart';
import 'package:my_state_manager/core/rx/rx_async.dart';

/// Giống FutureBuilder/StreamBuilder nhưng dùng RxAsync & có callback refresh
typedef AsyncRefreshWidgetBuilder<T> = Widget Function(
    BuildContext context,
    AsyncSnapshot<T?> snapshot,
    Future<void> Function() refresh,
    );

class RxAsyncBuilder<T> extends StatefulWidget {
  /// RxAsync quản lý API call
  final RxAsync<T> rxAsync;

  /// builder(context, snapshot, refresh)
  final AsyncRefreshWidgetBuilder<T> builder;

  /// Nếu true thì tự động gọi load() ở initState
  final bool autoLoad;

  const RxAsyncBuilder({
    Key? key,
    required this.rxAsync,
    required this.builder,
    this.autoLoad = true,
  }) : super(key: key);

  @override
  State<RxAsyncBuilder<T>> createState() => _RxAsyncBuilderState<T>();
}

class _RxAsyncBuilderState<T> extends State<RxAsyncBuilder<T>> {
  @override
  void initState() {
    super.initState();
    widget.rxAsync.subscribe(_listener);
    if (widget.autoLoad) widget.rxAsync.load();
  }

  void _listener(_) {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget.rxAsync.unsubscribe(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.rxAsync.value, widget.rxAsync.load);
  }
}
