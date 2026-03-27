import 'package:bigcart/model/cardmodel.dart' as model;
import 'package:bigcart/screens/account/addcard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCards extends StatefulWidget {
  const MyCards({super.key});

  @override
  State<MyCards> createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> {
  List<model.CardModel> cards = [];
  void addDummyCard() {
    setState(() {
      cards.add(
        model.CardModel(
          type: "Visa",
          number: "XXXX XXXX XXXX 5678",
          expiry: "01/22",
          cvv: "908",
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title:  Text("My Cards",style: GoogleFonts.poppins(color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,),),

         actions: [
      IconButton(
        icon: const Icon(Icons.add, color: Colors.black),
        onPressed: () async {
           final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const Addcard(),
    ),
  );
  if (result != null) {
    setState(() {
      cards.add(
        model.CardModel(
          type: result["type"],
          number: result["number"],
          expiry: result["expiry"],
          cvv: result["cvv"],
        ),
      );
    });
  }
 
},),
    ],
      ),
      body: Container(
        height: double.infinity,
        width:double.infinity,
        color: const Color(0xFFF4F5F9),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: cards.isEmpty
              ? Center(
                  child: Text(
                    "Add your card",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    final card = cards[index];
                    return _cardTile(card);
                  },
                ),
        ),
      ),

     
    );
  }
  Widget _cardTile(model.CardModel card) {
    
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade200,
          blurRadius: 8,
        )
      ],
    ),
    child: Row(
      children: [
       Container(
  width: 50,
  height: 30,
  alignment: Alignment.center,
  child: card.type.toLowerCase() == "visa"
      ? Text(
          "VISA",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            fontSize: 16,
          ),
        )
      : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            
            Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
),

        const SizedBox(width: 10),

        // Card Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${card.type} Card",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(card.number),
              const SizedBox(height: 5),
              Text(
                "Expiry: ${card.expiry}   CVV: ${card.cvv}",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),

        // Dropdown / select icon
        Icon(Icons.keyboard_arrow_down, color: Colors.grey),
      ],
    ),
  );
}
Widget _buildCardLogo(String type) {
  final t = type.toLowerCase();

  if (t == "visa") {
    return Text(
      "VISA",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.blue,
        fontSize: 16,
      ),
    );
  }

  if (t == "mastercard" || t == "master") {
    return Stack(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
        Positioned(
          left: 10,
          child: Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  /// fallback
  return const Icon(Icons.credit_card, color: Colors.grey);
}
}