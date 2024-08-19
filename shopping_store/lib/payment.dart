// ignore_for_file: camel_case_types, avoid_print
import 'package:shopping_store/success.dart';
import 'package:flutter/material.dart';
// import 'package:stripe_payment/stripe_payment.dart';

class payment extends StatefulWidget {
  const payment({super.key});
  @override
  State<payment> createState() => _paymentState();
}
class _paymentState extends State<payment> {
  String _selectedPaymentMethod = '';
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // StripePayment.setOptions(
    //   StripeOptions(
    //     publishableKey:
    //         "pk_test_51PeE8cRw9PliPXqz6Kyqh6nQYT1ylH9TWKxZdOCXsd9zv0PwFGQOmB7moDxAPnwiSZB0BsVdFDRp92zxUToHEHWZ00dQW0qq1K",
    //     merchantId: "Test",
    //     androidPayMode: 'test',
    //   ),
    // );
  }

  void _selectPaymentMethod(String method) {
    setState(() {
      _selectedPaymentMethod = method;
    });
    print('Selected payment method: $method');
  }

  void _confirmPayment() async {
    final String cardHolderName = _cardHolderNameController.text;
    final String cardNumber = _cardNumberController.text;
    final String expiryDate = _expiryDateController.text;

    if (_selectedPaymentMethod == 'Credit card') {
      //   List<String> expiryParts = expiryDate.split('/');
      //   CreditCard card = CreditCard(
      //     name: cardHolderName,
      //     number: cardNumber,
      //     expMonth: int.parse(expiryParts[0]),
      //     expYear: int.parse(expiryParts[1]),
      //   );

      //   StripePayment.createTokenWithCard(card).then((token) {
      //     String? tokenId = token.tokenId;
      //     if (tokenId != null) {
      //       _processPayment(tokenId);
      //     } else {
      //       // Handle the case where tokenId is null
      //       print("Failed to create token");
      //       // Show error message to the user
      //       _showErrorMessage("Failed to process payment. Please try again.");
      //     }
      //   }).catchError((error) {
      //     print("Error creating token: $error");
      //     // Handle error
      //     _showErrorMessage("Error processing payment: $error");
      //   });
    }
  }

  void _showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _processPayment(String tokenId) {
    // Process payment using your backend
    print('Processing payment with token: $tokenId');

    // After payment is processed successfully
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => success()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/master.png",
                      height: 100,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Select Payment Method',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildPaymentMethodRow(
                      'Credit card', 'assets/images/visa.png'),
                  SizedBox(height: 10),
                  _buildPaymentMethodRow(
                      'Cash on delivery', 'assets/images/cash.png'),
                  SizedBox(height: 30),
                  Text(
                    'Card Holder Name',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _cardHolderNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter card holder name',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Card Number',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _cardNumberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter card number',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Expiry Date',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _expiryDateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'MM/YY',
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: _confirmPayment,
                      child: Text(
                        'Confirm',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 29, 29, 30),
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodRow(String method, String assetPath) {
    return GestureDetector(
      onTap: () {
        _selectPaymentMethod(method);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: _selectedPaymentMethod == method
              ? Colors.blue.withOpacity(0.1)
              : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Image.asset(assetPath),
            ),
            SizedBox(width: 10),
            Text(
              method,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            if (_selectedPaymentMethod == method)
              Icon(
                Icons.check_circle,
                color: Colors.blue,
              ),
          ],
        ),
      ),
    );
  }
}
