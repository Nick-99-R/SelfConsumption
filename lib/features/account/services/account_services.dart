import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/utils.dart';
import '../../auth/screens/auth_screen.dart';

class AccountServices {
  void logOut(BuildContext context) async {
    try {
      final EncryptedSharedPreferences encryptedSharedPreferences =
          EncryptedSharedPreferences();
      //SharedPreferences sharedPreferences =
      //    await SharedPreferences.getInstance();
      await encryptedSharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
