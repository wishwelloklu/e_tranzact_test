import 'package:etranzazct_test/app/routes/route_type.dart';
import 'package:etranzazct_test/features/auth/presentation/pages/login/login_page.dart';
import 'package:etranzazct_test/features/auth/presentation/pages/sign_up/sign_up_page.dart';
import 'package:etranzazct_test/features/home/presentation/pages/home.dart';
import 'package:flutter/material.dart';

import 'app_routes.dart';

class Routes {
  static Map<String, RouteType> _resolveRoutes() {
    return {
      AppRoutes.login: (context, settings) => const LoginPage(),
      AppRoutes.signup: (context, settings) => const SignUpPage(),
      AppRoutes.home: (context, settings) => const Home(),
    };
  }

  static Route onGenerateRoutes(RouteSettings settings) {
    var routes = _resolveRoutes();
    final RouteType? child = routes[settings.name];

    if (child == null) {
      throw const FormatException("--- Route doesn't exist");
    }

    Widget builder(BuildContext context) {
      return child(context, settings);
    }

    return MaterialPageRoute(
      builder: (context) => builder(context),
      settings: settings, // Pass settings including arguments
    );
  }
}
