import 'package:flutter/material.dart';

class MetricsCard extends StatelessWidget {
  const MetricsCard({super.key, required this.totalOrders, required this.averagePrice, required this.returnsCount});
  final String totalOrders;
  final String averagePrice;
  final String returnsCount;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Metrics Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMetricTile(
                  title: 'Total Orders',
                  value: totalOrders,
                  icon: Icons.shopping_cart,
                ),
                _buildMetricTile(
                  title: 'Avg. Price',
                  value: averagePrice,
                  icon: Icons.attach_money,
                ),
                _buildMetricTile(
                  title: 'Returns',
                  value: returnsCount,
                  icon: Icons.assignment_return,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildMetricTile({
  required String title,
  required String value,
  required IconData icon,
}) {
  return Column(
    children: [
      Icon(icon, size: 40),
      const SizedBox(height: 8),
      Text(
        value,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      Text(title),
    ],
  );
}
