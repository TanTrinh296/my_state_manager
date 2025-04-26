import 'rx_observable.dart';

class RxEffect {
  static void once<T>(RxObservable<T> rx, void Function(T value) effect) {
    void listener(T value) {
      effect(value);
      rx.unsubscribe(listener); // chỉ chạy 1 lần
    }

    rx.subscribe(listener);
  }

  static void listen<T>(RxObservable<T> rx, void Function(T value) effect) {
    rx.subscribe(effect);
  }
}
