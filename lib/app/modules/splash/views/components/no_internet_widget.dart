import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(234, 227, 219, 1),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No Internet Connection',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(117, 117, 117, 1),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Center(
              child: Image.asset(
                'assets/images/No_Internet.png',
                height: 300,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              clipBehavior: Clip.antiAlias,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 20),
                // backgroundColor: Color.fromRGBO(117, 117, 117, 1),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Retry logic can be added here
              },
              child: const Text('Retry'),
            ),
          ],
        ));
  }
}
