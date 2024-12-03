import 'package:flutter/material.dart';

import 'package:graph_task/features/home/presentation/views/widgets/order_card.dart';
import 'package:provider/provider.dart';

import '../../manager/order_provider.dart';

class OrdersLayout extends StatelessWidget {
  const OrdersLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (screenWidth > 600) {
          // Web/Desktop: Show in grid
          return _buildGridLayout(orderProvider);
        } else {
          // Mobile: Show in list
          return _buildListLayout(orderProvider);
        }
      },
    );
  }
}

Widget _buildListLayout(OrderProvider orderProvider) {
  return ListView.builder(
    itemCount: orderProvider.orders.length,
    itemBuilder: (context, index) {
      final product = orderProvider.orders[index];
      return OrderCard(product: product);
    },
  );
}



// Web/Desktop: Grid Layout
Widget _buildGridLayout(OrderProvider orderProvider) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      childAspectRatio: 6,
    ),
    itemCount: orderProvider.orders.length,
    itemBuilder: (context, index) {
      final product = orderProvider.orders[index];
      return OrderCard(product: product);
    },
  );
}
