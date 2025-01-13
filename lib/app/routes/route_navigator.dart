import 'package:flutter/material.dart';

routeNavigator(BuildContext context, String routeName, [dynamic arguments]) {
  Navigator.pushNamed(context, routeName, arguments: arguments);
}

routeAndRemoveNavigator(BuildContext context, String routeName,
    [dynamic arguments]) {
  Navigator.of(context).pushNamedAndRemoveUntil(
      routeName, (Route<dynamic> route) => false,
      arguments: arguments);
}

popBack(BuildContext context, [dynamic data]) {
  Navigator.pop(context, data);
}
