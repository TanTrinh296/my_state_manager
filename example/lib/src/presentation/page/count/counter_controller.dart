import 'package:my_state_manager/my_state_manager.dart';

class CounterController extends RxController {
  final count = RxObservable(0);

  void increment() => count.value++;
}
