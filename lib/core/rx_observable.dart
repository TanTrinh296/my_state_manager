// src/rx_observable.dart
typedef ObservableListener<T> = void Function(T value);

class RxObservable<T> {
  T _value;
  final Set<ObservableListener<T>> _listeners = {};

  static void Function(RxObservable)? registerObserver;

  RxObservable(this._value);

  T get value {
    registerObserver?.call(this);
    return _value;
  }

  set value(T newValue) {
    if (_value != newValue) {
      _value = newValue;
      _notify();
    }
  }

  void subscribe(ObservableListener<T> listener) => _listeners.add(listener);
  void unsubscribe(ObservableListener<T> listener) => _listeners.remove(listener);

  void _notify() {
    for (var listener in _listeners) {
      listener(_value);
    }
  }
}