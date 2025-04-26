
# 🌀 My State Manager

Một package Flutter nhẹ, linh hoạt và phản ứng (reactive) cho việc quản lý state — được xây dựng từ đầu mà không sử dụng bất kỳ thư viện quản lý state nào trên pub.dev, lấy cảm hứng từ GetX.

---

## ✨ Tính năng nổi bật

✅ Quản lý state đơn giản và phản ứng với `.rx`  
✅ Hỗ trợ `RxNullable`, `RxAsync`, `RxComputed`, `RxEffect`  
✅ Quản lý vòng đời controller với `RxController`  
✅ Hệ thống dependency injection (`put`, `find`, `remove`)  
✅ Widget builder: `Obx`, `RxAsyncBuilder`, `RxMultiWidget`  
✅ Hỗ trợ middleware & tự động huỷ controller  
✅ Không cần `BuildContext` — truy cập logic từ mọi nơi!

---

## 🚀 Bắt đầu sử dụng

### 1. Thêm dependency vào `pubspec.yaml`

```yaml
dependencies:
  my_state_manager:
    path: ../my_state_manager
```

---

## 🧠 Các khái niệm cốt lõi

### 🔹 Tạo biến phản ứng (reactive)

```dart
final counter = 0.obs;
final name = RxNullable<String>();
final list = <String>[].rx;
```

---

### 🔹 Cập nhật giá trị

```dart
counter.value++;
name.value = "Flutter";
list.value.add("New Item");
```

---

### 🔹 Theo dõi và render lại UI với `Rx`

```dart
Obx(builder: () => Text("Counter: ${counter.value}"));
```

---

## 🎯 RxController

### Định nghĩa controller

```dart
class CounterController extends RxController {
  final counter = 0.rx;

  void increment() => counter.value++;
}
```

### Khởi tạo controller

```dart
final controller = RxControllerStore().put(CounterController());
```

### Sử dụng trong widget

```dart
final controller = RxControllerStore().find<CounterController>();

Obx(builder: () => Text('Count: ${controller.counter.value}'));
```

---

## ⏳ RxAsync – Quản lý Future/API gọi bất đồng bộ

```dart
final user = RxAsync<User>(loadData: api.getUser)..load();

RxAsyncBuilder(
  rxAsync: user,
  builder: (snapshot) {
    if (snapshot.hasData) return Text(snapshot.data!.name);
    if (snapshot.hasError) return Text("Lỗi xảy ra");
    return CircularProgressIndicator();
  },
);
```

---

## 🧮 RxComputed – Giá trị dẫn xuất tự động cập nhật

```dart
final firstName = 'John'.rx;
final lastName = 'Doe'.rx;

final fullName = RxComputed(() => '${firstName.value} ${lastName.value}');

firstName.value = "Jane";
print(fullName.value); // => Jane Doe
```

```dart
Obx(builder: () => Text(fullName.value));
```

---

## 🔁 RxEffect – Lắng nghe và chạy hiệu ứng phụ

```dart
void main() {
  final counter = 0.rx;

  RxEffect.once(counter, (val) {
    print("🔥 Counter được tăng lần đầu tiên: $val");
  });

  RxEffect.listen(counter, (val) {
    print("🧭 Counter hiện tại: $val");
  });

  counter.value = 1;
  counter.value = 2;
}
```

---

## 🧩 Quản lý phụ thuộc (Dependency)

### Gán instance

```dart
RxControllerStore().put<UserInterface>(UserRepo());
```

### Tìm lại instance

```dart
final userApi = RxControllerStore().find<UserRepo>();
```

---

## 🔧 Middleware / Vòng đời

- `onInit()` – gọi khi controller được khởi tạo
- `onClose()` – gọi khi bị huỷ
- Hỗ trợ middleware để can thiệp thay đổi (đang phát triển)

---

## 🧹 Dọn dẹp tài nguyên

```dart
RxControllerStore().remove<CounterController>();
RxControllerStore().clear();
```

---

## 🧪 Dự án ví dụ

Xem thư mục `example/` để khám phá một ứng dụng Flutter sử dụng gói này.

---

## 📦 Lộ trình phát triển

- [x] Quản lý state phản ứng
- [x] Async + computed state
- [x] Dependency injection
- [ ] UI debug tool (trình theo dõi state)
- [ ] CLI cho devtool
- [ ] Lưu trữ state (tích hợp Hive/Isar)

---

## 🤝 Đóng góp

Thoải mái fork, mở issue hoặc gửi PR. Gói này được xây dựng **vì cộng đồng, cho cộng đồng**.

---

## 📄 Giấy phép

MIT © 2025 Minh Tân
