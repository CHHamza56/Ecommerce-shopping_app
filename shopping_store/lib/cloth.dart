// ignore_for_file: camel_case_types, library_private_types_in_public_api, use_key_in_widget_constructors, unused_field, sized_box_for_whitespace, avoid_print
import 'dart:convert';
import 'package:shopping_store/clothdetail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class cloth extends StatefulWidget {
  const cloth({super.key});
  @override
  State<cloth> createState() => _clothState();
}

List images = [
  "assets/images/cloth1.png",
  "assets/images/cloth2.png",
  "assets/images/cloth3.png",
  "assets/images/Men.png",
  "assets/images/5.png",
  "assets/images/cloth6.png",
];
List name = [
  "blue Nicke shoes",
  "Black shoes",
  "white shoes",
  "Grey shoes",
  "women shoes",
  "Casual shoes",
];
List price = [
  "\$29.99",
  "\$19.99",
  "\$50.00",
  "\$49.99",
  "\$39.99",
  "\$49.99",
];

class _clothState extends State<cloth> {
  List data = [];
  bool _isLoading = true;

  Future insertData() async {
    var res = await http.post(
      Uri.parse(
          "https://apptocoder.com/CsHamza/shoppingProject/shopping_store.php"),
    );
    var response = jsonDecode(res.body);
    setState(() {
      data.addAll(response);
      _isLoading = false; // Set loading to false when data is fetched
    });
    print(data);
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
          ? Center(child: CircularProgressIndicator())
          : Column(
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
                      'shopping_store',
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
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 8,
                    children: List.generate(
                      data.length,
                      (index) => Stack(
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Clothdetail(
                                                img1: data[index]['img1'],
                                                img2: data[index]['img2'],
                                                img3: data[index]['img3'],
                                                name: data[index]['name'],
                                                Text2: data[index]['Text2'],
                                                rating: data[index]['rating'],
                                                review: data[index]['review'],
                                                price: data[index]['price'],
                                                size: data[index]['size'],
                                                cllr: data[index]['cllr'],
                                                cllr2: data[index]['cllr2'],
                                                cllr3: data[index]['cllr3'],
                                                des: data[index]['des'],
                                                L: data[index]['L'],
                                                S: data[index]['S'],
                                                M: data[index]['M'],
                                                XL: data[index]['XL'],
                                              )));
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
                                    child: Image.network(
                                      data[index]['img'],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                data[index]['Text1'],
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                data[index]['Text2'],
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
