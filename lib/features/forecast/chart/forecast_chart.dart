import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:selfconsumption2/features/forecast/forecast_screen.dart';
import 'package:selfconsumption2/features/self_consumption/services/self_consumption_service.dart';
import '../../../constants/strings.dart';

class ForeCastChart extends StatelessWidget {
  final List<charts.Series<dynamic, DateTime>> seriesList;
  final bool? animate;
  final SelfConsumptionService selfConsumptionService =
      SelfConsumptionService();

  void getPlantOutput() {
    selfConsumptionService.getPlantOutput();
  }

  ForeCastChart(this.seriesList, {super.key, this.animate});

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  static List<charts.Series<TimeSeriesSales, DateTime>> createChartInitial() {
    late DateTime? confirmedEndDate = endInput;
    late DateTime? confirmedStartDate = now;

    final shareInOutputDateEntered = [
      TimeSeriesSales(confirmedStartDate, 40),
      TimeSeriesSales(confirmedEndDate, 60),
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
