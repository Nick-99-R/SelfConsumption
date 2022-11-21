import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/utils.dart';
import '../../auth/screens/auth_screen.dart';

class AccountServices {
  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // void updatePassword({
  //   required BuildContext context,
  //   required String password,
  // }) async {
  //   try {
  //     User user = User(id: '', password: password, token: '', email: '');

  //     http.Response res = await http.post(
  //       Uri.parse('$uri/api/signup'),
  //       body: user.toJson(),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //     );

  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         showSnackBar(
  //           context,
  //           'Account Erfolgreich erstellt',
  //         );
  //       },
  //     );
  //     logOut(context);
  //   }
  //   catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  //}
}
