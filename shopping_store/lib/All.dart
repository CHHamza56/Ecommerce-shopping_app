// ignore_for_file: prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, sized_box_for_whitespace, avoid_print
import 'dart:convert';
import 'package:shopping_store/cloth.dart';
import 'package:shopping_store/electronic.dart';
import 'package:shopping_store/homescreen.dart';
import 'package:shopping_store/jacket.dart';
import 'package:shopping_store/jean.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class All extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ProductCard(),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  List data = [];
  List filteredData = [];
  bool _isLoading = true;
  TextEditingController searchController = TextEditingController();
  Future insertData() async {
    var res = await http.post(
      Uri.parse("https://apptocoder.com/CsHamza/shoppingProject/categorie.php"),
    );
    var response = jsonDecode(res.body);
    setState(() {
      data.addAll(response);
      filteredData = data;
      _isLoading = false;
    });
    print(data);
  }

  @override
  void initState() {
    super.initState();
    insertData();
    searchController.addListener(() {
      filterData();
    });
  }

  void filterData() {
    List tempData = [];
    if (searchController.text.isNotEmpty) {
      tempData = data
          .where((item) =>
              item['Text1']
                  .toString()
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()) ||
              item['Text2']
                  .toString()
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()))
          .toList();
    } else {
      tempData = data;
    }
    setState(() {
      filteredData = tempData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => homescreen()));
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 18,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Categories',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            fontSize: 16),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 244, 240, 240),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: 'Search Categories',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 565,
                    child: ListView.builder(
                      itemCount: filteredData.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        bool isEven = index % 2 == 0;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 236, 232, 232),
                            ),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 130,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                children: [
                                  if (isEven) ...[
                                    GestureDetector(
                                      onTap: () {
                                        navigateToCategory(int.parse(
                                            filteredData[index]['id']));
                                      },
                                      child: Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                filteredData[index]['Text1'],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                '${filteredData[index]['Text2']}',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        filteredData[index]['id'];
                                      },
                                      child: Expanded(
                                        child: Image.network(
                                          filteredData[index]['image'],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ] else ...[
                                    GestureDetector(
                                      onTap: () {
                                        navigateToCategory(index);
                                      },
                                      child: Image.network(
                                        filteredData[index]['image'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                navigateToCategory(index);
                                              },
                                              child: Text(
                                                filteredData[index]['Text1'],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Text(
                                              '${filteredData[index]['Text2']}',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void navigateToCategory(int index) {
    print(index.toString());
    if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => cloth()));
    } else if (index == 3) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => jacket()));
    } else if (index == 4) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => jean()));
    } else if (index == 5) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Electronic()));
    }
  }
}

void main() {
  runApp(MaterialApp(home: All()));
}
