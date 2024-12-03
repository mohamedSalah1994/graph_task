import 'package:flutter/material.dart';
import 'package:graph_task/features/home/presentation/manager/order_provider.dart';
import 'package:graph_task/features/home/presentation/views/widgets/metrics_card.dart';
import 'package:graph_task/features/home/presentation/views/widgets/orders_layout.dart';
import 'package:provider/provider.dart';

import '../../../graph/presentation/views/orders_graph.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    

    return Scaffold(
      appBar: AppBar(title: const Text('Orders Page') , centerTitle: true),
      body: FutureBuilder(
        future: orderProvider.loadOrders(),
        builder: (context, snapshot) {
          if (orderProvider.orders.isEmpty) {
            return const Center(child: Text('No orders available.'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Metrics Section
                SizedBox(
                    width: double.infinity,
                    child: MetricsCard(
                      totalOrders: '${orderProvider.totalOrders}',
                      averagePrice:
                          '\$${orderProvider.averagePrice.toStringAsFixed(2)}',
                      returnsCount: '${orderProvider.returnsCount}',
                    )),
                const SizedBox(height: 16),
                // Show Graph Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderGraphPage(),
                      ),
                    );
                  },
                  child: const Text('Show Orders Count Graph' , style: TextStyle(color: Colors.black),),
                ),
                const SizedBox(height: 16),
                // Orders List Section
                const Expanded(
                  child: OrdersLayout()
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper to build the metrics tile

  // Mobile: List Layout

}
