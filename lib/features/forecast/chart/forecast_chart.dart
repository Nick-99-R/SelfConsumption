import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:selfconsumption2/features/forecast/forecast_screen.dart';
import 'package:selfconsumption2/features/self_consumption/services/self_consumption_service.dart';

import '../../../constants/strings.dart';
import '../../self_consumption/date_picker/date_end_picker.dart';

class ForeCastChart extends StatelessWidget {
  final List<charts.Series<dynamic, DateTime>> seriesList;
  final bool? animate;
  final SelfConsumptionService selfConsumptionService =
      SelfConsumptionService();

  void getPlantOutput() {
    selfConsumptionService.getPlantOutput();
  }

  ForeCastChart(this.seriesList, {super.key, this.animate});

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
    DateTime tomorrow = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
    late DateTime? confirmedEndDate = endInput;

    final shareInOutputDateEntered = [
      TimeSeriesSales(DateTime.now(), 40),
      TimeSeriesSales(tomorrow, 50),
      TimeSeriesSales(confirmedEndDate, 40),
    ];
    return [
      charts.Series<TimeSeriesSales, DateTime>(
        id: shareOfTotalProduction,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: shareInOutputDateEntered,
      ),
    ];
  }

  static List<charts.Series<TimeSeriesSales, DateTime>> createNewChart() {
    late DateTime? confirmedEndDate = endInput;
    DateTime tomorrow = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
    late DateTime? confirmedStartDate = now;
    final shareInOutputDateEntered = [
      TimeSeriesSales(confirmedStartDate, 10),
      TimeSeriesSales(confirmedEndDate, 40),
    ];
    return [
      charts.Series<TimeSeriesSales, DateTime>(
        id: shareOfTotalProduction,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: shareInOutputDateEntered,
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
