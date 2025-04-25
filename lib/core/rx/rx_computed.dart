import 'rx_observable.dart';

class RxComputed<T> extends RxObservable<T> {
  final T Function() compute;
  final List<RxObservable> dependencies;

  RxComputed(this.compute, this.dependencies) : super(compute()) {
    for (var dep in dependencies) {
      dep.subscribe((_) => _recompute());
    }
  }

  void _recompute() {
    super.value = compute(); // Gọi setter để thông báo thay đổi
  }

  @override
  set value(T _) {
    throw Exception("RxComputed is readonly.");
  }
}
