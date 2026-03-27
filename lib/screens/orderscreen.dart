import 'package:bigcart/model/transactionmodel.dart';
import 'package:bigcart/screens/ordersuccessscreen.dart';
import 'package:bigcart/screens/transaction_provider.dart';
import 'package:bigcart/widgets/ordersteps.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int currentStep = 1;
  String selectedAddress = "home";
  int selectedMethod = 1;
  final TextEditingController nameController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController addressController = TextEditingController();
final TextEditingController cityController = TextEditingController();
final TextEditingController zipController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController cardController = TextEditingController();
final TextEditingController expiryController = TextEditingController();
final TextEditingController cvvController = TextEditingController();

final _formKey = GlobalKey<FormState>();
String? selectedCountry;
String selectedDelivery = "standard";
String getPaymentMethod() {
  switch (selectedMethod) {
    case 1:
      return "PayPal";
    case 2:
      return "Card • ${_formatCardNumber(cardController.text)}";
    case 3:
      return "Apple Pay";
    default:
      return "Unknown";
  }
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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Colors.white,
        title:  Text("Checkout",style: GoogleFonts.poppins( color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,),),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
              width: double.infinity, 
              color: const Color(0xFFF4F5F9),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
        
              // Step Indicator
              OrderSteps(currentStep: currentStep),
        
              const SizedBox(height: 20),
        
              // Step Titles
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Text("DELIVERY",style: GoogleFonts.poppins(fontSize: 15),),
                  Text("ADDRESS",style: GoogleFonts.poppins(fontSize: 15),),
                  Text("PAYMENT",style: GoogleFonts.poppins(fontSize: 15),),
                ],
              ),
        
              const SizedBox(height: 30),
        
              // Content based on step
              Expanded(child: _buildStepContent()),
        
              // Buttons
              Row(
                
                children: [
                   if (currentStep > 1)
      Container(
        height: size.height * 0.07,
        width: size.height * 0.07,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 175, 245, 95),
              Colors.green,
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          onPressed: () {
            setState(() {
              currentStep--;
            });
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),

     SizedBox(width:size.width*0.01),
                  Expanded(
                    child: Container(
                      width: size.width * 0.9,
                      height: size.height * 0.07,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 175, 245, 95),
                            Colors.green,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (currentStep < 3) {
                            // 👉 Step 1 & 2 → Next
                            setState(() {
                              currentStep++;
                            });
                          } else {
                            final provider =
    Provider.of<TransactionProvider>(context, listen: false);

provider.addTransaction(
  TransactionModel(
    name: nameController.text.isEmpty
        ? "Customer"
        : nameController.text,

    amount: "\$20", // 👉 later connect with cart total

    method: getPaymentMethod(), // ✅ FIXED

   date: DateFormat('MMMM d yyyy ' 'at' ' h:mm a').format(DateTime.now()),
  ),
);
final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user != null) {
      await supabase.from('cart').delete().eq('user_id', user.id);
    }
                            ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Payment Successful"),
      duration: Duration(seconds: 1),
    ),
  );

  // ✅ Navigate after delay
  Future.delayed(const Duration(seconds: 1), () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const OrderSuccessScreen(),
      ),
    );
  });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          currentStep == 3 ? "Make Payment" : "Next",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
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

  Widget _buildStepContent() {
    final Size size=MediaQuery.of(context).size;
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
  if (input.length < 2) return input;
  if (input.length == 2) return "$input/";
  return "${input.substring(0, 2)}/${input.substring(2)}";
}
      switch (currentStep) {
      case 1:
  return SingleChildScrollView(
    child: Column(
      children: [
        _deliveryCard(
          context,
          id: "standard",
          title: "Standard Delivery",
          subtitle: "3 - 4 business days",
          price: "\$3",
        ),
        SizedBox(height: size.height*0.01,),
        _deliveryCard(
          context,
          id: "nextday",
          title: "Nextday Delivery",
          subtitle: "1 - 2 days",
          price: "\$5",
        ),
         SizedBox(height: size.height*0.01,),

        _deliveryCard(
          context,
          id: "nominated",
          title: "Nominated Delivery",
          subtitle: "Choose your date",
          price: "\$8",
        ),
      ],
    ),
  );
        
     case 2:
  return SingleChildScrollView(
    child: Column(
      children: [
        _inputCard(
          icon: Icons.person_outline,
          hint: "Name",
          controller: nameController,
        ),
        _inputCard(
          icon: Icons.email_outlined,
          hint: "Email Address",
          controller: emailController,
          
        ),
        _inputCard(
          icon: Icons.phone,
          hint: "Phone Number",
          controller: phoneController,
          isNumber: true,
        ),
        _inputCard(
          icon: Icons.pin_drop_outlined,
          hint: "Address",
          controller: addressController,
        ),
        _inputCard(
          icon: Icons.home_outlined,
          hint: "Zip code",
          controller: zipController,
          isNumber: true,
        ),
        _inputCard(
          icon: Icons.map_outlined,
          hint: "City",
          controller: cityController,
        ),
         buildCountryDropdown(size.width * 0.85),
       
      ],
    ),
  );
     
        case 3:
  return SingleChildScrollView(
    child: Column(
      children: [

        /// 🔹 PAYMENT OPTIONS
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _paymentOption(1, Icons.paypal, "Paypal"),
            _paymentOption(2, Icons.credit_card, "Card"),
            _paymentOption(3, Icons.apple, "Apple Pay"),
          ],
        ),

        const SizedBox(height: 20),

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
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(20),
  ),
  child: Stack(
    children: [

      /// 🔴🟡 TOP LEFT CIRCLES (Mastercard style)
      Positioned(
  top: 0,
  left: 0,
  child: _buildPaymentLogo(),
),
      /// 🟢 DECORATIVE RIGHT CIRCLES
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

      /// 💳 CARD DETAILS
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),

          /// CARD NUMBER
          Text(
            _formatCardNumber(cardController.text),
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 2,
              fontWeight: FontWeight.w500,
            ),
          ),

          const Spacer(),

          /// NAME + EXPIRY
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CARD HOLDER",
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 10,
                    ),
                  ),
                 Text(
                  nameController.text.isEmpty ? "CARD HOLDER NAME" : nameController.text.toUpperCase(),
                   style: GoogleFonts.poppins(
    color: Colors.white,           
    fontSize: 15,                  
    fontWeight: FontWeight.w500,   
  ),)
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
    fontSize: 12,
    fontWeight: FontWeight.w500,
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

        /// 📝 INPUT FIELDS
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

        /// 🔘 SAVE CARD
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
      ],
    ),
  );
      default:
        return const SizedBox();
    }
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
Widget _deliveryCard(
  BuildContext context,
  { required String id,required String title, required String subtitle, required String price,}) {
  final Size size=MediaQuery.of(context).size;
   bool isSelected = selectedDelivery == id;

  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      setState(() {
        selectedDelivery = id;
      });
    },
    child: Container(
      height: size.height * 0.15,
      width: size.width * 0.9,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
         border: Border.all(
            color: isSelected ? Colors.green : Colors.grey.shade300,
            width: 2,
          ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Order will be delivered in",
                  style: GoogleFonts.poppins(fontSize: 13),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(fontSize: 13),
                ),
              ],
            ),
          ),
           Text(
            price,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
           const SizedBox(height: 6),
    
             
                if (isSelected)
                  const Icon(Icons.check_circle, color: Colors.green),
        ],
      ),
    ),
  );

}
Widget _paymentOption(int id, IconData icon, String text) {
  bool isSelected = selectedMethod == id;

  return GestureDetector(
    onTap: () {
      setState(() {
        selectedMethod = id;
      });
    },
    child: Container(
      width: 90,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? Colors.green : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Icon(icon,
  color: isSelected ? Colors.green : Colors.grey,),
          const SizedBox(height: 5),
          Text(text, style: GoogleFonts.poppins(fontSize: 12)),
        ],
      ),
    ),
  );
}
Widget _buildPaymentLogo() {
  switch (selectedMethod) {

    // ✅ PayPal
    case 1:
      return Text(
        "PayPal",
        style: TextStyle(
          color: Colors.blue.shade900,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      );

    // ✅ Card (MasterCard style)
    case 2:
      return Stack(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          Positioned(
            left: 12,
            child: Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      );

    // ✅ Apple Pay
    case 3:
      return const Icon(
        Icons.apple,
        color: Colors.white,
        size: 26,
      );

    default:
      return const SizedBox();
  }
}
Widget buildCountryDropdown(double width) {
  return Container(
    width: width,
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: DropdownButtonFormField<String>(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.public_outlined),
        hintText: "Select Country",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      value: selectedCountry,
      items: ["India", "USA", "UK", "Canada"]
          .map((country) => DropdownMenuItem(
                value: country,
                child: Text(country),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedCountry = value;
        });
      },
    ),
  );
}
}


// Step Indicator Widget

