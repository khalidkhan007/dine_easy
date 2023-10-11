import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../profile/profile.dart';
import '../menu/menu.dart';

class reservations extends StatefulWidget {
  const reservations({Key? key, required this.name, required this.token})
      : super(key: key);
  final dynamic token;
  final String name;

  @override
  State<reservations> createState() => _reservationsState();
}

class _reservationsState extends State<reservations> {
  int _selectedIndex = 2; // Default index for profile screen
  Future<Map<String, dynamic>>? _reservation;

  @override
  void initState() {
    super.initState();
    _reservation = fetchReservations();
  }

  Future<Map<String, dynamic>> fetchReservations() async {
    final Map<String, String> reqnewdata = {"name": widget.name};
    try {
      print("sending request.......");
      final response = await http.post(
        Uri.parse("http://192.168.114.91:8080/signin/restaurant/reservations"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(reqnewdata),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("data is:::$data");
        return Future.value(data);
      } else {
        print("Error: ${response.statusCode}");
        print("error is:::${response.body}");
        throw Exception("Failed to fetch reservations");
      }
    } catch (error) {
      print("error is :::$error");
      throw Exception("Failed to fetch reservations");
    }
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print("index is::${index}");
    if (index == 0) {
      // Navigate to Menu screen
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Profile(name: widget.name, token: widget.token)),
      );
    } else if (index == 1) {
      // Navigate to Reservations screen
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => menu(name: widget.name, token: widget.token)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            // Start color (#F5F5DC)
            Color(0xFF2b1b17),
            Color(0xFF0c0908),
          ],
          begin: Alignment.bottomRight,
          end: Alignment.topCenter,
          stops: [0.1, 0.5],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: const Color(0xFF020403),
          title: const Text("Reservations"),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: _reservation,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Container(
                  child: const Text(
                    "Error...",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              // Extract the 'reservations' map
              final reservations = snapshot.data!['reservations'];
              print("reservation length is:::$reservations.length");

              final reservationList = reservations.entries.toList();

              return ListView.builder(
                itemCount: reservations.length,
                itemBuilder: (context, index) {
                  final entry = reservationList[index];
                  final reservation = entry.value;
                  print("entry=$entry");
                  print("reservations after entry=$reservation");
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(7, 5, 7, 2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: height * 0.19,
                        color: Colors.teal.shade700,
                        child: Card(
                          color: Colors.teal.shade700,
                          shadowColor: Colors.grey,
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 100.0, left: 0.0),
                                      child: Text(
                                        "Reservation=${index + 1}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "Status: ${reservation['status']}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "customer=${reservation['customername']}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "payment status=${reservation['paymentstatus']}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "reservation details=${reservation['reservation_details']}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "Menu=${reservation['menu']}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 10,
                                          ),
                                          onPressed: () {},
                                          child: const Text(
                                            "Marks as done",
                                            style: TextStyle(color: Colors.white),
                                          )),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 10,
                                            backgroundColor: Colors.green
                                          ),
                                          onPressed: () {},
                                          child: const Text(
                                            "Payment done",
                                            style: TextStyle(color: Colors.white),
                                          )),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 10,
                                            backgroundColor: Colors.red,
                                            padding: const EdgeInsets.only(left: 3),
                                          ),
                                          onPressed: () {},
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(color: Colors.white),
                                          ))
                                    ],
                                  ),
                                ),
                                // Add more widgets to display other reservation details here
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text("No reservations available."));
            }
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 8,
          backgroundColor: const Color(0xFF2b1b17),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded),
              label: 'menu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Reservations',
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}