import 'dart:io';

import 'package:bigcart/providers/searchhistoryprovider.dart';
import 'package:bigcart/screens/home/filter.dart';
import 'package:bigcart/screens/home/product_detail.dart';
import 'package:bigcart/utils/app_text_styles.dart';
import 'package:bigcart/widgets/searchoptioncontainer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:supabase_flutter/supabase_flutter.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredItems = [];
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  late stt.SpeechToText _speech;
  bool isListening = false;

  Set<String> favouriteIds = {};

  List<String> categories = [
    "Fresh Grocery",
    "Bananas",
    "Cheetos",
    "Fresh vegetables",
    "Discounted items",
    "Vegetables",
    "Fruits",
  ];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    loadFavourites();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) setState(() => selectedImage = File(image.path));
  }

  Future<void> pickImageFromGallery() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => selectedImage = File(image.path));
  }

  Future<void> loadFavourites() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final data = await supabase
        .from('favourites')
        .select('product_id')
        .eq('user_id', user.id);

    setState(() {
      favouriteIds =
          data.map<String>((item) => item['product_id'].toString()).toSet();
    });
  }

  void showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                pickImageFromCamera();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                pickImageFromGallery();
              },
            ),
          ],
        ),
      ),
    );
  }

  void startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => isListening = true);
      _speech.listen(onResult: (result) {
        setState(() {
          searchController.text = result.recognizedWords;
          onSearchChanged(result.recognizedWords);
        });
      });
    }
  }

  void stopListening() {
    _speech.stop();
    setState(() => isListening = false);
  }

  void onSearchChanged(String value) async {
    final supabase = Supabase.instance.client;
    if (value.isEmpty) {
      setState(() => filteredItems = []);
      return;
    }

    

    final response =
        await supabase.from('items').select().ilike('name', '%$value%');
    setState(() => filteredItems = List<Map<String, dynamic>>.from(response));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          height:size.height*0.05,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFEBEBEB),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Icon(Icons.search_outlined),
               SizedBox(width: size.width*0.01),
              Expanded(
                child: TextField(
                  controller: searchController,
                  onChanged: onSearchChanged,
                  onSubmitted: (query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

  
    Provider.of<SearchHistoryProvider>(context, listen: false)
        .addSearch(trimmed);

    // Run search
    onSearchChanged(trimmed);
  },
                  style: AppTextStyles.body,
                  decoration: InputDecoration(
                    hintText: "Search keywords..",
                    hintStyle: GoogleFonts.poppins(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.tune_outlined, color: Colors.grey),
                onPressed: () {
                   final query = searchController.text.trim();
    if (query.isEmpty) return;

    Provider.of<SearchHistoryProvider>(context, listen: false)
        .addSearch(query);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Filter()));
                },
              )
            ],
          ),
        ),
      ),
      body: Column(
  children: [

    if (searchController.text.isEmpty) ...[
      // SEARCH HISTORY
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Text(
              "Search History",
              style: AppTextStyles.title
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Provider.of<SearchHistoryProvider>(context, listen: false)
                    .clearHistory();
              },
              child: Text(
                "clear",
                style: AppTextStyles.blueText,
              ),
            ),
          ],
        ),
      ),

      Consumer<SearchHistoryProvider>(
        builder: (context, provider, child) {
          if (provider.history.isEmpty) return const SizedBox();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: provider.history.map((term) {
                return GestureDetector(
                  onTap: () {
                    searchController.text = term;
                    setState(() {});
                    onSearchChanged(term);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(term,
                        style: AppTextStyles.body),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),

      const SizedBox(height: 10),

      
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Text(
              "Discover more",
              style: AppTextStyles.title
            ),
          ],
        ),
      ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: categories.map((cat) {
            return GestureDetector(
              onTap: () {
                searchController.text = cat;
                setState(() {});
                onSearchChanged(cat);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(cat, style:AppTextStyles.body),
              ),
            );
          }).toList(),
        ),
      ),
    ],

    
    Expanded(
      child: searchController.text.isEmpty
          ? const SizedBox()
          : filteredItems.isEmpty
              ?  Center(
                  child: Text("No results found",
                      style: AppTextStyles.body),
                )
              : ListView.builder(
                  itemCount: filteredItems.length,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];

                    return Container(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: Image.network(
                          item['image_url'] ?? '',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          item['name'] ?? '',
                          style: AppTextStyles.bold,
                        ),
                        subtitle: Text(
                          "\$${item['price']}",
                          style: AppTextStyles.greenText,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetail(
                                product: item,
                                isFavourite: favouriteIds.contains(
                                    item['id']?.toString() ?? ""),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    ),

    SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: SearchOptionContainer(
                icon: Icons.camera_alt_outlined,
                text: "Image Search",
                onTap: showImagePickerOptions,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SearchOptionContainer(
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
            ),
          ],
        ),
      ),
    ),
  ],
)
    );
  }
}