import 'package:flutter/material.dart';
import 'package:selfconsumption2/features/account/screens/update_password_screen.dart';
import 'package:selfconsumption2/features/account/widgets/accoun_button.dart';

import '../services/account_services.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Your Orders',
              onTap: () {},
            ),
            AccountButton(
              text: 'Turn Seller',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              text: 'Log Out',
              onTap: () => AccountServices().logOut(context),
            ),
            AccountButton(
                text: 'Update Password',
                onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      UpdatePasswordScreen.routeName,
                      (route) => true,
                    )),
          ],
        ),
      ],
    );
  }
}
