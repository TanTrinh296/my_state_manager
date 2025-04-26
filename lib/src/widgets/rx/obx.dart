// src/obx.dart
import 'package:flutter/widgets.dart';
import 'package:my_state_manager/core/rx/rx_observable.dart';

class Obx extends StatelessWidget {
  final Widget Function() builder;
  const Obx({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return _ObxWrapper(builder: builder);
  }
}

class _ObxWrapper extends StatefulWidget {
  final Widget Function() builder;
  const _ObxWrapper({required this.builder});

  @override
  State<_ObxWrapper> createState() => _ObxWrapperState();
}

class _ObxWrapperState extends State<_ObxWrapper> {
  final Set<RxObservable> _subscriptions = {};

  @override
  void dispose() {
    for (var obs in _subscriptions) {
      obs.unsubscribe(_onChange);
    }
    super.dispose();
  }

  void _onChange(dynamic _) {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Clear old subscriptions
    for (var obs in _subscriptions) {
      obs.unsubscribe(_onChange);
    }
    _subscriptions.clear();

    // Set global observer to track accessed RxObservable
    RxObservable.registerObserver = (RxObservable obs) {
      if (!_subscriptions.contains(obs)) {
        obs.subscribe(_onChange);
        _subscriptions.add(obs);
      }
    };

    // Build UI once while tracking RxObservable used
    final built = widget.builder();

    // Disable tracking
    RxObservable.registerObserver = null;

    return built;
  }
}
