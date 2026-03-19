import 'package:bigcart/model/addressmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAddress extends StatefulWidget {
  final AddressModel? existingData;
  const AddAddress({super.key,this.existingData});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  @override
void initState() {
  super.initState();
  if (widget.existingData != null) {
    nameController.text = widget.existingData!.name;
    emailController.text = widget.existingData!.email;
    phoneController.text = widget.existingData!.phone;
    addressController.text = widget.existingData!.address;
    cityController.text = widget.existingData!.city;
    zipController.text = widget.existingData!.zip;
    selectedCountry = widget.existingData?.country;
  }
}
  bool isOn=false;
  TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController zipController = TextEditingController();
TextEditingController cityController = TextEditingController();

String? selectedCountry;
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
      "Add Address",
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),

    
   
  ),
  body:SingleChildScrollView(
    child: SizedBox(height: size.height * 1.1,
      child: Stack(
        children: [ Container(
                height: double.infinity,
                width: double.infinity,
                color: const Color(0xFFF4F5F9),
                 ),
      
    
   
           Positioned(
            top: size.height * 0.03,
             left: 20,
             right: 20,
             child: Column(
                   children: [
                     
                     
                       
                       buildInputField(Icons.person_outline, "Name", size.width * 0.85, controller: nameController),
                       SizedBox(height: size.height * 0.01),
             
                       buildInputField(Icons.mail_outline, "Email Address", size.width * 0.85, controller: emailController),
                       SizedBox(height: size.height * 0.01),
             
                       
                buildInputField(Icons.phone_outlined, "Phone number", size.width * 0.85, controller: phoneController),
                SizedBox(height: size.height * 0.01),
                buildInputField(Icons.pin_drop_outlined, "address", size.width * 0.85, controller: addressController),
              
                       SizedBox(height: size.height * 0.01),
             
                       buildInputField(Icons.home_outlined, "Zip code", size.width * 0.85, controller: zipController),
                       SizedBox(height: size.height * 0.01),
             
                       buildInputField(Icons.map_outlined, "City", size.width * 0.85, controller: cityController),
                       SizedBox(height: size.height * 0.01),
                       buildCountryDropdown(size.width * 0.85),
             Row(
              children: [
               
                Transform.scale(
                  scale: 0.8,
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
                Text(
                  "Save this address",
                  style: GoogleFonts.poppins(
                    color: Colors.grey[700],
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
                       ),
                      
                 ]),
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
                               onPressed: () {
                                Navigator.pop(
    context,
    AddressModel(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      address: addressController.text,
      city: cityController.text,
      zip: zipController.text,
      country: selectedCountry ?? "",
    ),
  );},
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
                         ),
  ]))));
  }
  Widget buildInputField(IconData icon, String hint, double width,{
  TextEditingController? controller, // 👈 ADD THIS
}) {
  final Size size = MediaQuery.of(context).size;

  return Center(
    child: Container(
      height: size.height * 0.07,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
         controller: controller,
        style: GoogleFonts.poppins(fontSize: 14),
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hint,
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    ),
  );
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