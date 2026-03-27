import 'package:bigcart/model/transactionmodel.dart';
import 'package:bigcart/screens/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions =
        Provider.of<TransactionProvider>(context).transactions;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title:  Text("Transactions",style: GoogleFonts.poppins(color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,),),),
      body: Container(
        height: double.infinity,
        width: double.infinity,
         color: const Color(0xFFF4F5F9),
        child: transactions.isEmpty
            ? Center(
                child: Text(
                  "No transactions yet",
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final tx = transactions[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Card Logo
                        _getCardLogo(tx.method),
                        const SizedBox(width: 16),
        
                        // Card Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tx.method,
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                tx.date,
                                style:  GoogleFonts.poppins(
                                    fontSize: 14, color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
        
                        // Amount
                        Text(
                          tx.amount,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _getCardLogo(String method) {
    switch (method.split('•').first.trim()) {
      case 'Card':
        return Stack(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            Positioned(
              left: 12,
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        );
      case 'PayPal':
        return Icon(Icons.paypal, color: Colors.blue.shade900, size: 28);
      case 'Apple Pay':
        return const Icon(Icons.apple, color: Colors.black, size: 28);
      default:
        return const SizedBox(width: 28);
    }
  }
}