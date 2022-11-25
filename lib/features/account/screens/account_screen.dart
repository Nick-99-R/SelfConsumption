import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selfconsumption2/common/widgets/custom_button.dart';
import 'package:selfconsumption2/constants/global_variables.dart';
import 'package:selfconsumption2/features/account/screens/update_password_screen.dart';
import 'package:selfconsumption2/features/account/widgets/accoun_button.dart';

import '../services/account_services.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key, required String title}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isActiveNewForyou = true;
  bool isActiveAccountActivity = true;
  bool isInActiveOpportunity = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Einstellungen'),
          backgroundColor: GlobalVariables.secondaryColor,
        ),
        body: Container(
          padding: EdgeInsets.only(
              left: size.width * 0.02,
              top: size.width * 0.02,
              right: size.width * 0.015),
          child: ListView(children: [
            SizedBox(height: size.width * 0.02),
            Row(
              children: [
                const Icon(Icons.person, color: Colors.green),
                SizedBox(
                  width: size.width * 0.01,
                ),
                Text('Account',
                    style: TextStyle(
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.bold))
              ],
            ),
            Divider(
              height: size.width * 0.035,
              thickness: 2,
            ),
            SizedBox(
              height: size.width * 0.025,
            ),
            buildAccountOptionRow(context, 'Passwort ändern', () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                UpdatePasswordScreen.routeName,
                (route) => true,
              );
            }),
            buildAccountOptionRow(
              context,
              'Einstellungen',
              (() {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Einstellungen'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text('Option 1'),
                            Text('Option 2'),
                            Text('Option 3'),
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Schließen'))
                        ],
                      );
                    });
              }),
            ),
            buildAccountOptionRow(context, 'Sprachen', () {}),
            buildAccountOptionRow(
                context, 'Privatsphäre und Sicherheit', () {}),
            SizedBox(
              height: size.width * 0.1,
            ),
            Row(
              children: [
                const Icon(Icons.volume_up_outlined, color: Colors.green),
                SizedBox(
                  width: size.width * 0.01,
                ),
                Text('Benachrichtigungen',
                    style: TextStyle(
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.bold))
              ],
            ),
            Divider(
              height: size.width * 0.035,
              thickness: 2,
            ),
            SizedBox(
              height: size.width * 0.025,
            ),
            buildNotificationOptionRow('data'),
            buildNotificationOptionRowAccountActivity('Aktivität'),
            buildNotificationOptionRowOpportunity('Möglichkeiten'),
            Expanded(
              child: Container(),
            ),
            Divider(
              height: size.width * 0.035,
              thickness: 2,
            ),
            SizedBox(
              height: size.width * 0.01,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: AccountButton(
                    text: 'Abmelden',
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: const Text('Abmelden'),
                                content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'Möchten Sie sich wirklich abmelden?',
                                      ),
                                      SizedBox(
                                        height: size.height * 0.015,
                                      ),
                                      CustomButton(
                                          buttonText: 'Abbrechen',
                                          callback: () {
                                            Navigator.of(context).pop();
                                          },
                                          color: GlobalVariables
                                              .greyBackgroundCOlor),
                                      SizedBox(
                                        height: size.height * 0.02,
                                      ),
                                      CustomButton(
                                          buttonText: 'Bestätigen',
                                          callback: () {
                                            AccountServices().logOut(context);
                                          },
                                          color: Colors.red),
                                    ]));
                          });
                    }))
          ]),
        ));
  }

  Row buildNotificationOptionRow(String title) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: size.width * 0.045,
                fontWeight: FontWeight.bold,
                color: Colors.grey)),
        SizedBox(
          width: size.width * 0.045,
        ),
        Transform.scale(
            scale: size.width * 0.0017,
            child: CupertinoSwitch(
              value: isActiveNewForyou,
              onChanged: (bool val) {
                setState(() {
                  isActiveNewForyou = val;
                });
              },
            )),
      ],
    );
  }

  Row buildNotificationOptionRowAccountActivity(String title) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: size.width * 0.045,
                fontWeight: FontWeight.bold,
                color: Colors.grey)),
        SizedBox(
          width: size.width * 0.045,
        ),
        Transform.scale(
            scale: size.width * 0.0017,
            child: CupertinoSwitch(
              value: isActiveAccountActivity,
              onChanged: (bool val) {
                setState(() {
                  isActiveAccountActivity = val;
                });
              },
            )),
      ],
    );
  }

  Row buildNotificationOptionRowOpportunity(String title) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: size.width * 0.045,
                fontWeight: FontWeight.bold,
                color: Colors.grey)),
        SizedBox(
          width: size.width * 0.045,
        ),
        Transform.scale(
            scale: size.width * 0.0017,
            child: CupertinoSwitch(
              value: isInActiveOpportunity,
              onChanged: (bool val) {
                setState(() {
                  isInActiveOpportunity = val;
                });
              },
            )),
      ],
    );
  }

  InkWell buildAccountOptionRow(
      BuildContext context, String title, Function callback) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () => callback(),

      // (() {
      //   showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return AlertDialog(
      //           title: Text(title),
      //           content: Column(
      //             mainAxisSize: MainAxisSize.min,
      //             children: const [
      //               Text('Option 1'),
      //               Text('Option 2'),
      //               Text('Option 3'),
      //             ],
      //           ),
      //           actions: [
      //             TextButton(
      //                 onPressed: () {
      //                   Navigator.of(context).pop();
      //                 },
      //                 child: const Text(close))
      //           ],
      //         );
      //       });
      // }),

      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600])),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
