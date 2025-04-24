import 'observable.dart';

class StateStore {
  static final StateStore _instance = StateStore._internal();
  factory StateStore() => _instance;
  StateStore._internal();

  final Map<String, Observable> _store = {};

  /// Tạo hoặc lấy state theo key
  Observable<T> use<T>(String key, T initialValue) {
    if (_store.containsKey(key)) {
      return _store[key] as Observable<T>;
    } else {
      final observable = Observable<T>(initialValue);
      _store[key] = observable;
      return observable;
    }
  }

  /// Lấy state nếu đã có, null nếu chưa
  Observable<T>? get<T>(String key) {
    return _store[key] as Observable<T>?;
  }

  /// Xóa state
  void remove(String key) {
    _store.remove(key);
  }

  /// Reset toàn bộ
  void clear() {
    _store.clear();
  }
}
