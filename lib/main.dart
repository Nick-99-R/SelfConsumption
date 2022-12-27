import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selfconsumption2/common/widgets/bottom_bar.dart';
import 'package:selfconsumption2/features/auth/screens/auth_screen.dart';
import 'package:selfconsumption2/constants/global_variables.dart';
import 'package:selfconsumption2/features/auth/services/auth_service.dart';
import 'package:selfconsumption2/providers/user_provider.dart';
import 'package:selfconsumption2/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        supportedLocales: const [
          Locale('in', 'IN'),
          Locale('en', 'US'),
          Locale('de', 'DE'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocaleLanguage in supportedLocales) {
            if (supportedLocaleLanguage.languageCode == locale!.languageCode &&
                supportedLocaleLanguage.countryCode == locale.countryCode) {
              return supportedLocaleLanguage;
            }
          }
          return supportedLocales.first;
        },
        theme: ThemeData(
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
            colorScheme: const ColorScheme.light(
              primary: GlobalVariables.secondaryColor,
            ),
            appBarTheme: const AppBarTheme(
                elevation: 0, iconTheme: IconThemeData(color: Colors.black))),
        onGenerateRoute: ((settings) => generateRoute(settings)),
        home: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? const BottomBar()
            : const AuthScreen());
  }
}
