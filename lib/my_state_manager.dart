import 'dart:collection';

export 'package:my_state_manager/widgets/state_builder.dart';
typedef Listener<T> = void Function(T value);

class Observable<T> {
  T _value;
  final Set<Listener<T>> _listeners = HashSet();

  Observable(this._value);

  /// Lấy giá trị hiện tại
  T get value => _value;

  /// Gán giá trị mới và notify nếu khác
  set value(T newValue) {
    if (_value != newValue) {
      _value = newValue;
      _notify();
    }
  }

  /// Đăng ký lắng nghe thay đổi
  void listen(Listener<T> listener) {
    _listeners.add(listener);
  }

  /// Hủy đăng ký lắng nghe
  void removeListener(Listener<T> listener) {
    _listeners.remove(listener);
  }

  /// Hủy tất cả lắng nghe (dùng khi dispose)
  void dispose() {
    _listeners.clear();
  }

  /// Notify tất cả listener
  void _notify() {
    for (var listener in _listeners) {
      listener(_value);
    }
  }
}
