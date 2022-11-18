import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';


DateTime prevMonthFromNow =
    DateTime(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day);
var confirmedStartDateString = formatDateUSA(prevMonthFromNow);

class DateStartPicker extends StatefulWidget {
  const DateStartPicker({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DateStartPickerState();
  }
}

class _DateStartPickerState extends State<DateStartPicker> {
  final TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text =
        formatDateEU(prevMonthFromNow); //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    return Scaffold(
        body: Center(
            child: SizedBox(
      height: size.height * 0.2,
      child: TextField(
        controller: dateInput,
        decoration: InputDecoration(
            icon: Icon(
              Icons.calendar_today,
              color: themeData.iconTheme.color,
            ),
            labelText: 'Start Datum eingeben',
            labelStyle: const TextStyle(color: Colors.black)),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            locale: const Locale('de'),
            context: context,
            initialDate: prevMonthFromNow,
            firstDate: DateTime(1950),
            lastDate: DateTime(2100),
          );

          if (pickedDate != null) {
            String? formattedDate = formatDateEU(pickedDate);

            setState(() {
              dateInput.text = formattedDate;
            });
            confirmedStartDateString = formatDateUSA(pickedDate);
          } else {}
        },
      ),
    )));
  }
}

// Two formatter are needed
// 1. formatDateEu for better readability
// 2. For chart, so no DateTimeException is thrown
String formatDateEU(DateTime input) {
  String confirmedString = DateFormat('dd.MM.yyyy').format(input);
  return confirmedString;
}

String formatDateUSA(DateTime input) {
  String confirmedString = DateFormat('yyyy-MM-dd').format(input);
  return confirmedString;
}