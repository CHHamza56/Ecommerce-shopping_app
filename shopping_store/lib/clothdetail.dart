// ignore_for_file: camel_case_types, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, non_constant_identifier_names, use_super_parameters, avoid_print

import 'dart:convert';

import 'package:shopping_store/address.dart';
import 'package:shopping_store/clothcartt.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;
// Import your cart widget

class Clothdetail extends StatefulWidget {
  final String img1;
  final String img2;
  final String img3;
  final String name;
  final String Text2;
  final String rating;
  final String review;
  final String price;
  final String size;
  final String S;
  final String M;
  final String L;
  final String XL;
  final String cllr;
  final String cllr2;
  final String cllr3;
  final String des;

  const Clothdetail({
    required this.img1,
    required this.img2,
    required this.img3,
    required this.name,
    required this.Text2,
    required this.rating,
    required this.review,
    required this.price,
    required this.size,
    required this.S,
    required this.M,
    required this.L,
    required this.XL,
    required this.cllr,
    required this.cllr2,
    required this.cllr3,
    required this.des,
    Key? key,
  }) : super(key: key);

  @override
  State<Clothdetail> createState() => _clothdetailState();
}

class _clothdetailState extends State<Clothdetail> {
  final PageController _pageController = PageController();
  String selectedSize = 'L';
  Color selectedColor = Colors.black;
  int quantity = 1;
  Future _insertData() async {
    print("hgdhg");
    try {
      var res = await http.post(
        Uri.parse(
            "https://apptocoder.com/CsHamza/shoppingProject/clothcart.php"),
        body: {
          "img1": widget.img1,
          "name": widget.name,
          "price": widget.price,
          "qnty": quantity.toString(),
          "clr": widget.cllr,
          "size": widget.S,
          "uid": "1",
        },
      );
      var response = jsonDecode(res.body);
      print(response.toString());
      if (response["Success"] == 'true') {
        print("Success");
        var snackBar = SnackBar(
          content: Text('Item added to cart'),
          action: SnackBarAction(
            label: 'Go to Cart',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => clothcartt()),
              );
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        print("Failed");
        // Handle failure if needed
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F5F5),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image Section
            Container(
              height: 300,
              child: Stack(
                children: [
                  PageView(
                    controller: _pageController,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(widget.img1),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(widget.img2),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(widget.img3),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: 3,
                        effect: WormEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          spacing: 8,
                          dotColor: Colors.grey.shade400,
                          activeDotColor: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Product Description
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        width: 35,
                        height: 35,
                        child: IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (quantity > 1) {
                                quantity--;
                              }
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '$quantity',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        width: 35,
                        height: 35,
                        child: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Product Sub-Title
                  Text(
                    widget.Text2,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Rating Section
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      const Icon(
                        Icons.star_half,
                        color: Colors.amber,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(${widget.review})',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Price
                  Text(
                    "\$ " + widget.price,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Size Selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Size',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(widget.size),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      buildSizeButton('S'),
                      const SizedBox(width: 12),
                      buildSizeButton('M'),
                      const SizedBox(width: 12),
                      buildSizeButton('L'),
                      const SizedBox(width: 12),
                      buildSizeButton('XL'),
                      const SizedBox(width: 35),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            width: 45,
                            height: 145,
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                buildColorButton(Color(int.parse(widget.cllr))),
                                const SizedBox(height: 12),
                                buildColorButton(
                                    Color(int.parse(widget.cllr2))),
                                const SizedBox(height: 12),
                                buildColorButton(
                                    Color(int.parse(widget.cllr3))),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Description',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.des,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  // Quantity Section
                  const SizedBox(height: 24),

                  // Buttons Section
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              _insertData();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: GestureDetector(
                            onTap: () {},
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => address()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 194, 179, 21),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Buy Now',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSizeButton(String size) {
    return SizedBox(
      width: 45,
      height: 45,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedSize = size;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedSize == size ? Colors.black : Colors.white,
          shape: const CircleBorder(),
          elevation: 0,
        ),
        child: Text(
          size,
          style: TextStyle(
            fontSize: 14,
            color: selectedSize == size ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget buildColorButton(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selectedColor == color
                ? const Color.fromARGB(255, 255, 255, 255)
                : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }
}
