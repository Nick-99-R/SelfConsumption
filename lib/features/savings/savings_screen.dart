import 'package:flutter/material.dart';
import 'package:selfconsumption2/constants/global_variables.dart';
import 'package:selfconsumption2/constants/strings.dart';

import '../../common/widgets/charts/chart_initial.dart';
import '../self_consumption/date_picker/date_end_picker.dart';
import '../self_consumption/date_picker/date_start_picker.dart';
import '../self_consumption/screens/self_consumption_screen.dart';

class SavingsScreen extends StatefulWidget {
  const SavingsScreen({Key? key}) : super(key: key);

  @override
  State<SavingsScreen> createState() => _SavingsScreenState();
}

class _SavingsScreenState extends State<SavingsScreen> {
  @override
  Widget build(BuildContext context) {
    late DateTime? confirmedStartDate =
        DateTime.parse(confirmedStartDateString);
    late DateTime? confirmedEndDate = DateTime.parse(confirmedEndDateString);
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: GlobalVariables.secondaryColor,
        title: Text(
          'Ersparnisse',
          style: themeData.textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: size.height * 0.02,
              color: Colors.white),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.02, right: size.width * 0.02),
          child: SizedBox(
            child: Column(children: [
              SizedBox(
                width: double.infinity,
                height: size.height * 0.08,
                child: const DateStartPicker(),
              ),
              SizedBox(
                width: double.infinity,
                height: size.height * 0.1,
                child: const DateEndPicker(),
              ),
              InkResponse(
                onTap: () {
                  // error messages if no date was entered or invalid date
                  // was entered
                  if (confirmedEndDate.isBefore(confirmedStartDate)) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(invalidDateInput,
                          style: themeData.textTheme.bodyText1),
                    ));
                    showInitialChart = true;
                    setState(() {});
                  } else {
                    _toggleStateSaving();
                    _toggleTapState();
                    setState(() {});
                  }
                  // if correct date was entered, state should be changed
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
              // if state of chart is true, initial chart should
              // be displayed, otherwise,
              // chart from firebase should be loaded
              Expanded(
                  child: ChartInitialSelfConsumption(
                      ChartInitialSelfConsumption.createChartInitial())
                  // : tapState
                  //     ? const ChartObserverSaving()
                  //     : const ChartObserverSaving(),
                  ),
              SizedBox(height: size.height * 0.03),
              Row(
                children: [
                  Container(
                    alignment: Alignment.bottomRight,
                    height: size.height * 0.035,
                    width: size.width * 0.035,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: GlobalVariables.secondaryColor),
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Text(
                    'Ersparnisse durch den Eigenverbrauch',
                    style: themeData.textTheme.bodyText1,
                  ),
                ],
              ),
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
                    'Einnamhen durch die Direkt Vermarktung',
                    style: themeData.textTheme.bodyText1,
                  ),
                ],
              ),
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
                        shape: BoxShape.circle, color: Colors.blue),
                  ),
                  SizedBox(
                    width: size.width * 0.015,
                  ),
                  Text(
                    'Gesamte Ersparnisse',
                    style: themeData.textTheme.bodyText1,
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void _toggleStateSaving() {
    setState(() {
      (confirmedStartDateString == formatDateUSA(prevMonthFromNow) &&
              confirmedEndDateString == formatDateUSA(DateTime.now()))
          ? showInitialChart = true
          : showInitialChart = false;
    });
  }

  void _toggleTapState() {
    setState(() {
      !tapState ? tapState = true : tapState = false;
    });
  }
}
