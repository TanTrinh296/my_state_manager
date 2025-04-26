// src/rx_observable.dart
import 'package:my_state_manager/core/debug/rx_benchmark.dart';
import 'package:my_state_manager/core/rx/rx_middleware.dart';

typedef ObservableListener<T> = void Function(T value);

class RxObservable<T> {
  T _value;
  final Set<ObservableListener<T>> _listeners = {};

  static void Function(RxObservable)? registerObserver;
  final String? debugLabel;
  RxObservable(this._value, {this.debugLabel});

  T get value {
    registerObserver?.call(this);
    return _value;
  }

  set value(T newValue) {
    final intercepted = RxMiddleware.intercept(this, _value, newValue);
    if (_value != intercepted) {
      final sw = Stopwatch()..start();
      _value = intercepted;
      _notify();
      sw.stop();
      RxBenchmark.trackUpdate(debugLabel ?? runtimeType.toString(), sw.elapsed);
    }
  }

  void subscribe(ObservableListener<T> listener) => _listeners.add(listener);
  void unsubscribe(ObservableListener<T> listener) =>
      _listeners.remove(listener);

  void _notify() {
    for (var listener in _listeners) {
      listener(_value);
    }
  }
}
