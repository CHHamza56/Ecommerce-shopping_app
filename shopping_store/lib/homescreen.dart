// ignore_for_file: camel_case_types, unused_import, prefer_const_constructors, unused_field, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, use_key_in_widget_constructors, avoid_print, library_private_types_in_public_api, non_constant_identifier_names, unused_local_variable
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:shopping_store/cart.dart';
import 'package:shopping_store/chatbot.dart';
import 'package:shopping_store/favourite.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_store/All.dart';
import 'package:shopping_store/Electronic.dart';
import 'package:shopping_store/jacket.dart';
import 'package:shopping_store/jean.dart';
import 'package:shopping_store/cloth.dart';
import 'package:http/http.dart' as http;

class homescreen extends StatefulWidget {
  const homescreen({super.key});
  @override
  State<homescreen> createState() => _homescreenState();
}

List<String> text1 = [
  'Categories',
  'Bags',
  'Shoes',
  'shopping_store',
  'Electronic',
];
List screen = [
  homescreen(),
  jacket(),
  All(),
];
int selectedIndex = 0;
int a = -1;

class _homescreenState extends State<homescreen> {
  List data = [];
  List filteredData = [];
  bool _isLoading = true;
  String searchQuery = '';
  File? _profileImage;
  bool isLoading = true;
  bool isLiked = false;
  Future insertData() async {
    var res = await http.post(
      Uri.parse(
          "https://apptocoder.com/CsHamza/shoppingProject/homescreen.php"),
    );
    var response = jsonDecode(res.body);
    setState(() {
      data.addAll(response);
      _isLoading = false;
    });
    print(data);
  }

  Future insertget(String img, String Text, String price) async {
    var res = await http.post(
        Uri.parse("https://apptocoder.com/CsHamza/shoppingProject/favicon.php"),
        body: {
          "img": img,
          "Text": Text,
          "price": price,
        });
    var response = jsonDecode(res.body);
  }

  final List<Widget> _pages = [All(), jacket(), jean(), cloth(), Electronic()];
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    insertData(); // Fetch data when the screen initializes
  }

  Future<void> _loadData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
  }

  void searchProducts(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredData = [...data];
      } else {
        filteredData = data
            .where((item) =>
                item['Text1'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Color.fromARGB(255, 138, 188, 211)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: GestureDetector(
                onTap: _pickImage,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : AssetImage('assets/images/default_profile.png'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'CH Hamza',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => cart()));
                  },
                  child: Icon(Icons.favorite)),
              title: Text('Add to cart'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text('Product History'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => chatbot()));
                },
                child: Text('Contact Us'),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: isLoading
          ? ShimmerLoading()
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 65),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome back!',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              'Falcon Thought',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: const Color.fromARGB(255, 238, 236, 236),
                          ),
                          width: 50,
                          height: 50,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => cart()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/images/carte.png'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 234, 231, 231),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        onChanged: (value) {
                          searchProducts(
                              value); // Call searchProducts on change
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: 'What are you looking for..',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 236, 232, 232),
                    ),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 165,
                    child: PageView(
                      children: [
                        // First page
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text('Shopping with us!',
                                      style: TextStyle(color: Colors.black)),
                                  SizedBox(height: 8),
                                  Text(
                                    'Get 40% Off for',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'all clothe',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    children: [
                                      Text(
                                        'Shop Now',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(Icons.arrow_forward),
                                    ],
                                  ),
                                ],
                              ),
                              Image.asset(
                                "assets/images/Mask group.png",
                                height: 135,
                                width: 110,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                        // Second page (Handbags)
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text('Buy Handbags!',
                                      style: TextStyle(color: Colors.black)),
                                  SizedBox(height: 8),
                                  Text(
                                    'Get 30% Off for',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'All Avaliable',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    children: [
                                      Text(
                                        'Shop Now',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(Icons.arrow_forward),
                                    ],
                                  ),
                                ],
                              ),
                              Image.asset(
                                "assets/images/bage2.png",
                                height: 135,
                                width: 110,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                        // Third page (Headphones)
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text('Buy Headphone!',
                                      style: TextStyle(color: Colors.black)),
                                  SizedBox(height: 8),
                                  Text(
                                    'Get 25% Off for',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'all headphones',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    children: [
                                      Text(
                                        'Shop Now',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(Icons.arrow_forward),
                                    ],
                                  ),
                                ],
                              ),
                              Image.asset(
                                "assets/images/head.png",
                                height: 135,
                                width: 110,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      height: 70,
                      child: ListView.builder(
                        itemCount: text1.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                              right: 10, top: 10, bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => _pages[index]),
                              );
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Color.fromARGB(255, 238, 236, 236),
                                boxShadow: [
                                  if (selectedIndex == index)
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(0, 3),
                                    ),
                                ],
                              ),
                              width: 120,
                              height: 45,
                              child: Center(
                                child: Text(
                                  text1[index],
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'New Arrival',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          'View All',
                          style: TextStyle(
                              color: Color.fromARGB(255, 187, 177, 177),
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 495,
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 1,
                      childAspectRatio: 0.8,
                      physics: NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 8,
                      children: List.generate(
                        searchQuery.isEmpty ? data.length : filteredData.length,
                        (index) => Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color.fromARGB(255, 230, 224, 224),
                                  ),
                                  width: 170,
                                  height: 155,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      searchQuery.isEmpty
                                          ? data[index]['img']
                                          : filteredData[index]['img'],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  searchQuery.isEmpty
                                      ? data[index]['Text1']
                                      : filteredData[index]['Text1'],
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  searchQuery.isEmpty
                                      ? data[index]['price']
                                      : filteredData[index]['price'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Positioned(
                                top: 0,
                                right: 17,
                                child: IconButton(
                                  icon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        a = index;
                                      });
                                      insertget(
                                          data[index]['img'],
                                          data[index]['Text1'],
                                          data[index]['price']);
                                    },
                                    child: Icon(
                                      isLiked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: a == index
                                          ? Colors.red
                                          : Color.fromARGB(255, 131, 128, 128),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isLiked = !isLiked;
                                    });
                                  },
                                )),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 165,
            color: Colors.white,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                height: 20,
                color: Colors.white,
              ),
              Container(
                width: 100,
                height: 20,
                color: Colors.white,
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 70,
            color: Colors.white,
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 495,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 8,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (_, __) => Container(
                width: 170,
                height: 155,
                color: Colors.white,
              ),
              itemCount: 4,
            ),
          ),
        ],
      ),
    );
  }
}
