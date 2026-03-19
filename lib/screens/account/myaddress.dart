import 'dart:convert';

import 'package:bigcart/model/addressmodel.dart';
import 'package:bigcart/screens/account/add_address.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';




class Myaddress extends StatefulWidget {
  
   final String name;
  final String email;
  final String phone;
  final String address;
  final String zip;
  final String city;
  final String country;
  const Myaddress({
    super.key,
    required this.address,
    required this.zip,
    required this.city,
    required this.country,
    required this.name,
    required this.email,
    required this.phone});

  @override
  State<Myaddress> createState() => _MyaddressState();
}

class _MyaddressState extends State<Myaddress> {
  Future<void> saveAddresses() async {
  final prefs = await SharedPreferences.getInstance();

  List<String> addressJsonList =
      addressList.map((e) => jsonEncode(e.toJson())).toList();

  await prefs.setStringList('addresses', addressJsonList);
}
Future<void> loadAddresses() async {
  final prefs = await SharedPreferences.getInstance();

  List<String>? addressJsonList = prefs.getStringList('addresses');

  if (addressJsonList != null) {
    setState(() {
      addressList = addressJsonList
          .map((e) => AddressModel.fromJson(jsonDecode(e)))
          .toList();
    });
  }
}

  List<AddressModel> addressList = [];
  @override
void initState() {
  super.initState();
  loadAddresses();

  name = widget.name;
  address = widget.address;
  city = widget.city;
  zip = widget.zip;
  country = widget.country;
  phone = widget.phone;
}
  bool isOn = false;
  bool showForm = false;
  TextEditingController nameController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController zipController = TextEditingController();
TextEditingController countryController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController emailController = TextEditingController();


// Stored data
String name = "";
String address = "";
String city = "";
String zip = "";
String country = "";
String phone = "";
String email="";
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
        onPressed: () async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AddAddress(),
    ),
  );

  if (result != null && result is AddressModel) {
    setState(() {
      addressList.add(result);
       
    });
     saveAddresses(); 
  }
},),
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
  top: size.height * 0.05,
  left: 0,
  right: 0,
  child: SizedBox(
    height: size.height * 0.7,
    child: ListView.builder(
      itemCount: addressList.length,
      itemBuilder: (context, index) {
        final data = addressList[index];

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                height: size.height * 0.07,
                width: size.height * 0.07,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 190, 235, 192),
                ),
                child: const Icon(
                  Icons.location_on_outlined,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: size.width * 0.02),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${data.address}, ${data.city}",
                      style: GoogleFonts.poppins(),
                    ),
                    Text(
                      data.phone,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: size.width * 0.02),
              IconButton(
      icon: Icon(Icons.edit, color: Colors.green),
      onPressed: () async {
        final updated = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddAddress(
              existingData: data, 
            ),
          ),
        );

        if (updated != null && updated is AddressModel) {
          setState(() {
            addressList[index] = updated; 
          });
          saveAddresses();
        }
      },
    ),
               IconButton(
        icon: Icon(Icons.delete_outline, color: Colors.green),
        onPressed: () {
          setState(() {
            addressList.removeAt(index); 
          });
          saveAddresses(); 
        },
      ),
            ],
          ),
        );
      },
    ),
  ),
),
                
                 
      ]),
    ),
  ));
            
  }
 Widget buildInputField(IconData icon, String hint, double width,{
  TextEditingController? controller, // 👈 ADD THIS
}) {
  final Size size = MediaQuery.of(context).size;

  return Container(
    height: size.height * 0.06,
    width: width,
    decoration: BoxDecoration(
      color: const Color(0xFFF4F5F9),
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
  );
}
}