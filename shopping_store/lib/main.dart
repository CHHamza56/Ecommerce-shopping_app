// ignore_for_file: prefer_const_constructors, unused_import, prefer_final_fields, prefer_const_literals_to_create_immutables, use_super_parameters
import 'dart:convert';
import 'package:shopping_store/Tab.dart';
import 'package:flutter/material.dart';
import 'package:shopping_store/register.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: OnboardingScreen(),
    );
  }
}
// class StripePaymentScreen extends StatefulWidget {
//   const StripePaymentScreen({super.key});
//   @override
//   State<StripePaymentScreen> createState() => _StripePaymentScreenState();
// }

// class _StripePaymentScreenState extends State<StripePaymentScreen> {
//   Map<String, dynamic>? paymentIntent;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Stripe Payment'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           child: const Text('Make Payment'),
//           onPressed: () async {
//             await makePayment();
//           },
//         ),
//       ),
//     );
//   }

//   Future<void> makePayment() async {
//     try {
//       // Create payment intent data
//       paymentIntent = await createPaymentIntent('1000', 'EUR');
//       // initialise the payment sheet setup
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           // Client secret key from payment data
//           billingDetails: BillingDetails(),
//           paymentIntentClientSecret: paymentIntent!['client_secret'],
//           googlePay: PaymentSheetGooglePay(
//               label: 'Buy Product',
//               testEnv: true,
//               currencyCode: "EUR",
//               merchantCountryCode: "PK"),
//           // Merchant Name
//           merchantDisplayName: 'ABC',
//         ),
//       );
//       // Display payment sheet
//       displayPaymentSheet();
//     } catch (e) {
//       print("exception $e");
//       if (e is StripeConfigException) {
//         print("Stripe exception ${e.message}");
//       } else {
//         print("exception $e");
//       }
//     }
//   }

//   displayPaymentSheet() async {
//     try {
//       // "Display payment sheet";
//       await Stripe.instance.presentPaymentSheet();
//       // Show when payment is done
//       // Displaying snackbar for it
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Paid successfully")),
//       );
//       paymentIntent = null;
//     } on StripeException catch (e) {
//       // If any error comes during payment
//       // so payment will be cancelled
//       print('Error: $e');

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text(" Payment Cancelled")),
//       );
//     } catch (e) {
//       print("Error in displaying");
//       print('$e');
//     }
//   }

//   createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': ((int.parse(amount)) * 100).toString(),
//         'currency': currency,
//         'payment_method_types[]': 'card',
//       };
//       var secretKey =
//           "sk_test_51PeE8cRw9PliPXqzl2MqcA47cYE39HPe8ZnIflwjcUVZbGLux5qyk6z7RmXGU023Q37ZNfoQOXxhbbsMvOu9zKC900IwCDa2sx";
//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer $secretKey',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       print('Payment Intent Body: ${response.body.toString()}');
//       return jsonDecode(response.body.toString());
//     } catch (err) {
//       print('Error charging user: ${err.toString()}');
//     }
//   }
// }
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  PageController _pageController = PageController();
  int currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _offsetAnimation;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _offsetAnimation =
        Tween<Offset>(begin: Offset(0, 0.1), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _pageController.addListener(() {
      _animationController.reset();
      _animationController.forward();
    });
    _animationController.forward();
  }
  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: [
          OnboardingPage(
            image: 'assets/images/handsome.png',
            title: 'Your style tell about you',
            description:
                'There are many shopping_store with designs that are suitable for you today',
            opacityAnimation: _opacityAnimation,
            offsetAnimation: _offsetAnimation,
          ),
          OnboardingPage(
            image: 'assets/images/man2.png',
            title: 'Level up your lifestyle',
            description:
                'Discover the perfect outfit that matches your style and personality',
            opacityAnimation: _opacityAnimation,
            offsetAnimation: _offsetAnimation,
          ),
        ],
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 1, 13, 31).withOpacity(0.7),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(27),
            topRight: Radius.circular(27),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(2, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentIndex == index
                            ? Colors.white
                            : const Color.fromARGB(255, 117, 117, 117),
                      ),
                    );
                  }),
                ),
                currentIndex == 1
                    ? ElevatedButton(
                        onPressed: () {
                          // Navigate to your next screen
                        },
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => register()));
                            },
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Get Started"),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Icon(Icons.arrow_forward),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      )
                    : TextButton(
                        onPressed: () {
                          _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Text("Continue"),
                                  SizedBox(width: 5),
                                  Icon(Icons.arrow_forward),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final Animation<double> opacityAnimation;
  final Animation<Offset> offsetAnimation;
  const OnboardingPage({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.opacityAnimation,
    required this.offsetAnimation,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: AnimatedBuilder(
        animation: opacityAnimation,
        builder: (context, child) {
          return Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.7),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.0, 0.4],
              ),
            ),
            child: SlideTransition(
              position: offsetAnimation,
              child: FadeTransition(
                opacity: opacityAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(
                        height:
                            100), // Increased to move the description text up
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
