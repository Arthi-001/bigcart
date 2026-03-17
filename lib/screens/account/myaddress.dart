import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Myaddress extends StatefulWidget {
  const Myaddress({super.key});

  @override
  State<Myaddress> createState() => _MyaddressState();
}

class _MyaddressState extends State<Myaddress> {
  bool isOn = false;
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
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
    title:  Text(
      "My Address",
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),

    
    actions: [
      IconButton(
        icon: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
           },
      ),
    ],
  ),

  body: SingleChildScrollView(
    child: SizedBox(height: size.height * 1.1,
      child: Stack(
        children:[ 
          Container(
          height: double.infinity,
          width: double.infinity, 
          color: const Color(0xFFF4F5F9),
           ),
          Positioned(
             top: size.height * 0.03,
             left: 20,
             right: 20,
            child: Container(
              height: size.height*0.15,
              width:size.width*0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                ),child:  Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        height: size.height*0.07,
                        width: size.height*0.07,
                        decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 190, 235, 192),
                                ),
                                child: const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.green,
                                ),
                              ),
                    ),
                    SizedBox(width: size.width*0.02,),
                    Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Home",
                    style:GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Kollam, Kerala",
                    style:GoogleFonts.poppins(fontWeight: FontWeight.w400),
                    
                  ),
                  Text(
                    "+1 202 555 ",
                    style:GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                ],
              ),
            ),
            SizedBox(width: size.width*0.02,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.menu_outlined,color: Colors.green,),
            )
      
                     
         ] ),
      )),
                
                
                 Positioned(
             top: size.height * 0.182,
             left: 20,
             right: 20,
            child: Container(
              height: size.height*0.4,
              width:size.width*0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
          children: [
            SizedBox(height: size.height * 0.03),
      
            buildInputField(Icons.person_outline, "Name", size.width * 0.85),
            SizedBox(height: size.height * 0.01),
      
            buildInputField(Icons.location_on_outlined, "Address", size.width * 0.85),
            SizedBox(height: size.height * 0.01),
      
           
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildInputField(Icons.location_city, "City", size.width * 0.4),
                buildInputField(Icons.pin_drop_outlined, "Zip Code", size.width * 0.4),
              ],
            ),
            SizedBox(height: size.height * 0.01),
            buildInputField(Icons.public_outlined, "Country", size.width * 0.85),
            SizedBox(height: size.height * 0.01),
            buildInputField(Icons.phone_outlined, "Phone number", size.width * 0.85),
            SizedBox(height: size.height * 0.01),
            SizedBox(height:size.height*0.001),
                            Row(
      children: [
        Transform.scale(scale: 0.8,
          child: Switch(
            value: isOn,
            activeTrackColor: Colors.green,
            activeThumbColor: Colors.white,
            onChanged: (value) {
              setState(() {
                isOn = value;
              });
            },
          ),
        ),
        Text("Make default",style: GoogleFonts.poppins( color: Colors.grey[700],fontSize: 15,fontWeight: FontWeight.w500)),
       
      ],
      ),
          ],
        ),
                )
                ),
                 Positioned(
             top: size.height * 0.62,
             left: 20,
             right: 20,
            child: Container(
              height: size.height*0.15,
              width:size.width*0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                ),
                child:  Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        height: size.height*0.07,
                        width: size.height*0.07,
                        decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 190, 235, 192),
                                ),
                                child: const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.green,
                                ),
                              ),
                    ),
                    SizedBox(width: size.width*0.02,),
                    Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Home",
                    style:GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Kollam, Kerala",
                    style:GoogleFonts.poppins(fontWeight: FontWeight.w400),
                    
                  ),
                  Text(
                    "+1 202 555 ",
                    style:GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                ],
              ),
            ),
            SizedBox(width: size.width*0.02,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.menu_outlined,color: Colors.green,),
            )
      
                     
         ] ),
                )
                ),
                SizedBox(height:size.height*0.02),
                         
                         Positioned(
                           bottom: size.height * 0.23,
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
                               onPressed: () {},
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
                                     "Save settings",
                                     style: GoogleFonts.poppins(
                                       fontSize: 15,
                                       color: Colors.white,
                                       fontWeight: FontWeight.bold,
                                     ),
                                   ),
                                 
                               
                             ),
                           ),
                         ),
      ]),
    ),
  ));
            
  }
  Widget buildInputField(IconData icon, String hint, double width) {
     final Size size=MediaQuery.of(context).size;
  return Container(
    height: size.height * 0.05,
    width: width,
    decoration: BoxDecoration(
      color: const Color(0xFFF4F5F9),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.all(size.width * 0.04),
          child: Icon(icon),
        ),
        SizedBox(width: size.width * 0.02),
        Text(
          hint,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
}