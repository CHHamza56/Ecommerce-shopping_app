// ignore_for_file: file_names, unnecessary_import, unused_import, prefer_const_constructors
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:shopping_store/chatbot.dart';
import 'package:shopping_store/favourite.dart';
import 'package:shopping_store/homescreen.dart';
import 'package:shopping_store/jacket.dart';
import 'package:shopping_store/jean.dart';
import 'package:shopping_store/payment.dart';
import 'package:flutter/material.dart';

class AllTab extends StatefulWidget {
  const AllTab({super.key});
  @override
  State<AllTab> createState() => _AllTabState();
}

class _AllTabState extends State<AllTab> {
  List<TabItem> items = [
    TabItem(
      icon: Icons.home,
      title: 'Home',
    ),
    TabItem(
      icon: Icons.favorite,
      title: 'favorite',
    ),
    TabItem(
      icon: Icons.payment_outlined,
      title: 'payment',
    ),
    TabItem(
      icon: Icons.chat,
      title: 'contact',
    ),
  ];
  List screen = [
    homescreen(),
    favourite(),
    payment(),
    chatbot(),
  ];
  int visit = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomBarFloating(
          items: items,
          backgroundColor: Color.fromARGB(221, 206, 198, 198),
          color: Color.fromARGB(255, 241, 237, 237),
          colorSelected: Color.fromARGB(222, 41, 40, 40),
          indexSelected: visit,
          onTap: (int index) => setState(() {
            visit = index;
          }),
        ),
        body: screen[visit]);
  }
}
