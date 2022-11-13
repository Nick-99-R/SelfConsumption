import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selfconsumption2/providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "./Home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
        body: Center(
      child: Text(
        user.toJson(),
      ),
    ));
  }
}
