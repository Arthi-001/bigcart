// lib/screens/account/addcard.dart
import 'package:bigcart/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class AddCard extends StatefulWidget {
  final Map<String, String>? existingData; // optional for editing
  const AddCard({super.key, this.existingData});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final TextEditingController cardController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool saveCard = true;
  String cardType = "";

  @override
  void initState() {
    super.initState();
    if (widget.existingData != null) {
      cardController.text = widget.existingData?['number'] ?? '';
      expiryController.text = widget.existingData?['expiry'] ?? '';
      nameController.text = widget.existingData?['name'] ?? '';
      cardType = widget.existingData?['type'] ?? '';
    }

    cardController.addListener(() {
      setState(() {
        cardType = detectCardType(cardController.text);
      });
    });
  }

  @override
  void dispose() {
    cardController.dispose();
    expiryController.dispose();
    nameController.dispose();
    super.dispose();
  }

  String detectCardType(String number) {
    if (number.startsWith('4')) return "Visa";
    if (number.startsWith('5')) return "MasterCard";
    if (number.startsWith('3')) return "Amex";
    return "Card";
  }

  Widget _buildCardLogo(String type) {
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
    return const Icon(Icons.credit_card, color: Colors.grey);
  }

 /// Masks card number, shows only last 4 digits
String _formatCardNumber(String input) {
  if (input.isEmpty) return "XXXX XXXX XXXX 1234";
  input = input.replaceAll(" ", "");
  String masked = "XXXX XXXX XXXX ";
  String last4 = input.length >= 4 ? input.substring(input.length - 4) : input;
  return masked + last4;
}

  String formatExpiry(String input) {
    if (input.length <= 2) return input;
    return "${input.substring(0, 2)}/${input.substring(2)}";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
        centerTitle: true,
        title: Text(widget.existingData == null ? "Add Card" : "Edit Card", style: AppTextStyles.title),
      ),
      body: Container(
        color: const Color(0xFFF4F5F9),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.03),
                // Card preview
                Container(
                  width: size.width * 0.9,
                  height: size.height * 0.2,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFFA7F55F), Colors.green]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(_formatCardNumber(cardController.text), style:AppTextStyles.whiteText),
                        _buildCardLogo(cardType),
                      ]),
                      const Spacer(),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("CARD HOLDER", style: AppTextStyles.body),
                          Text(nameController.text.isEmpty ? "CARD HOLDER NAME" : nameController.text.toUpperCase(), style: AppTextStyles.whiteText),
                        ]),
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("EXPIRES", style: AppTextStyles.body),
                          Text(formatExpiry(expiryController.text), style: AppTextStyles.whiteText),
                        ]),
                      ]),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _inputField("Name on the card", nameController),
                _inputField("Card Number", cardController, isNumber: true),
                _inputField("MM/YY", expiryController, isNumber: true),
                Row(children: [
                  Switch(value: saveCard, onChanged: (v) => setState(() => saveCard = v), activeColor: Colors.green),
                   Text("Save this card",style: AppTextStyles.body,),
                ]),
                SizedBox(height: size.height * 0.1),
                SizedBox(
  width: size.width * 0.9,
  height: size.height * 0.07,
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.zero, // remove default padding
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.transparent, // make button background transparent
      shadowColor: Colors.transparent, // remove shadow
    ),
    onPressed: () {
      if (cardController.text.isEmpty || nameController.text.isEmpty || expiryController.text.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Please fill all fields")));
        return;
      }

      final number = cardController.text;

      Navigator.pop(context, {
        "type": cardType,
        "number": number,
        "expiry": expiryController.text,
        "name": nameController.text,
        "save": saveCard,
      });
    },
    child: Ink(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color.fromARGB(255, 175, 245, 95), Colors.green],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          widget.existingData == null ? "Add Card" : "Update Card",
          style:AppTextStyles.whiteText
        ),
      ),
    ),
  ),
)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField(String hint, TextEditingController controller, {bool isNumber = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: TextFormField(controller: controller, keyboardType: isNumber ? TextInputType.number : TextInputType.text, decoration: InputDecoration(hintText: hint, border: InputBorder.none)),
    );
  }
}