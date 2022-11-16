import 'package:flutter/material.dart';
import 'package:selfconsumption2/common/widgets/bottom_bar.dart';
import 'package:selfconsumption2/features/auth/screens/auth_screen.dart';
import 'package:selfconsumption2/features/home/screens/home_screens.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
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
