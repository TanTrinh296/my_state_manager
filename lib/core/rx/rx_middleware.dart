import 'package:my_state_manager/core/rx/rx_observable.dart';

typedef RxInterceptor<T> = T Function(T oldValue, T newValue);

class RxMiddleware {
  static final _interceptors = <RxObservable, RxInterceptor>{};

  static void register<T>(RxObservable<T> rx, RxInterceptor<T> interceptor) {
    _interceptors[rx] = interceptor as RxInterceptor;
  }

  static T intercept<T>(RxObservable<T> rx, T oldValue, T newValue) {
    final interceptor = _interceptors[rx];
    if (interceptor != null) {
      return interceptor(oldValue, newValue);
    }
    return newValue;
  }

  static void unregister(RxObservable rx) {
    _interceptors.remove(rx);
  }
}
