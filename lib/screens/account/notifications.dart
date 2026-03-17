import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool allowNotifications = false;
bool emailNotifications = false;
bool orderNotifications = false;
bool generalNotifications = false;
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
      "Notifications",
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),

    
   
  ),
  body: Stack(
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
                    
                    SizedBox(width: size.width*0.02,),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                      "Allow notifications",
                      style:GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold),
                                        ),
                                         SizedBox(height: size.height*0.02,),
                                        Text(
                      "Turn on notifications to receive  ",
                      style:GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      
                                        ),
                                        Text(
                      "updates,alerts, and special offers.",
                      style:GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                    ),
            SizedBox(width: size.width*0.05,),
           Transform.scale(scale: 0.8,
          child: Switch(
            value: allowNotifications,
            activeTrackColor: Colors.green,
            activeThumbColor: Colors.white,
            onChanged: (value) {
              setState(() {
                allowNotifications = value;
              });
            },
          ),
        ),
      
                     
         ] ),
      )),
                
                
                 Positioned(
             top: size.height * 0.19,
             left: 20,
             right: 20,
            child: Container(
              height: size.height*0.15,
              width:size.width*0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                ),
                child:Row(
                  children: [
                    
                    SizedBox(width: size.width*0.02,),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                      "Email notifications",
                      style:GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold),
                                        ),
                                         SizedBox(height: size.height*0.02,),
                                        Text(
                      "Get updates, offers, and   ",
                      style:GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      
                                        ),
                                        Text(
                      "important alerts in your inbox.",
                      style:GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                    ),
            SizedBox(width: size.width*0.12,),
           Transform.scale(scale: 0.8,
          child: Switch(
            value: emailNotifications,
            activeTrackColor: Colors.green,
            activeThumbColor: Colors.white,
            onChanged: (value) {
              setState(() {
                emailNotifications= value;
              });
            },
          ),
        ),
      
                     
         ] ), 
                )
                ),
                 Positioned(
             top: size.height * 0.35,
             left: 20,
             right: 20,
            child: Container(
              height: size.height*0.15,
              width:size.width*0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    
                    SizedBox(width: size.width*0.02,),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                      "Order notifications",
                      style:GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold),
                                        ),
                                         SizedBox(height: size.height*0.02,),
                                        Text(
                      "Stay updated about your   ",
                      style:GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      
                                        ),
                                        Text(
                      "order status.",
                      style:GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                    ),
            SizedBox(width: size.width*0.17,),
           Transform.scale(scale: 0.8,
          child: Switch(
            value: orderNotifications,
            activeTrackColor: Colors.green,
            activeThumbColor: Colors.white,
            onChanged: (value) {
              setState(() {
                orderNotifications = value;
              });
            },
          ),
        ),
      
                     
         ] ),
                )
                ),
                 Positioned(
             top: size.height * 0.51,
             left: 20,
             right: 20,
            child: Container(
              height: size.height*0.15,
              width:size.width*0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    
                    SizedBox(width: size.width*0.02,),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                      "General notifications",
                      style:GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold),
                                        ),
                                         SizedBox(height: size.height*0.02,),
                                        Text(
                      "Get notified about important   ",
                      style:GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      
                                        ),
                                        Text(
                      "updates and activity.",
                      style:GoogleFonts.poppins(fontWeight: FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                    ),
            SizedBox(width: size.width*0.11,),
           Transform.scale(scale: 0.8,
          child: Switch(
            value: generalNotifications,
            activeTrackColor: Colors.green,
            activeThumbColor: Colors.white,
            onChanged: (value) {
              setState(() {
                generalNotifications = value;
              });
            },
          ),
        ),
      
                     
         ] ),
                )
                ),
                SizedBox(height:size.height*0.02),
                         
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

    );
  }
}