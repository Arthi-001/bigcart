
import 'package:bigcart/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bigcart/providers/orderprovider.dart';
import 'package:bigcart/widgets/ordercard.dart';
import 'package:bigcart/screens/dashboard/bottomnavigator.dart';

class Myorders extends StatefulWidget {
  const Myorders({super.key});

  @override
  State<Myorders> createState() => _MyordersState();
}

class _MyordersState extends State<Myorders> {
  @override
  void initState() {
    super.initState();

    // Fetch orders once after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrdersProvider>(context, listen: false).fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavigator()),
              (route) => false,
            );
          },
        ),
        centerTitle: true,
        title: Text(
          "My Orders",
          style: AppTextStyles.title
        ),
      ),
      body: Consumer<OrdersProvider>(
        builder: (context, provider, _) {
          final orders = provider.orders;

          if (orders.isEmpty) {
            return const Center(child: Text('No orders yet.'));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return OrderCard(order: orders[index]);
            },
          );
        },
      ),
    );
  }
}