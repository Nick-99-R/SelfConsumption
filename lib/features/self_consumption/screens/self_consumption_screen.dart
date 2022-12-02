import 'package:flutter/material.dart';
import 'package:selfconsumption2/constants/strings.dart';

import '../../../common/widgets/charts/chart_initial.dart';
import '../../../constants/global_variables.dart';
import '../date_picker/date_end_picker.dart';
import '../date_picker/date_start_picker.dart';

bool showInitialChart = true;
bool tapState = false;

class SelfConsumptionScreen extends StatefulWidget {
  static const String routeName = '/selfConsumption-screen';

  const SelfConsumptionScreen({Key? key}) : super(key: key);

  @override
  State<SelfConsumptionScreen> createState() => _SelfConsumptionScreenState();
}

class _SelfConsumptionScreenState extends State<SelfConsumptionScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: GlobalVariables.secondaryColor,
        title: Text(
          selfConsumptionString,
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

  late String email;

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
    late DateTime? confirmedStartDate =
        DateTime.parse(confirmedStartDateString);
    late DateTime? confirmedEndDate = DateTime.parse(confirmedEndDateString);
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return Scaffold(
        body: Padding(
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
                  child: //showInitialChart || tapState && !tapState
                      ChartInitialSelfConsumption(
                          ChartInitialSelfConsumption.createChartInitial())
                  //   : tapState
                  //       ? const ChartObserverSelfConsumption()
                  //       : const ChartObserverSelfConsumption(),
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
                    selfConsumptioninKwh,
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
                    shareOfTotalProduction,
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
                        shape: BoxShape.circle, color: GlobalVariables.blue),
                  ),
                  SizedBox(
                    width: size.width * 0.015,
                  ),
                  Text(
                    shareInDirectMarcetingString,
                    style: themeData.textTheme.bodyText1,
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
            ]))));
  }

  // Initial State == Defaul Chart (One Month into past)
// If data is entered, state changes to false
  void _toggleState() {
    setState(() {
      (confirmedStartDateString == formatDateUSA(prevMonthFromNow) &&
              confirmedEndDateString == formatDateUSA(DateTime.now()))
          ? showInitialChart = true
          : showInitialChart = false;
    });
  }

// Everytime the button is clicked, ChartObserver() should be
// fired again
  void _toggleTapState() {
    setState(() {
      !tapState ? tapState = true : tapState = false;
    });
  }
}
