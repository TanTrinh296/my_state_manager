import 'package:flutter/widgets.dart';
import 'package:my_state_manager/core/async_state.dart';
import 'package:my_state_manager/core/enums/async_status.dart';
import 'package:my_state_manager/src/widgets/state_builder.dart';
class AsyncStateBuilder<T> extends StatelessWidget {
  final AsyncState<T> state;
  final Widget Function(BuildContext context) onLoading;
  final Widget Function(BuildContext context, T data) onSuccess;
  final Widget Function(BuildContext context, Object? error)? onError;
  final Widget Function(BuildContext context)? idle;

  const AsyncStateBuilder({
    super.key,
    required this.state,
    required this.onLoading,
    required this.onSuccess,
    this.onError,
    this.idle,
  });

  @override
  Widget build(BuildContext context) {
    return StateBuilder<T?>(
      observable: state,
      builder: (context, value) {
        switch (state.status) {
          case AsyncStatus.loading:
            return onLoading(context);
          case AsyncStatus.success:
            return onSuccess(context, value as T);
          case AsyncStatus.error:
            return onError?.call(context, state.error) ??
                Text('Error: ${state.error}');
          case AsyncStatus.idle:
            return idle?.call(context) ?? const SizedBox.shrink();
        }
      },
    );
  }
}
