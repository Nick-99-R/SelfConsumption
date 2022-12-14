import 'package:flutter/material.dart';

import 'date_start_picker.dart';

var confirmedEndDateString = formatDateUSA(DateTime.now());

class DateEndPicker extends StatefulWidget {
  const DateEndPicker({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DateEndPickerState();
  }
}

class _DateEndPickerState extends State<DateEndPicker> {
  final TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text =
        formatDateEU(DateTime.now()); //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    return Scaffold(
        body: Center(
            child: SizedBox(
      height: size.height,
      child: TextField(
        controller: dateInput,
        decoration: InputDecoration(
            icon: Icon(
              Icons.calendar_today,
              color: themeData.iconTheme.color,
            ),
            labelText: 'Enddatum eingeben',
            labelStyle: const TextStyle(color: Colors.black)),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            locale: const Locale('de'),
            context: context,
            initialDate: DateTime.now(),
            firstDate: oneYearAgo,
            lastDate: oneYearAfter,
          );

          if (pickedDate != null) {
            String formattedDate = formatDateEU(pickedDate);

            setState(() {
              dateInput.text = formattedDate;

              confirmedEndDateString = formatDateUSA(pickedDate);
            });
          } else {}
        },
      ),
    )));
  }
}
