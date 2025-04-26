import 'package:flutter/material.dart';
import 'rx_observable.dart';

/// Reactive AsyncSnapshot<T?> với khả năng load/refresh
class RxAsync<T> extends RxObservable<AsyncSnapshot<T?>> {
  final Future<T?> Function() loadData;

  RxAsync({required this.loadData}) : super(const AsyncSnapshot.nothing());

  /// Gọi API và cập nhật state
  Future<void> load() async {
    // chuyển sang trạng thái loading
    value = AsyncSnapshot.withData(ConnectionState.waiting, null);
    try {
      final result = await loadData();
      // chuyển sang trạng thái done với data
      value = AsyncSnapshot.withData(ConnectionState.done, result);
    } catch (e, st) {
      // chuyển sang trạng thái error
      value = AsyncSnapshot.withError(ConnectionState.done, e, st);
    }
  }

  /// Bí danh cho load() khi cần refresh
  Future<void> refresh() => load();
}
