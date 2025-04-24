import 'package:flutter/material.dart';
import 'package:my_state_manager/core/rx_observable.dart';

class RxAsync<T> extends RxObservable<AsyncSnapshot<T>> {
  RxAsync() : super(const AsyncSnapshot.nothing());

  Future<void> load(Future<T> future) async {
    dynamic defaultVal;
    value = AsyncSnapshot.withData(ConnectionState.waiting, defaultVal);
    try {
      final result = await future;
      value = AsyncSnapshot.withData(ConnectionState.done, result);
    } catch (e) {
      value = AsyncSnapshot.withError(ConnectionState.done, e);
    }
  }
}
