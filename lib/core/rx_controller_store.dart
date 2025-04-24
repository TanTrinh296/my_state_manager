import 'rx_controller.dart';

class RxControllerStore {
  static final RxControllerStore _instance = RxControllerStore._internal();
  factory RxControllerStore() => _instance;
  RxControllerStore._internal();

  final Map<String, RxController> _controllers = {};

  /// Tạo key định danh từ type + optional tag
  String _getKey<T>(String? tag) => '${T.toString()}_${tag ?? 'default'}';

  /// Đăng ký controller
  T put<T extends RxController>(T controller, {String? tag}) {
    final key = _getKey<T>(tag);
    _controllers[key] = controller;
    controller.init();
    return controller;
  }

  /// Lấy controller
  T find<T extends RxController>({String? tag}) {
    final key = _getKey<T>(tag);
    final controller = _controllers[key];
    if (controller == null) {
      throw Exception("Controller of type $T with tag '$tag' not found.");
    }
    return controller as T;
  }

  /// Xoá controller
  void remove<T extends RxController>({String? tag}) {
    final key = _getKey<T>(tag);
    final controller = _controllers.remove(key);
    controller?.dispose();
  }

  /// Xoá toàn bộ
  void clear() {
    _controllers.forEach((_, controller) => controller.dispose());
    _controllers.clear();
  }
}
