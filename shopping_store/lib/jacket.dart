// ignore_for_file: avoid_print, camel_case_types, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, use_key_in_widget_constructors, library_private_types_in_public_api
import 'dart:convert';
import 'package:shopping_store/detailpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class jacket extends StatefulWidget {
  const jacket({super.key});
  @override
  State<jacket> createState() => _jacketState();
}

class _jacketState extends State<jacket> {
  List data = [];
  List filteredData = [];
  bool _isLoading = true;
  String searchQuery = '';
  Future insertData() async {
    var res = await http.post(
      Uri.parse("https://apptocoder.com/CsHamza/shoppingProject/bag.php"),
    );
    var response = jsonDecode(res.body);
    setState(() {
      data.addAll(response);
      filteredData.addAll(data);
      _isLoading = false; // Set loading to false when data is fetched
    });
    print(filteredData);
  }

  void _filterData(String query) {
    setState(() {
      searchQuery = query;
      filteredData = data
          .where((item) =>
              item['Text1'].toLowerCase().contains(query.toLowerCase()) ||
              item['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    insertData();
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
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 18,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Handbags',
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
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 234, 231, 231),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        onChanged: (value) {
                          _filterData(value);
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: 'search bags',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 645, // Increased height to accommodate 6 containers
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 1,
                      padding: EdgeInsets.only(bottom: 60, top: 20),
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 8,
                      children: List.generate(
                        filteredData.length,
                        (index) => Stack(
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => detailpage(
                                          img1: filteredData[index]['img1'],
                                          img2: filteredData[index]['img2'],
                                          img3: filteredData[index]['img3'],
                                          name: filteredData[index]['name'],
                                          Text2: filteredData[index]['Text2'],
                                          rating: filteredData[index]['rating'],
                                          review: filteredData[index]['review'],
                                          price: filteredData[index]['price'],
                                          size: filteredData[index]['size'],
                                          cllr: filteredData[index]['color'],
                                          cllr2: filteredData[index]['color2'],
                                          cllr3: filteredData[index]['color3'],
                                          des: filteredData[index]['des'],
                                          L: filteredData[index]['L'],
                                          S: filteredData[index]['S'],
                                          M: filteredData[index]['M'],
                                          XL: filteredData[index]['XL'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color.fromARGB(255, 230, 224, 224),
                                    ),
                                    width: 170,
                                    height: 155,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: filteredData[index]['img']
                                              .toString()
                                              .isEmpty
                                          ? Icon(
                                              Icons.image,
                                              size: 90,
                                            )
                                          : Image.network(
                                              filteredData[index]['img'],
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  filteredData[index]['Text1'],
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "\$ " + filteredData[index]['price'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 0,
                              right: 17,
                              child: HeartIcon(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class HeartIcon extends StatefulWidget {
  @override
  _HeartIconState createState() => _HeartIconState();
}

class _HeartIconState extends State<HeartIcon> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
        color: isLiked ? Colors.red : Color.fromARGB(255, 94, 87, 87),
      ),
      onPressed: () {
        setState(() {
          isLiked = !isLiked;
        });
      },
    );
  }
}

void main() {
  runApp(MaterialApp(home: jacket()));
}
