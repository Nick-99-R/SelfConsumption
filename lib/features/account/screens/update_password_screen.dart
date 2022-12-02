import 'package:flutter/material.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_textfield.dart';
import '../../../constants/global_variables.dart';
import '../../auth/services/auth_service.dart';

class UpdatePasswordScreen extends StatefulWidget {
  static const String routeName = '/update-screen';
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _updateFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordRepeadController =
      TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _oldPasswordController.dispose();
    _newPasswordRepeadController.dispose();
  }

  void updatePassword() {
    authService.updatePassword(
        context: context,
        oldPassword: _oldPasswordController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: GlobalVariables.secondaryColor,
          title: const Text('Passwort updaten'),
        ),
        body: Padding(
          padding: EdgeInsets.all(size.height * 0.01),
          child: Form(
              key: _updateFormKey,
              child: Column(children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                CustomTextFieldPassword(
                  controller: _oldPasswordController,
                  hintText: 'Altes Passwort',
                  icon: Icons.security,
                  onPressed: () {},
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                CustomTextFieldPassword(
                  controller: _passwordController,
                  hintText: 'Neues Passwort',
                  icon: Icons.security,
                  onPressed: () {},
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                CustomTextFieldPassword(
                  controller: _newPasswordRepeadController,
                  hintText: 'Neues Passwort wiederholen',
                  icon: Icons.security,
                  onPressed: () {},
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                CustomButton(
                    buttonText: 'Passwort ändern',
                    callback: () {
                      if (_updateFormKey.currentState!.validate() &&
                          _newPasswordRepeadController.text ==
                              _passwordController.text) {
                        updatePassword();
                      } else if (_newPasswordRepeadController.text !=
                          _passwordController.text) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.black,
                          content: Text('Überprüfen sie das neue Passwort'),
                        ));
                      }
                    },
                    color: GlobalVariables.secondaryColor)
              ])),
        ));
  }
}
