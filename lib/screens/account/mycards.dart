// lib/screens/account/mycards.dart
import 'package:bigcart/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../model/cardmodel.dart';
import 'addcard.dart';

class MyCards extends StatefulWidget {
  const MyCards({super.key});
  @override
  State<MyCards> createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> {
  List<CardModel> cards = [];
  final supabase = Supabase.instance.client;
  final String tableName = 'cards';

  @override
  void initState() {
    super.initState();
    loadCards();
  }

  Future<void> loadCards() async {
  final user = supabase.auth.currentUser;
  if (user == null) return;

  final data = await supabase
      .from('cards')
      .select()
      .eq('user_id', user.id)
      .order('created_at', ascending: true);

  setState(() {
    cards = (data as List)
        .map((json) => CardModel.fromJson(json as Map<String, dynamic>))
        .toList();
  });
}
  Future<void> addCard(CardModel card) async {
  final user = supabase.auth.currentUser;
  if (user == null) return;

  final res = await supabase.from('cards').insert({
    'user_id': user.id,
    'card_type': card.type,
    'card_last4': card.last4,
    'expiry': card.expiry,
  }).select();

  if (res.isNotEmpty) {
    setState(() => cards.add(CardModel.fromJson(res[0])));
  }
}
Future<void> updateCard(int index, CardModel card) async {
  final cardId = cards[index].id;
  if (cardId == null) return;

  await supabase.from('cards')
      .update(card.toJson())
      .eq('id', cardId as Object);

  setState(() => cards[index] = card);
}
  Future<void> deleteCard(int index) async {
  final cardId = cards[index].id;
  if (cardId == null) return;

  await supabase.from('cards').delete().eq('id', cardId as Object);
  setState(() => cards.removeAt(index));
}
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        title: Text("My Cards", style:AppTextStyles.title),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () async {
              final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddCard()));
              if (result != null && result is Map<String, dynamic>) {
               final number = result["number"] ?? "";
final last4 = number.length >= 4 ? number.substring(number.length - 4) : number;

final newCard = CardModel(
  type: result["type"] ?? "Card",
 
  last4: last4,       // ✅ REQUIRED
  expiry: result["expiry"] ?? "",
 
);
addCard(newCard);
                
              }
            },
          )
        ],
      ),
      body: cards.isEmpty
    ? Center(
        child: Text("No cards yet", style: GoogleFonts.poppins(color: Colors.grey)))
    : ListView.builder(
        itemCount: cards.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, index) {
          final card = cards[index];
          Widget cardLogo(String type) {
      final t = type.toLowerCase();
      if (t == "visa") return Text("VISA", style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold));
      if (t == "mastercard") {
        return Stack(
          children: [
            Container(width: 18, height: 18, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
            Positioned(left: 10, child: Container(width: 18, height: 18, decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle))),
          ],
        );
      }
      if (t == "amex") return Text("AMEX", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold));
      return const Icon(Icons.credit_card, color: Colors.green);
    }
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                cardLogo(card.type),
                SizedBox(width:size.width*0.04 ,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${card.type} Card",
                          style: AppTextStyles.bold),
                      const SizedBox(height: 8),
                      Text("XXXX XXXX XXXX ${card.last4}",
                          style:AppTextStyles.body),
                      const SizedBox(height: 4),
                      Text("Exp: ${card.expiry}",
                          style: AppTextStyles.bold),
                    ],
                  ),
                ),

                // Actions
                
              ],
            ),
          );
        },
      ),
    );
  }
}