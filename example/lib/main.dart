import 'package:example/src/infrastructure/data/local_database/isar_config.dart';
import 'package:example/src/presentation/page/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:my_state_manager/core/debug/rx_benchmark.dart';
import 'package:my_state_manager/my_state_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarConfig().init();
  RxBenchmark.enabled = true;
  RxBenchmark.summary();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: RxNavigator().navigatorKey,
      home: HomePage(),
    );
  }
}
