import 'package:my_state_manager/core/rx/rx_controller.dart';

class RxControllerStore {
  static final RxControllerStore _instance = RxControllerStore._internal();
  factory RxControllerStore() => _instance;
  RxControllerStore._internal();

  final Map<String, dynamic> _store = {};

  String _getKey(Type type, dynamic tag) => '${type}_$tag';

  T put<T>(T instance, {dynamic tag}) {
    final key = _getKey(instance.runtimeType, tag ?? instance.runtimeType);
    if (instance is RxController) {
      instance.init(tag: tag?.toString());
    }
    _store[key] = instance;
    return instance;
  }

  T find<T>({dynamic tag}) {
    final key = _getKey(T, tag ?? T.toString());
    final instance = _store[key];
    if (instance == null) {
      throw Exception("Instance of type $T with tag '${tag ?? T.toString()}' not found.");
    }
    return instance as T;
  }

  void remove<T>({dynamic tag}) {
    final key = _getKey(T, tag ?? T.toString());
    final instance = _store.remove(key);
    if (instance is RxController) {
      instance.dispose();
    }
  }

  void clear() {
    for (var instance in _store.values) {
      if (instance is RxController) {
        instance.dispose();
      }
    }
    _store.clear();
  }
}
