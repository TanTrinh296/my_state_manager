import 'dart:developer';

abstract class RxController {
  /// Được gọi khi controller được khởi tạo
  void onInit() {
    log("Controller ready!");
  }

  /// Được gọi khi controller bị huỷ
  void onClose() {
    log("Controller destroyed!");
  }

  bool _initialized = false;

  void init() {
    if (!_initialized) {
      _initialized = true;
      onInit();
    }
  }

  void dispose() {
    if (_initialized) {
      _initialized = false;
      onClose();
    }
  }
}
