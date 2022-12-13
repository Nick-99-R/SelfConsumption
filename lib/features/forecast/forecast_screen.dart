import 'package:f_datetimerangepicker/f_datetimerangepicker.dart';
import 'package:flutter/material.dart';
import 'package:selfconsumption2/constants/global_variables.dart';
import 'package:selfconsumption2/features/forecast/chart/forecast_chart.dart';

import '../../constants/strings.dart';

bool showInitialChart = true;
bool tapState = false;
DateTime endInput =
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
DateTime now = DateTime.now();

class ForeCastScreen extends StatelessWidget {
  const ForeCastScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: GlobalVariables.secondaryColor,
        title: Text(
          'Prognose',
          style: themeData.textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: size.height * 0.02),
        ),
        elevation: 0,
      ),
      body: const SelfConsumptionPage(),
    );
  }
}

class SelfConsumptionPage extends StatefulWidget {
  const SelfConsumptionPage({Key? key}) : super(key: key);

  @override
  _SelfConsumptionPageState createState() => _SelfConsumptionPageState();
}

class _SelfConsumptionPageState extends State<SelfConsumptionPage> {
  Color baseColor = const Color(0xFFF2F2F2);

  @override
  void initState() {
    super.initState();

    /// Listen to any changes in the fields values
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.02, right: size.width * 0.02),
            child: Column(children: [
              OutlinedButton.icon(
                // <-- OutlinedButton
                onPressed: () {
                  DateTimeRangePicker(
                      startText: "Von",
                      endText: "Bis",
                      doneText: "Bestätigen",
                      cancelText: "Abbrechen",
                      interval: 15,
                      initialStartTime:
                          DateTime.now().add(const Duration(hours: 1)),
                      initialEndTime:
                          DateTime.now().add(const Duration(days: 1)),
                      mode: DateTimeRangePickerMode.dateAndTime,
                      minimumTime: DateTime.now(),
                      maximumTime: DateTime.now().add(const Duration(days: 3)),
                      use24hFormat: true,
                      onConfirm: (start, end) {
                        setState(() {
                          endInput = end;
                          now = start;
                        });
                      }).showPicker(context);
                },
                icon: const Icon(
                  Icons.calendar_today,
                  size: 24.0,
                ),
                label: const Text('Zeitraum auswählen'),
              ),
              InkResponse(
                onTap: () {
                  if (endInput.isBefore(DateTime.now())) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(invalidDateInput,
                          style: themeData.textTheme.bodyText1),
                    ));
                    // display default chart if the user enters a
                    // invalid date
                    showInitialChart = true;
                    setState(() {});
                  } else {
                    _toggleState();
                    _toggleTapState();
                    setState(() {});
                  }
                },
                child: Container(
                  height: size.height * 0.05,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                    color: GlobalVariables.secondaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(loadDiagramm,
                        style: themeData.textTheme.headline1!.copyWith(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4)),
                  ),
                ),
              ),
              Expanded(
                  // child: showInitialChart || tapState && !tapState
                  //     ? ForeCastChart(ForeCastChart.createChartInitial())
                  //     : ForeCastChart(ForeCastChart.createNewChart()
                  child: ForeCastChart(ForeCastChart.createChartInitial())),
              SizedBox(height: size.height * 0.03),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.bottomRight,
                    height: size.height * 0.035,
                    width: size.width * 0.035,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Text(
                    shareOfTotalProduction,
                    style: themeData.textTheme.bodyText1,
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
            ])));
  }

  // Initial State == Defaul Chart (Until tomorrow)
  // If data is entered, state changes to false
  void _toggleState() {
    setState(() {
      (now == DateTime.now()) &&
              endInput ==
                  DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day + 1)
          ? showInitialChart = true
          : showInitialChart = false;
    });
  }

// Everytime the button is clicked, CreateNewChart() should be
// fired again
  void _toggleTapState() {
    setState(() {
      !tapState ? tapState = true : tapState = false;
    });
  }
}
