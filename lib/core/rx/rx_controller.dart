import 'dart:developer';

abstract class RxController {
  String? tag; // Thêm tag tùy chọn

  /// Được gọi khi controller được khởi tạo
  void onInit() {
    log("Controller ${runtimeType.toString()} ready!${tag != null ? ' (Tag: $tag)' : ''}");
  }

  /// Được gọi khi controller bị huỷ
  void onClose() {
    log("Controller ${runtimeType.toString()} destroyed!${tag != null ? ' (Tag: $tag)' : ''}");
  }

  bool _initialized = false;

  void init({String? tag}) {
    this.tag = tag; // Gán tag nếu có
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
