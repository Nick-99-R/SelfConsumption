import 'package:flutter/material.dart';
import 'package:selfconsumption2/constants/global_variables.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_textfield.dart';
import '../services/auth_service.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MincentApp'),
        backgroundColor: GlobalVariables.secondaryColor,
      ),
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                tileColor: _auth == Auth.signup
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Account erstellen',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signup)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextFieldEmail(
                          controller: _emailController,
                          hintText: 'Email',
                          icon: Icons.email,
                        ),
                        SizedBox(height: size.height * 0.01),
                        CustomTextFieldPassword(
                          controller: _passwordController,
                          hintText: 'Passwort',
                          icon: Icons.security,
                          onPressed: () {},
                        ),
                        SizedBox(height: size.height * 0.01),
                        Padding(
                          padding: EdgeInsets.only(
                              left: size.height * 0.1,
                              right: size.height * 0.1),
                          child: CustomButton(
                              buttonText: 'Registrieren',
                              callback: () {
                                if (_signUpFormKey.currentState!.validate()) {
                                  signUpUser();
                                }
                              },
                              color: GlobalVariables.secondaryColor),
                        )
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor: _auth == Auth.signin
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Einloggen',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signin,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signin)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        CustomTextFieldEmail(
                          controller: _emailController,
                          hintText: 'Email',
                          icon: Icons.email,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFieldPassword(
                          controller: _passwordController,
                          hintText: 'Passwort',
                          icon: Icons.security,
                          onPressed: () {},
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.only(
                              left: size.height * 0.1,
                              right: size.height * 0.1),
                          child: CustomButton(
                              buttonText: 'Einloggen',
                              callback: () {
                                if (_signInFormKey.currentState!.validate()) {
                                  signInUser();
                                }
                              },
                              color: GlobalVariables.secondaryColor),
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
