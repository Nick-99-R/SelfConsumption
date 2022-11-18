import 'package:flutter/material.dart';
import 'package:selfconsumption2/constants/global_variables.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_textfield.dart';
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

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  // void signInUser() {
  //   authService.signInUser(
  //     context: context,
  //     password: _passwordController.text,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              //   ListTile(
              //     tileColor: _auth == Auth.signup
              //         ? GlobalVariables.backgroundColor
              //         : GlobalVariables.greyBackgroundCOlor,
              //     title: const Text(
              //       'Create Account',
              //       style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     leading: Radio(
              //       activeColor: GlobalVariables.secondaryColor,
              //       value: Auth.signup,
              //       groupValue: _auth,
              //       onChanged: (Auth? val) {
              //         setState(() {
              //           _auth = val!;
              //         });
              //       },
              //     ),
              //   ),
              //   if (_auth == Auth.signup)
              //     Container(
              //       padding: const EdgeInsets.all(8),
              //       color: GlobalVariables.backgroundColor,
              //       child: Form(
              //         key: _signUpFormKey,
              //         child: Column(
              //           children: [
              //             CustomTextFieldEmail(
              //               controller: _emailController,
              //               hintText: 'Email',
              //             ),
              //             const SizedBox(height: 10),
              //             CustomTextFieldPassword(
              //               controller: _passwordController,
              //               hintText: 'Password',
              //             ),
              //             const SizedBox(height: 10),
              //             CustomButton(
              //               text: 'Sign Up',
              //               onTap: () {
              //                 if (_signUpFormKey.currentState!.validate()) {
              //                   signUpUser();
              //                 }
              //               },
              //             )
              //           ],
              //         ),
              //       ),
              //     ),
              //   ListTile(
              //     tileColor: _auth == Auth.signin
              //         ? GlobalVariables.backgroundColor
              //         : GlobalVariables.greyBackgroundCOlor,
              //     title: const Text(
              //       'Sign-In.',
              //       style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     leading: Radio(
              //       activeColor: GlobalVariables.secondaryColor,
              //       value: Auth.signin,
              //       groupValue: _auth,
              //       onChanged: (Auth? val) {
              //         setState(() {
              //           _auth = val!;
              //         });
              //       },
              //     ),
              //   ),
              //   if (_auth == Auth.signin)
              //     Container(
              //       padding: const EdgeInsets.all(8),
              //       color: GlobalVariables.backgroundColor,
              //       child: Form(
              //         key: _signInFormKey,
              //         child: Column(
              //           children: [
              //             CustomTextFieldEmail(
              //               controller: _emailController,
              //               hintText: 'Email',
              //             ),
              //             const SizedBox(height: 10),
              //             CustomTextFieldPassword(
              //               controller: _passwordController,
              //               hintText: 'Password',
              //             ),
              //             const SizedBox(height: 10),
              //             CustomButton(
              //               text: 'Sign In',
              //               onTap: () {
              //                 if (_signInFormKey.currentState!.validate()) {
              //                   signInUser();
              //                 }
              //               },
              //             )
              //           ],
              //         ),
              //       ),
              //     ),
            ],
          ),
        ),
      ),
    );
  }
}
