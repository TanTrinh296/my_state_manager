import 'package:my_state_manager/core/enums/async_status.dart';

import 'observable.dart';



class AsyncState<T> extends Observable<T?> {
  AsyncStatus _status = AsyncStatus.idle;
  Object? _error;

  AsyncState([super.initialValue]);

  AsyncStatus get status => _status;
  Object? get error => _error;

  bool get isLoading => _status == AsyncStatus.loading;
  bool get hasData => _status == AsyncStatus.success && value != null;
  bool get hasError => _status == AsyncStatus.error;

  /// Bắt đầu gọi async và tự động cập nhật trạng thái
  Future<void> fetch(Future<T> Function() asyncTask) async {
    _status = AsyncStatus.loading;
    _error = null;
    notifyListener();

    try {
      final result = await asyncTask();
      value = result;
      _status = AsyncStatus.success;
    } catch (e) {
      _error = e;
      _status = AsyncStatus.error;
    }

    notifyListener();
  }

  /// Reset state về ban đầu
  void reset() {
    _status = AsyncStatus.idle;
    _error = null;
    value = null;
    notifyListener();
  }

  @override
  void notifyListener() {
    // Gọi lại notify để UI rebuild
    super.notifyListener();
  }
}
