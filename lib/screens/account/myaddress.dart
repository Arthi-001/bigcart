import 'package:bigcart/model/addressmodel.dart';
import 'package:bigcart/screens/account/add_address.dart';
import 'package:bigcart/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyAddress extends StatefulWidget {
  const MyAddress({super.key});

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  final supabase = Supabase.instance.client;
  List<AddressModel> addressList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAddresses();
  }

  // 🔥 Fetch addresses from Supabase
  Future<void> loadAddresses() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    try {
      final data = await supabase
          .from('addresses')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      setState(() {
        addressList = (data as List)
            .map((e) => AddressModel.fromJson(e))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print("Error loading addresses: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // 🔥 Delete an address from Supabase
  Future<void> deleteAddress(AddressModel address) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    try {
      await supabase
          .from('addresses')
          .delete()
          .eq('user_id', user.id)
          .eq('phone', address.phone); // ideally use id

      loadAddresses();
    } catch (e) {
      print("Error deleting address: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(backgroundColor:  const Color(0xFFF4F5F9),
    
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "My Address",
          style: AppTextStyles.title
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddAddress()),
              );
              if (result == true) {
                loadAddresses();
              }
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : addressList.isEmpty
              ? Center(
                  child: Text(
                    "No address yet",
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: addressList.length,
                  itemBuilder: (context, index) {
                    final data = addressList[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
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
                          SizedBox(width: size.width * 0.03),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.name,
                                  style:AppTextStyles.bold,
                                ),
                                Text(
                                  "${data.address}, ${data.city}, ${data.zip}, ${data.country}",
                                  style: AppTextStyles.body,
                                ),
                                Text(
                                  data.phone,
                                  style: AppTextStyles.body,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.green),
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      AddAddress(existingData: data),
                                ),
                              );
                              if (result == true) loadAddresses();
                            },
                          ),
                          IconButton(
                            icon:
                                const Icon(Icons.delete_outline, color: Colors.green),
                            onPressed: () async {
                              deleteAddress(data);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}