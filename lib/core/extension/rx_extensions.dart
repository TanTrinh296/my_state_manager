import 'package:my_state_manager/core/rx_observable.dart';

extension RxExtension<T> on T {
  RxObservable<T> get obs => RxObservable<T>(this);
}
