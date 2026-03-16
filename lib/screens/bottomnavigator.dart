import 'package:bigcart/screens/account.dart';
import 'package:bigcart/screens/home.dart';
import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;

  // List of screens (replace with your actual screens)
  final List<Widget> _pages = [
    const  Home(),
    const Account(),
    Center(child: Text('Profile Page')),
  ];


  @override
  Widget build(BuildContext context) {
     final Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: _pages[_selectedIndex],
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
      child: const Center(
        child: Icon(
          Icons.shopping_bag_outlined,
          color: Colors.white,
          size: 28,
        ),
      ),
    ),
  ),

  floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}