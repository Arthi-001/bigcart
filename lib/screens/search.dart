import 'dart:io';

import 'package:bigcart/screens/filter.dart';
import 'package:bigcart/widgets/searchoptioncontainer.dart';
import 'package:bigcart/widgets/textcontainer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final ImagePicker _picker = ImagePicker();
File? selectedImage;

Future<void> pickImageFromCamera() async {
  final XFile? image = await _picker.pickImage(source: ImageSource.camera);

  if (image != null) {
    setState(() {
      selectedImage = File(image.path);
    });
    print("Camera image selected: ${image.path}");
  }
}

Future<void> pickImageFromGallery() async {
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    setState(() {
      selectedImage = File(image.path);
    });
    print("Gallery image selected: ${image.path}");
  }
}
void showImagePickerOptions() {
  showModalBottomSheet(
    context: context,
    builder: (_) {
      return SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                pickImageFromCamera();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                pickImageFromGallery();
              },
            ),
          ],
        ),
      );
    },
  );
}
late stt.SpeechToText _speech;
bool isListening = false;
@override
void initState() {
  super.initState();
  _speech = stt.SpeechToText();
}
void startListening() async {
  bool available = await _speech.initialize();

  if (available) {
    setState(() => isListening = true);

    _speech.listen(
      onResult: (result) {
        setState(() {
          searchController.text = result.recognizedWords;
        });
      },
    );
  }
}

void stopListening() {
  _speech.stop();
  setState(() => isListening = false);
}
  TextEditingController searchController = TextEditingController();

  void onSearchChanged(String value) {
    // 👉 Use this for API call later
    print("Searching: $value");
  }
   List<String> categories = [
    "Fresh Grocery",
    "Bananas",
    "cheetos",
    "Fresh vegetables",
    "Discounted items",
    "Vegetables",
    "Fruits",
    
  ];
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(appBar: AppBar(
    backgroundColor: Colors.white,
    elevation: 0,

    
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: Container(
                            height:size.height*0.05,
                           
                            
                            decoration: BoxDecoration(
                              color: const Color(0xFFEBEBEB),
                              border: Border.all(color:const Color(0xFFEBEBEB) ),
                              borderRadius: BorderRadius.circular(10),),
                              child: Row(children: [
                                Padding(
                                  padding:  EdgeInsets.all( MediaQuery.of(context).size.width * 0.03),
                                  child: Icon(Icons.search_outlined)
                                ),
                                SizedBox(width:size.width*0.02),
                                Expanded(
                child: TextField(
                  controller: searchController,
                  onChanged: onSearchChanged,
                  style: GoogleFonts.poppins(fontSize: 14),

                  decoration: InputDecoration(
                    hintText: "Search keywords..",
                    hintStyle: GoogleFonts.poppins(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
                                SizedBox(width:size.width*0.1),
                                 
                              IconButton(
                onPressed: () {
                  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Filter(),
      ),
    );
                },
                icon: const Icon(Icons.tune_outlined, color: Colors.grey),
              ),  
        ]),
    ),
    
    ),
      body: Stack(
        children: [ 
         
                 Container(
             height: double.infinity,
            color: const Color(0xFFF4F5F9),
                 ),
                 Positioned(top: size.height*0.03,
                 left: 20,
                 right: 20,
                  child: Row(
                   children: [
                     Text("Search History",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
                     SizedBox(width: size.width*0.45,),
                      Text("clear",style: GoogleFonts.poppins(fontSize: 15,color: Colors.blue),),

                   ],
                 )),
                 Positioned(top: size.height*0.1,
                 left: 20,
                 right: 20,
                  child: Row(
                   children: [
                     Text("Discover more",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
                     SizedBox(width: size.width*0.45,),
                      Text("clear",style: GoogleFonts.poppins(fontSize: 15,color: Colors.blue),),

                   ],
                 )),
                 Positioned(top: size.height*0.16,
                 left: 20,
                 right: 20,
                  child: TextContainer(items: categories,),
   
),
Positioned(
  bottom: size.height * 0.02, // adjust if needed
  left: 20,
  right: 20,
  child: Row(
    children: [
      SearchOptionContainer(
        icon: Icons.camera_alt_outlined,
        text: "Image Search",
        onTap: showImagePickerOptions,
      ),
      const SizedBox(width: 10),
      SearchOptionContainer(
        icon: Icons.mic_none,
        text: "Voice Search",
        onTap: () {
          if (isListening) {
      stopListening();
    } else {
      startListening();
    }
  },
        
      ),
    ],
  ),
),
                 
        
           

                  
    ],))
      ;
  }
}