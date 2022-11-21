import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../../constants/strings.dart';
import '../../../features/self_consumption/date_picker/date_end_picker.dart';
import '../../../features/self_consumption/date_picker/date_start_picker.dart';

class ChartInitialSelfConsumption extends StatelessWidget {
  final List<charts.Series<dynamic, DateTime>> seriesList;
  final bool? animate;
  //final SelfConsumption selfConsumption;

  const ChartInitialSelfConsumption(this.seriesList, {this.animate});

  //Creates a [TimeSeriesChart] with sample data and no transition.
  // factory SimpleTimeSeriesChart.withSampleData() {
  //   return SimpleTimeSeriesChart(
  //     createChartSuccess(),
  //     // selfConsumption: SelfConsumption.empty(),
  //     // Disable animations for image tests.
  //     animate: false,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  static List<charts.Series<TimeSeriesSales, DateTime>> createChartInitial() {
    //dates

    DateTime prevMonthFromNow = DateTime(
        DateTime.now().year, DateTime.now().month - 1, DateTime.now().day);

    late DateTime? confirmedStartDate =
        DateTime.parse(confirmedStartDateString);
    late DateTime? confirmedEndDate = DateTime.parse(confirmedEndDateString);

    // different cases: Wether InitialStartdate (One month before today),
    // or InitialEndDate is changed (today)
    if (confirmedStartDate.isBefore(confirmedEndDate) &&
        confirmedStartDateString == formatDateUSA(prevMonthFromNow) &&
        confirmedEndDateString == formatDateUSA(DateTime.now())) {
      final selfconsumptionDateEntered = [
        TimeSeriesSales(prevMonthFromNow, 100),
        TimeSeriesSales(DateTime.now(), 60),
      ];
      final shareInOutputDateEntered = [
        TimeSeriesSales(prevMonthFromNow, 40),
        TimeSeriesSales(DateTime.now(), 30),
      ];
      final shareInMarcetingDateEntered = [
        TimeSeriesSales(prevMonthFromNow, 20),
        TimeSeriesSales(DateTime.now(), 10),
      ];

      return [
        charts.Series<TimeSeriesSales, DateTime>(
          id: selfConsumptionString,
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (TimeSeriesSales sales, _) => sales.time,
          measureFn: (TimeSeriesSales sales, _) => sales.sales,
          data: selfconsumptionDateEntered,
        ),
        charts.Series<TimeSeriesSales, DateTime>(
          id: shareOfTotalProduction,
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          domainFn: (TimeSeriesSales sales, _) => sales.time,
          measureFn: (TimeSeriesSales sales, _) => sales.sales,
          data: shareInOutputDateEntered,
        ),
        charts.Series<TimeSeriesSales, DateTime>(
          id: shareInDirectMarcetingString,
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (TimeSeriesSales sales, _) => sales.time,
          measureFn: (TimeSeriesSales sales, _) => sales.sales,
          data: shareInMarcetingDateEntered,
        ),
      ];

      // startdate is changed and enddate is not changed,
    }

    // curious else case
    else {
      final selfConsumptionDefault = [
        TimeSeriesSales(DateTime.now(), 40),
        TimeSeriesSales(prevMonthFromNow, 80),
      ];

      final shareInOutputDefault = [
        TimeSeriesSales(DateTime.now(), 20),
        TimeSeriesSales(prevMonthFromNow, 50),
      ];

      final shareInMarcetingDefault = [
        TimeSeriesSales(DateTime.now(), 60),
        TimeSeriesSales(prevMonthFromNow, 10),
      ];

      return [
        charts.Series<TimeSeriesSales, DateTime>(
          id: selfConsumptionString,
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (TimeSeriesSales sales, _) => sales.time,
          measureFn: (TimeSeriesSales sales, _) => sales.sales,
          data: selfConsumptionDefault,
        ),
        charts.Series<TimeSeriesSales, DateTime>(
          id: shareOfTotalProduction,
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          domainFn: (TimeSeriesSales sales, _) => sales.time,
          measureFn: (TimeSeriesSales sales, _) => sales.sales,
          data: shareInOutputDefault,
        ),
        charts.Series<TimeSeriesSales, DateTime>(
          id: shareInDirectMarcetingString,
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (TimeSeriesSales sales, _) => sales.time,
          measureFn: (TimeSeriesSales sales, _) => sales.sales,
          data: shareInMarcetingDefault,
        ),
      ];
    }
  }

  /// Create one series with sample hard coded data.
}

// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
