import 'package:flutter/material.dart';
import 'package:selfconsumption2/common/widgets/bottom_bar.dart';
import 'package:selfconsumption2/features/account/screens/update_password_screen.dart';
import 'package:selfconsumption2/features/auth/screens/auth_screen.dart';
import 'package:selfconsumption2/features/self_consumption/screens/self_consumption_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case SelfConsumptionScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SelfConsumptionScreen(),
      );
    case UpdatePasswordScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const UpdatePasswordScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Seite existiert nicht'),
                ),
              ));
  }
}
