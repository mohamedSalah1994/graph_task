import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

import '../../../../core/data/models/order_model.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  /// Load orders from JSON file
  Future<void> loadOrders() async {
    final jsonString = await rootBundle.loadString('lib/assets/data.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    _orders = jsonData.map((item) => Order.fromJson(item)).toList();
    notifyListeners();
  }

  /// Get total number of orders
  int get totalOrders => _orders.length;

  /// Calculate the average price of orders
  double get averagePrice {
    if (_orders.isEmpty) return 0.0;
    final prices = _orders
        .map((order) => double.tryParse(order.price.replaceAll(',', '').replaceAll('\$', '')) ?? 0.0)
        .toList();
    return prices.reduce((a, b) => a + b) / prices.length;
  }

  /// Count the number of returned orders
  int get returnsCount =>
      _orders.where((order) => order.status.toUpperCase() == 'RETURNED').length;

  /// Generate chart data for orders by date for Syncfusion Charts
  List<OrdersData> get ordersChartData {
    // Group orders by date
    Map<DateTime, int> ordersByDate = {};

    for (var order in _orders) {
      DateTime date = DateTime(
        order.registered.year,
        order.registered.month,
        order.registered.day,
      );

      // Increment the count for this date
      ordersByDate[date] = (ordersByDate[date] ?? 0) + 1;
    }

    // Convert to a list of OrdersData
    final data = ordersByDate.entries
        .map((entry) => OrdersData(entry.key, entry.value))
        .toList();

    // Sort by date to ensure proper graphing
    data.sort((a, b) => a.date.compareTo(b.date));

    return data;
  }
}

/// Class to represent order data for the chart
class OrdersData {
  final DateTime date;
  final int count;

  OrdersData(this.date, this.count);
}
