import 'package:my_state_manager/core/rx/rx_nullable.dart';
import 'package:my_state_manager/core/rx/rx_observable.dart';

extension RxExtension<T> on T {
  /// Biến thường → RxObservable (non-nullable)
  RxObservable<T> get rx => RxObservable<T>(this);
  RxObservable<T> debug(String label) => RxObservable<T>(this, debugLabel: label);
}

extension RxnExtension<T> on T? {
  /// Biến nullable → RxNullable (nullable)
  RxNullable<T> get rxn => RxNullable<T>(this);
}
