
import 'package:bigcart/providers/cart_provider.dart';
import 'package:bigcart/screens/account/account.dart';
import 'package:bigcart/screens/cart/shopping_cart.dart';
import 'package:bigcart/screens/favourites/favourites.dart';
import 'package:bigcart/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
   
  int _selectedIndex = 0;
  @override
void initState() {
  super.initState();

  Provider.of<CartProvider>(context, listen: false).loadCart();
}

  
@override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    final List<Widget> pages = [
      Home(),
    Account(),
    Favourites(),
  ];
     
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar:  BottomAppBar(
        color: Colors.white,
      child: SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // keeps icons together
        children: [
           SizedBox(width: size.width*0.05),

          IconButton(
            icon: Icon(
              Icons.home_outlined,
              color: _selectedIndex == 0 ? Colors.black : Colors.grey,size: 30,
            ),
            onPressed: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
          ),

          SizedBox(width:size.width*0.15),

          IconButton(
            icon: Icon(
              Icons.person_outline,
              color: _selectedIndex == 1 ? Colors.black : Colors.grey,size: 30,
            ),
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
          ),

          SizedBox(width:size.width*0.15),

          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: _selectedIndex == 2 ? Colors.black : Colors.grey,size: 30,
            ),
            onPressed: () {
              setState(() {
                _selectedIndex = 2;
              });
            },
          ),
        ],
      ),
    ),
  ),
      floatingActionButton: ClipOval(
    child: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ const Color.fromARGB(255, 175, 245, 95),Colors.green]
          )),
      child: Center(
  child: Consumer<CartProvider>(
    builder: (context, provider, child) {
      return Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ShoppingCart(),
                ),
              );
            },
            child: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
              size: 28,
            ),
          ),

          if (provider.totalItems > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  provider.totalItems.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      );
    },
  ),
),
    ),
  ),

  floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}