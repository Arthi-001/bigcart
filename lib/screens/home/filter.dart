import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {

  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();

  int selectedRating = 0;

  bool discount = false;
  bool freeShipping = false;
  bool sameDay = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        title: Text("Apply Filters",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),

      body: Stack(
        children: [

          /// BACKGROUND
          Container(
            color: const Color(0xFFF4F5F9),
          ),

          /// MAIN CARD
          Positioned(
            top: size.height * 0.03,
            left: 16,
            right: 16,
            child: Container(
              height: size.height * 0.6,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// ================= PRICE RANGE =================
                  Text("Price Range",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600)),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: minController,
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            hintText: "Min",
                            hintStyle: GoogleFonts.poppins(),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: maxController,
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            hintText: "Max",
                            hintStyle: GoogleFonts.poppins(),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                 SizedBox(
  width: size.width*0.9, // ✅ your desired width
  child: Divider(
    thickness: 1,
    color: Colors.grey,
  ),
),

                  /// ================= STAR RATING =================
                  const SizedBox(height: 10),

                  Text("Star Rating",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600)),

                  const SizedBox(height: 10),

                  Container( padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color:   Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
                    child: Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return GestureDetector(
                             onTap: () {
                      setState(() {
                        if (selectedRating == index + 1) {
                          selectedRating = 0; // ✅ deselect if tapped again
                        } else {
                          selectedRating = index + 1;
                        }
                      });
                    },
                              child: Icon(
                                Icons.star,
                                size: 28,
                                color: index < selectedRating
                                    ? Colors.orange
                                    : Colors.white,
                              ),
                            );
                          }),
                        ),
                        const Spacer(),
                        Text(
                          "$selectedRating stars",
                          style: GoogleFonts.poppins(),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  SizedBox(
  width: size.width*0.9, // ✅ your desired width
  child: Divider(
    thickness: 1,
    color: Colors.grey,
  ),
),

                  /// ================= OTHERS =================
                  const SizedBox(height: 10),

                  Text("Others",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600)),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(Icons.local_offer_outlined),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text("Discount",
                            style: GoogleFonts.poppins()),
                      ),
                      GestureDetector(
  onTap: () {
    setState(() {
      discount = !discount;
    });
  },
  child: Container(
    height: 22,
    width: 22,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: discount ? Colors.green : Colors.grey,
        width: 2,
      ),
      color: Colors.transparent, // ✅ always transparent
    ),
    child: Icon(
      Icons.check,
      size: 14,
      color: discount ? Colors.green : Colors.grey, // ✅ match border
    ),
  ),
)
                    ],
                  ),
                  SizedBox(height: size.height*0.01,),
                  Divider(),
                  SizedBox(height: size.height*0.01,),
                  Row(
                    children: [
                      const Icon(Icons.local_shipping_outlined),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text("Free Shipping",
                            style: GoogleFonts.poppins()),
                      ),
                     GestureDetector(
  onTap: () {
    setState(() {
      freeShipping = !freeShipping;
    });
  },
  child: Container(
    height: 22,
    width: 22,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: freeShipping ? Colors.green : Colors.grey,
        width: 2,
      ),
      color: Colors.transparent, // ✅ always transparent
    ),
    child: Icon(
      Icons.check,
      size: 14,
      color: freeShipping ? Colors.green : Colors.grey, // ✅ match border
    ),
  ),
)
                    ],
                  ),
                  SizedBox(height: size.height*0.01,),
                  Divider(),
                  SizedBox(height: size.height*0.01,),

                  Row(
                    children: [
                      const Icon(Icons.delivery_dining_outlined),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text("Same Day Delivery",
                            style: GoogleFonts.poppins()),
                      ),
                     GestureDetector(
  onTap: () {
    setState(() {
      sameDay = !sameDay;
    });
  },
  child: Container(
    height: 22,
    width: 22,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: sameDay ? Colors.green : Colors.grey,
        width: 2,
      ),
      color: Colors.transparent, // ✅ always transparent
    ),
    child: Icon(
      Icons.check,
      size: 14,
      color: sameDay ? Colors.green : Colors.grey, // ✅ match border
    ),
  ),
)
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// APPLY BUTTON
          Positioned(
                           bottom: size.height * 0.05,
                           left: 20,
                           right: 20,
                           child: Container(
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
                               onPressed: () { print("Min: ${minController.text}");
                  print("Max: ${maxController.text}");
                  print("Rating: $selectedRating");
                  print("Discount: $discount");
                  print("Free Shipping: $freeShipping");
                  print("Same Day: $sameDay");

                  Navigator.pop(context);},
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
                                     "Apply filter",
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
      ),
    );
  }
}