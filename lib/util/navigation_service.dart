import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  dynamic pop({dynamic data}) {
    return _navigationKey.currentState.pop(data);
  }

  Future<dynamic> push(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplace(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  void pushAndRemoveUntil(String routeName, {dynamic arguments}) {
    _navigationKey.currentState.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => route.isFirst,
        arguments: arguments);
  }
}
