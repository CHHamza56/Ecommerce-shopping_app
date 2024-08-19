// ignore_for_file: sized_box_for_whitespace, prefer_const_literals_to_create_immutables, camel_case_types, avoid_print, unused_local_variable, prefer_interpolation_to_compose_strings
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_store/payment.dart';
import 'package:flutter/material.dart';

class cart extends StatefulWidget {
  const cart({super.key});
  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  List<int> quantities = [1, 1, 1];
  List cart = [
    "assets/images/bage1.png",
    "assets/images/bage2.png",
    "assets/images/red.png",
  ];
  List bag = [
    "Handbag",
    "Black bag",
    "Red bag",
  ];
  List price = [
    "\$29.99",
    "\$19.99",
    "\$50.00",
  ];
  List size = [
    "S",
    "M",
    "L",
  ];
  int t = 0;
  int total = 0;
  List<dynamic> data = [];
  Future<void> fetchData() async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://apptocoder.com/CsHamza/shoppingProject/cartdetail.php"),
        body: {"uid": "1"},
      );
      if (response.statusCode == 200) {
        setState(() {
          data = jsonDecode(response.body);
        });
        for (int i = 0; i < data.length; i++) {
          setState(() {
            t = int.parse(data[i]['qnty']) + t;
            total = int.parse(data[i]['price']) + total;
          });
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> removecart(String id) async {
    try {
      final response = await http.post(
        Uri.parse("https://apptocoder.com/CsHamza/shoppingProject/delcart.php"),
        body: {"id": id},
      );
      setState(() {
        data.clear();
        t = 0;
        total = 0;
        fetchData();
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  int getTotalQuantity() {
    return quantities.fold(0, (sum, item) => sum + item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios),
                  ),
                  Text(
                    'Cart',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        width: 40,
                        height: 40,
                        child: Image.asset(
                          "assets/images/carte.png",
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            t.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 239, 237, 237),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 250, 247, 247)
                              .withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 188, 184, 184),
                          ),
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 120,
                          child: Image.network(
                            data[index]['img1'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      data[index]['name'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(
                                        data[index]['size'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "\$ " + data[index]['price'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color.fromARGB(255, 251, 248, 248),
                                    ),
                                    width: 25,
                                    height: 25,
                                    child: IconButton(
                                      icon: Center(
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.black,
                                          size: 13,
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          if (int.parse(data[index]['qnty']) >
                                              1) {
                                            quantities[index]--;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '${data[index]['qnty']}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color.fromARGB(255, 251, 248, 248),
                                    ),
                                    width: 25,
                                    height: 25,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        size: 13,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          quantities[index]++;
                                        });
                                      },
                                    ),
                                  ),
                                  Spacer(),
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
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 18,
                  ),
                  child: Text(
                    'Order summary',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sub Total',
                        style: TextStyle(
                          color: Color.fromARGB(255, 28, 28, 28),
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "\$ " + total.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shipping',
                        style: TextStyle(
                          color: Color.fromARGB(255, 28, 28, 28),
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "\$5.00",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          color: Color.fromARGB(255, 28, 28, 28),
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        (total + 5).toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Handle checkout process here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 29, 29, 30),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => payment()));
                      },
                      child: Text(
                        'Checkout',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
