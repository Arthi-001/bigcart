import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Addcard extends StatefulWidget {
  const Addcard({super.key});

  @override
  State<Addcard> createState() => _AddcardState();
}

class _AddcardState extends State<Addcard> {
  final TextEditingController cardController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    cardController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    cardController.addListener(() => setState(() {}));
    nameController.addListener(() => setState(() {}));
    expiryController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    String _formatCardNumber(String input) {
      if (input.isEmpty) return "XXXX XXXX XXXX 8790";

      input = input.replaceAll(" ", "");

      String masked = "";
      for (int i = 0; i < input.length; i++) {
        if (i < input.length - 4) {
          masked += "X";
        } else {
          masked += input[i];
        }
      }

      String formatted = "";
      for (int i = 0; i < masked.length; i++) {
        if (i % 4 == 0 && i != 0) formatted += " ";
        formatted += masked[i];
      }

      return formatted;
    }

    String formatExpiry(String input) {
      if (input.length <= 2) return input;
      return "${input.substring(0, 2)}/${input.substring(2)}";
    }

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "Add Card",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Container(
         height: double.infinity,
         width: double.infinity,
         color: const Color(0xFFF4F5F9),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(height: size.height*0.03,),
                /// 💳 CARD UI
                Container(
                  width: size.width * 0.9,
                  height: size.height * 0.2,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFA7F55F),
                        Colors.green,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Row(
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              width: 25,
                              height: 25,
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
        
                      Positioned(
                        right: -20,
                        top: -20,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
        
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
        
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
        
                          Text(
                            _formatCardNumber(cardController.text),
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                              letterSpacing: 2,
                            ),
                          ),
        
                          const Spacer(),
        
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "CARD HOLDER",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white70,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    nameController.text.isEmpty
                                        ? "CARD HOLDER NAME"
                                        : nameController.text.toUpperCase(),
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "EXPIRES",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white70,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    formatExpiry(expiryController.text),
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
        
                const SizedBox(height: 20),
        
                /// 📝 INPUTS
                _inputCard(
                  icon: Icons.person_outline,
                  hint: "Name on the card",
                  controller: nameController,
                ),
        
                _inputCard(
                  icon: Icons.credit_card,
                  hint: "Card number",
                  controller: cardController,
                ),
        
                Row(
                  children: [
                    Expanded(
                      child: _inputCard(
                        icon: Icons.date_range,
                        hint: "MM/YY",
                        controller: expiryController,
                        isNumber: true,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _inputCard(
                        icon: Icons.lock_outline,
                        hint: "CVV",
                        controller: cvvController,
                        isNumber: true,
                      ),
                    ),
                  ],
                ),
        
                const SizedBox(height: 10),
        
                Row(
                  children: [
                    Switch(
                      value: true,
                      activeColor: Colors.green,
                      onChanged: (value) {},
                    ),
                    const Text("Save this card"),
                  ],
                ),
                SizedBox(height: size.height*0.1,),
                Container(
                             width: size.width*0.9,
                             height: size.height*0.07,
                             decoration: BoxDecoration(
                               gradient:  LinearGradient(
                                 colors: [
                                   const Color.fromARGB(255, 175, 245, 95),Colors.green
                                 ],
                                 begin: Alignment.topLeft,
                                 end: Alignment.bottomRight,
                               ),
                               borderRadius: BorderRadius.circular(10),
                             ),
                             child: ElevatedButton(
                               onPressed: () {
                                if (cardController.text.isEmpty ||
      nameController.text.isEmpty ||
      expiryController.text.isEmpty ||
      cvvController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please fill all fields")),
    );
    return;
  }
  String detectCardType(String number) {
    if (number.startsWith('4')) return "Visa";
    if (number.startsWith('5')) return "MasterCard";
    return "Card";
  }

  Navigator.pop(context, {
    "type": detectCardType(cardController.text), // you can detect later
    "number": cardController.text,
    "expiry": expiryController.text,
    "cvv": cvvController.text,
    "name": nameController.text,
  });
                               },
                               style: ElevatedButton.styleFrom(
                                 backgroundColor: Colors.transparent,
                                 shadowColor: Colors.transparent,
                                 padding: const EdgeInsets.symmetric(vertical: 15),
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(30),
                                 ),
                               ),
                               child:
                                  Text(
                                     "Add address",
                                     style: GoogleFonts.poppins(
                                       fontSize: 15,
                                       color: Colors.white,
                                       fontWeight: FontWeight.bold,
                                     ),
                                   ),
                                 
                               
                             ),
                           ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputCard({
    required IconData icon,
    required String hint,
    required TextEditingController controller,
    bool isNumber = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade700),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType:
                  isNumber ? TextInputType.number : TextInputType.text,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}