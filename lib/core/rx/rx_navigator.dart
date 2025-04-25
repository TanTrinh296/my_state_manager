import 'package:flutter/material.dart';

class RxNavigator {
  static final RxNavigator _instance = RxNavigator._internal();

  factory RxNavigator() => _instance;

  RxNavigator._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final Map<String, dynamic> _arguments = {};

  void setArguments(dynamic args) {
    _arguments.clear();
    _arguments['value'] = args;
  }

  T arguments<T>() {
    return _arguments['value'] as T;
  }

  void clear() {
    _arguments.clear();
  }

  Future<T?> pushWithArgs<T extends Object?>(
      Widget page, {
        dynamic arguments,
      }) {
    if (arguments != null) {
      setArguments(arguments);
    }

    return navigatorKey.currentState!.push<T>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void back<T extends Object?>([T? result]) {
    navigatorKey.currentState?.pop(result);
  }

  void backUntil(bool Function(Route<dynamic>) predicate) {
    navigatorKey.currentState?.popUntil(predicate);
  }
}
