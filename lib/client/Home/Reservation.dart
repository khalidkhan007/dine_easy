import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:intl_extension/intl_extension.dart';

//import 'package:intl/intl.dart';

class Reservation extends StatefulWidget {
  Reservation({required this.restaurantData, required this.name});

  String name;
  Map<String, dynamic> restaurantData;

  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  var totalPay = 0;
  var totalItems = 0;
  Map<String, int> menuItems = {};
  Map<String, int> quantitySelected = {};

  @override
  void initState() {
    super.initState();
    fetchMenu(widget.name);
  }





//make a Reservation
  Future<void> makeReservation() async {
    final DateTime date1 = DateTime.now();

  //  String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(date1);
   // print(formattedDate);
   // final DateTime date1 = DateTime.now();
    print('khan1231$date1');
    // Construct the reservation data
    Map<String, dynamic> reservationData = {
      "restaurant": widget.restaurantData['name'],
      "name": "qazi 1",
      "reservations": {
        "reservationId2": {
          "status": "Active",
          "paymentstatus": "Pending",
          "restaurant": widget.restaurantData['name'],
          "customername": widget.name,
          "reservation_details": "reserve at 10pm",
          "menu": quantitySelected,
        },
      },
    };
    try {
      final response = await http.put(
        Uri.parse(
            'https://sparkling-sarong-bass.cyclic.app/customer/signin/home/restaurant_details/reservation'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(reservationData),
      );
      if (response.statusCode == 200) {
        // Reservation was successfully updated
        print("Reservation updated successfully!");
      } else {
        // Handle errors or display an error message
        print('Failed to update reservation. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
    //  print('Response body: ${response.body}');
      // Handle connection or request errors
      print('Error updating reservation: $e');
    }
  }

//make a FetchMenu
  Future<void> fetchMenu(String name) async {
    print("Sending request for restaurant details...");

    try {
      final response = await http.post(
        Uri.parse(
            'https://sparkling-sarong-bass.cyclic.app/customer/signin/home/restaurant_details'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'name': widget.restaurantData['name']}),
      );
      print(response.body);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        print("Restaurant details received:");
        print(jsonResponse);

        setState(() {
          menuItems = Map<String, int>.from(jsonResponse['menu']);
        });
        print(menuItems);
      } else {
        print(
            'Failed to fetch restaurant details. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error sending restaurant name: $e');
    }
  }

  void calculateTotal() {
    totalPay = 0;
    totalItems = 0;
    quantitySelected.forEach((itemName, quantity) {
      int itemPrice = menuItems[itemName] ?? 0;
      totalPay += itemPrice * quantity;
      totalItems += quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    calculateTotal();

    return Scaffold(
      appBar: AppBar(title: Text('Reservation Screen')),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: 450,
              height: 250,
              child: Card(
                color: Colors.blue,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          label: Text(
                            widget.restaurantData['name'],
                            style: TextStyle(color: Colors.white),
                          ),
                          hintText: ("Name"),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          label: Text(
                            widget.restaurantData['email'],
                            style: TextStyle(color: Colors.white),
                          ),
                          hintText: ("Name"),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          label: Text(
                            widget.restaurantData['address'],
                            style: TextStyle(color: Colors.white),
                          ),
                          hintText: ("Name"),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 450,
              height: 220,
              child: Card(
                color: Colors.blue,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          widget.restaurantData['services'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Divider(thickness: 2, color: Colors.lightBlue),
                    ],
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                width: 450,
                height: 170,
                child: Card(
                  color: Colors.blue,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "Customer Services",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            maxLength: 2000,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: TextStyle(fontSize: 20.0, height: 1.5),
                            decoration: InputDecoration(
                              labelText: "Customer Special Services",
                              labelStyle: TextStyle(color: Colors.white),
                              hintText: "Customer Special Services",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 5, right: 5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                ),
                width: 100,
                height: 40,
                child: Center(
                  child: Text(
                    "Menu",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Container(
                width: 450,
                height: 350,
                child: Card(
                  color: Colors.blue,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            textDirection: TextDirection.ltr, // or TextDirecti
                            children: const [
                              SizedBox(height: 20),
                              Text(
                                "\t\t\t\t\t\t\t\t\t\t\t Quantity",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "\t\t\t\t\t\t\t\t\tPrices",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "   Items",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Divider(thickness: 2, color: Colors.lightBlue),
                        Container(
                          height: 400,
                          child: ListView.builder(
                            itemCount: menuItems.length,
                            itemBuilder: (context, index) {
                              String itemName = menuItems.keys.elementAt(index);
                              int itemPrice = menuItems[itemName]!;
                              int selectedQuantity =
                                  quantitySelected[itemName] ?? 0;

                              return ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      itemName,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "$itemPrice",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (selectedQuantity > 0) {
                                                quantitySelected[itemName] =
                                                    selectedQuantity - 1;
                                              }
                                            });
                                          },
                                          child: const Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "$selectedQuantity",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              quantitySelected[itemName] =
                                                  selectedQuantity + 1;
                                            });
                                          },
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 100,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Total Pay: RS $totalPay",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Total Items:  $totalItems",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                makeReservation();               // Add your button's click action here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
              ),
              child: Text(
                "Make Reservation",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
