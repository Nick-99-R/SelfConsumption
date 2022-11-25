import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';

class SelfConsumptionService {
  // get user data
  void getPlantOutput(
      // BuildContext context,
      ) async {
    // try {
    await http.get(
      Uri.parse('$uri/plant/output'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
  //catch (e) {
  //  showSnackBar(context, e.toString());
  //}
}
//}
