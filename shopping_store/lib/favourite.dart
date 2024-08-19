// ignore_for_file: camel_case_types, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print, unused_local_variable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class favourite extends StatefulWidget {
  const favourite({super.key});
  @override
  State<favourite> createState() => _favouriteState();
}

class _favouriteState extends State<favourite> {
  List data = [];
  int t = 0;
  int total = 0;
  Future insertData() async {
    var res = await http.post(
      Uri.parse("https://apptocoder.com/CsHamza/shoppingProject/favourite.php"),
    );
    var response = jsonDecode(res.body);
    setState(() {
      data.addAll(response);
    });
    print(data);
  }

  Future<void> removecart(String id) async {
    try {
      final response = await http.post(
        Uri.parse("https://apptocoder.com/CsHamza/shoppingProject/delfav.php"),
        body: {"id": id},
      );
      setState(() {
        data.clear();
        t = 0;
        total = 0;
      });
      insertData();
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    insertData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 45,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  'Favourite',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 630,
              child: ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 236, 232, 232),
                      ),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 130,
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black26),
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 130,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    data[index]['img'],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Icon(
                                  Icons.favorite_border,
                                  color: Color.fromARGB(255, 211, 208, 208),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '\$${data[index]['price']}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(data[index]['Text']),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          removecart(data[index]['id']);
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
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
}

void main() {
  runApp(MaterialApp(
    home: favourite(),
  ));
}
