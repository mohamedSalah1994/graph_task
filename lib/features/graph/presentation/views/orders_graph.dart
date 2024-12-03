import 'package:flutter/material.dart';
import 'package:graph_task/features/home/presentation/manager/order_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class OrderGraphPage extends StatelessWidget {
  const OrderGraphPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<OrderProvider>(context);
    final Map<DateTime, int> orderCounts = {};

    for (var product in productProvider.orders) {
      final date = product.registered;
      orderCounts.update(date, (value) => value + 1, ifAbsent: () => 1);
    }

    final List<OrderData> chartData = orderCounts.entries
        .map((entry) => OrderData(date: entry.key, count: entry.value))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Order Graph') , centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SfCartesianChart(
          primaryXAxis: DateTimeAxis(),
          primaryYAxis: NumericAxis(),
          title: ChartTitle(text: 'Number of Orders Over Time'),
          legend: Legend(isVisible: false),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <ChartSeries>[
            LineSeries<OrderData, DateTime>(
              dataSource: chartData,
              xValueMapper: (OrderData data, _) => data.date,
              yValueMapper: (OrderData data, _) => data.count,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
            )
          ],
        ),
      ),
    );
  }
}

class OrderData {
  final DateTime date;
  final int count;

  OrderData({required this.date, required this.count});
}
