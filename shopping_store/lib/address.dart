import 'package:flutter/material.dart';

class address extends StatefulWidget {
  const address({super.key});

  @override
  State<address> createState() => _addressState();
}

class _addressState extends State<address> {
  bool isOfficeSelected = false;
  bool isHomeSelected = false;
  bool isDefaultAddress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 238, 235, 235),
        title: const Text('Add Adress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pickup point recommendation will be available after you save the home delivery address.',
              style: TextStyle(color: Colors.blue),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Mobile Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Area',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Landmark (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Address Label (Optional)'),
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: isOfficeSelected ? Colors.black : Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor:
                          isOfficeSelected ? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        isOfficeSelected = !isOfficeSelected;
                        if (isOfficeSelected) isHomeSelected = false;
                      });
                    },
                    child: const Text('Office'),
                  ),
                ),
                const SizedBox(width: 8),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: isHomeSelected ? Colors.black : Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor:
                          isHomeSelected ? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        isHomeSelected = !isHomeSelected;
                        if (isHomeSelected) isOfficeSelected = false;
                      });
                    },
                    child: const Text('Home'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Default Delivery Address'),
                Switch(
                  value: isDefaultAddress,
                  onChanged: (value) {
                    setState(() {
                      isDefaultAddress = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  // Save action
                },
                child: const Text('Save'),
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
    home: address(),
  ));
}
