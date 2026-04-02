import 'package:bigcart/model/ordermodel.dart';
import 'package:bigcart/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatefulWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool isExpanded = false;

  final List<String> stages = [
    "Order placed",
    "Order confirmed",
    "Order shipped",
    "Out for delivery",
    "Order delivered",
  ];

  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    final order = widget.order;
    final items = List<Map<String, dynamic>>.from(order.items ?? []);

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// TOP ROW: ICON + ORDER SUMMARY
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 📦 Icon
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.inventory_outlined, color: Colors.green),
                ),
                SizedBox(width: size.width*0.01,),

                // ORDER DETAILS
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order #${order.orderId}",
                        style: AppTextStyles.bold,
                      ),
                      SizedBox(height: size.height*0.01,),

                      Text(
  order.statusDates["Order placed"] != null
      ? "Placed on ${DateFormat('MMMM dd yyyy').format(
          DateTime.parse(order.statusDates["Order placed"]!),
        )}"
      : "Date not available",
  style: AppTextStyles.body,
),
 SizedBox(height: size.height*0.01,),
                     
   RichText(
  text: TextSpan(
    style:  GoogleFonts.poppins(color: Colors.black87, fontSize: 13),
    children: [
      const TextSpan(text: "Items: "),
      TextSpan(
        text: "${order.itemCount}",
        style: AppTextStyles.bold,
      ),
      const TextSpan(text: "      Amount: \$"),
      TextSpan(
        text: order.total.toStringAsFixed(2),
        style:  AppTextStyles.bold,
      ),
    ],
  ),
),
                      SizedBox(height: size.height*0.01,),
                      SizedBox(
  width: double.infinity,
  child: Divider(thickness: 1),
),
                       SizedBox(height: size.height*0.01,),
                      // ITEMS LIST
                      if (items.isEmpty)
                        const Text("No items in this order")
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      item['image'] ?? '',
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(Icons.broken_image);
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(item['name'] ?? 'Unnamed',style: AppTextStyles.body,),
                                        Text(
                                          "\$${item['price'] ?? 0} × ${item['qty'] ?? 1}",
                                          style: AppTextStyles.greenText,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              
                // EXPAND BUTTON
                IconButton(
                  icon: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                ),
              ],
            ),
             SizedBox(height: size.height*0.01,),
             
            /// TIMELINE (EXPANDABLE)
            if (isExpanded) ...[
  const SizedBox(height: 16),
  Column(
    children: stages.map((stage) {
      final rawDate = order.statusDates[stage];
      final isCompleted = rawDate != null;

      final formattedDate = isCompleted
          ? DateFormat('MMMM dd yyyy')
              .format(DateTime.parse(rawDate!))
          : "pending";

      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline dot + line
            Column(
              children: [
                Icon(
                  Icons.circle,
                  size: 10,
                  color: isCompleted
                      ? Colors.green
                      : Colors.grey.shade400,
                ),
                if (stage != stages.last)
                  Container(
                    width: 2,
                    height: 40,
                    color: Colors.grey.shade300,
                  ),
              ],
            ),
            const SizedBox(width: 10),

            // Stage text
            Expanded(
              child: Text(
                stage,
                style: TextStyle(
                  fontWeight: isCompleted
                      ? FontWeight.w600
                      : FontWeight.normal,
                  color: isCompleted
                      ? Colors.black
                      : Colors.grey,
                ),
              ),
            ),

            // ✅ Formatted date
            Text(
              formattedDate,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }).toList(),
  ),
]
          ],
        ),
      ),
    );
  }
}