import 'dart:async';
import 'package:flutter/foundation.dart';

class RxDebounce<T> extends ValueNotifier<T> {
  final Duration duration;
  Timer? _timer;
  void Function(T value)? _onDebounced;

  RxDebounce(
    super.value, {
    required this.duration,
  });

  /// Gán callback sẽ gọi sau khi debounce hoàn tất
  void listen(void Function(T value) callback) {
    _onDebounced = callback;
  }

  /// Cập nhật giá trị và thực hiện debounce
  void debounce(T newValue) {
    _timer?.cancel();
    value = newValue;

    _timer = Timer(duration, () {
      if (_onDebounced != null) {
        _onDebounced!(value);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
