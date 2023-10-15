import 'package:dine_easy/payment/Bank_card.dart';
import 'package:dine_easy/payment/Wallet.dart';
import 'package:dine_easy/payment/payment.dart';
import 'package:dine_easy/restaurant/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './client/./client_signin/loginpg.dart';
import './restaurant/./profile/profile.dart';
import './restaurant/./signin/./loginpg.dart';
import 'package:dine_easy/client/Home/HomePage.dart';
void main() {
  runApp(const MyHomePage());
  // runApp(const MyApp());
}
String? token;
String? name;
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       // Use FutureBuilder to check if the user is authenticated or not
//       home: FutureBuilder<bool>(
//         future: checkAuthStatus(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             // Waiting for Future<bool> to complete
//             return const CircularProgressIndicator();
//           } else if (snapshot.hasError || snapshot.data == false) {
//             // Error or user not authenticated
//             return const MyHomePage(); // Redirect to Login
//           } else {
//             // User is authenticated
//           return Profile(name: name!, token: token!);
//           }
//         },
//       ),
//     );
//   }
//
// // Function to check if the user is authenticated
//   Future<bool> checkAuthStatus() async {
//     final prefs = await SharedPreferences.getInstance();
//     token = prefs.getString('auth_token');
//     print("token is:::${token}");
//     // Check if the token exists and is valid (you need to implement this logic)
//     return token != null;
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF020403),


            bottom: const TabBar(tabs: [
              Tab(text: "Restaurant"),
              Tab(text: "Customer"),
            ]),
            title: Text("Dine Easy"),
          ),
          body:  TabBarView(children: [
            Home_2(),
            menu(name: 'qazi', token: "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJodHRwczovL2lkZW50aXR5dG9vbGtpdC5nb29nbGVhcGlzLmNvbS9nb29nbGUuaWRlbnRpdHkuaWRlbnRpdHl0b29sa2l0LnYxLklkZW50aXR5VG9vbGtpdCIsImlhdCI6MTY5NzM3MDczMSwiZXhwIjoxNjk3Mzc0MzMxLCJpc3MiOiJmaXJlYmFzZS1hZG1pbnNkay1peXhjdkBmaXItYXV0aC04ZDgwMy5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsInN1YiI6ImZpcmViYXNlLWFkbWluc2RrLWl5eGN2QGZpci1hdXRoLThkODAzLmlhbS5nc2VydmljZWFjY291bnQuY29tIiwidWlkIjoidzNyV1FBcEZZWld3VW5za3BWSVFkSzFKS0poMSJ9.dMp3BpBINZuSLh7X4wiqClqT0H8WTqwKuWfelQY5n3f7gzBcV8sJkaH4-eqzwLv8vX5YDAehX2DgGgCnxoWWzzC6xxPWE0GGbZt0twFzF6pX1bKojTcLE_RPFscMdRLj5lqKPTE51qMQONAVLAH7EN4W9AmNi1eC_dUmEpmLHgEprbixCK07Gs4AKCMFqszcL87Rh3gXSv39oVa-UPHi8r8KfRs1jQcqUYk_wwGrXCfgjKw_sCS5Xue84vIjiHl_r1LVSMKk21Bcg4riHQ2hcJ-lDOL52SRu-35ZXqCWopBG40IsIsql5kEXYvUJSw6uak3Onu_cW6aZ3uSlFO7Ftg",),
            // Home_1(),
          //  RestaurantHomePage(name: 'khalid',),
          ]),
        ),
      ),
    );
  }
}
