import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:selfconsumption2/features/self_consumption/services/self_consumption_service.dart';

import '../../../constants/strings.dart';
import '../../../features/self_consumption/date_picker/date_end_picker.dart';
import '../../../features/self_consumption/date_picker/date_start_picker.dart';

class ChartInitialSelfConsumption extends StatelessWidget {
  final List<charts.Series<dynamic, DateTime>> seriesList;
  final bool? animate;
  final SelfConsumptionService selfConsumptionService =
      SelfConsumptionService();

  void getPlantOutput() {
    selfConsumptionService.getPlantOutput();
  }

  ChartInitialSelfConsumption(this.seriesList, {super.key, this.animate});

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
    late DateTime? confirmedStartDate =
        DateTime.parse(confirmedStartDateString);
    late DateTime? confirmedEndDate = DateTime.parse(confirmedEndDateString);

    final selfconsumptionDateEntered = [
      TimeSeriesSales(confirmedStartDate, 100),
      TimeSeriesSales(confirmedEndDate, 60),
    ];
    final shareInOutputDateEntered = [
      TimeSeriesSales(confirmedStartDate, 40),
      TimeSeriesSales(confirmedEndDate, 30),
    ];
    final shareInMarcetingDateEntered = [
      TimeSeriesSales(confirmedStartDate, 20),
      TimeSeriesSales(confirmedEndDate, 10),
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
  }
}

// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
