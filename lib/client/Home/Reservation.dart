import 'package:dine_easy/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

import '../../restaurant/menu/menu.dart';



class Reservation extends StatefulWidget {

  Reservation({required this.restaurantData,required this.name});
  String name;
  Map<String, dynamic> restaurantData;
  @override
  _ReservationState createState() => _ReservationState();

}

class _ReservationState extends State<Reservation> {


  // Sample data for items, prices, and quantities
  var items = ["Item A", "Item B", "Item C", "Item D", "Item E", "Item F"];
  var prices = [101, 102, 103, 104, 107, 108];
  var orderCounts = List<int>.filled(20, 0);
  var totalPay = 0;
  var total_Items=0;
  List<String> menuItems = [];
  List<int> menuPrices = [];
  @override
  void initState() {
    super.initState();
   // sendRestaurantName(widget.name);
    fetchMenu();
  }


  Future<void> fetchMenu() async {
print("sdf");
    try {
      final response = await http.get(
        Uri.parse('https://sparkling-sarong-bass.cyclic.app/customer/signin/home/menu'), // Replace with your API endpoint
      );

      if (response.statusCode == 200) {
        print("hello");
        final jsonResponse = json.decode(response.body);

        setState(() {
          menuItems = List<String>.from(jsonResponse['items']);
          menuPrices = List<int>.from(jsonResponse['prices']);
        });
        print(menuItems);

      } else {
        print('Failed to fetch menu.');
      }
    } catch (e) {
      print('Error fetching menu: $e');
    }
  }
// Calculate the total
  void calculateTotal() {
    totalPay = 0;
    total_Items=0;
    for (var index = 0; index < items.length; index++) {
      totalPay += orderCounts[index] * prices[index];
      total_Items=total_Items+orderCounts[index];
    }
  }

  @override
  Widget build(BuildContext context) {
    // Call the calculateTotal function to calculate the total
    calculateTotal();
    print(widget.restaurantData);

    return Scaffold(
      appBar: AppBar(title: Text('Reservation Screen')),
      body: SingleChildScrollView(
        scrollDirection:  Axis.vertical,
        child: Column(
          children: [
            //
            Container(
              width: 450,
              height: 250,
              child: Card(
                color: Colors.blue,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    TextField(decoration: InputDecoration(label: Text(widget.restaurantData['name'],style: TextStyle(color: Colors.white),),hintText:("Name") ,border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),),
                    SizedBox(height: 10,),
                    TextField(decoration: InputDecoration(label: Text(widget.restaurantData['email'],style: TextStyle(color: Colors.white),),hintText:("Name") ,border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),),
                    SizedBox(height: 10,),
                    TextField(decoration: InputDecoration(label: Text(widget.restaurantData['address'],style: TextStyle(color: Colors.white),),hintText:("Name") ,border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),),
                  ],
                ),
              ) ,
              ),
            ),
            //Services
            Container(
              width: 450,
              height: 220,
              child: Card(
                color: Colors.blue,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //textDirection: TextDirection.ltr,
                  children: [
                    Center(child: Text(widget.restaurantData['services'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 24),)),
                    Divider(thickness: 2, color: Colors.lightBlue),

                    Row(
                      children: [
                 //       Icon(
                    //      Icons.restaurant,
                      //    color: Colors.white,
                        //  size: 24.0,
                        //),
                        SizedBox(width: 10.0), // Add some spacing between icon and text

                      //  Text(" Quality Food and Beverage Preparation",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                      ],
                    ),
                    // SizedBox(height: 10,),
                    Row(
                      children: [
                        //Icon(Icons.restaurant,color: Colors.white,),
                        SizedBox(height: 10,),
                        //Text("    Excellent Customer Service",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                      ],
                    ),
                    // SizedBox(height: 10,),
                    Row(
                      children: [
                        //Icon(Icons.restaurant,color: Colors.white),
                        //Text("    Clean and Inviting Atmosphere",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                      ],
                    ),
                    Row(
                      children: [
                        //Icon(Icons.restaurant,color:Colors.white),
                      //  Text("    Efficient Restaurant Management",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                      ],
                    ),
                    Row(
                      children: [
                        //Icon(Icons.restaurant,color:Colors.white),
                        //Text("    Marketing and Promotion",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                      ],
                    ),
                  ],
                ),
              ) ,
              ),
            ),
            //Custome Services
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
                          TextField(maxLength: 2000,
                            keyboardType: TextInputType.multiline, // Allow multiple lines
                            maxLines: null, // Set maxLines to null for unlimited lines
                            style: TextStyle(fontSize: 20.0, height: 1.5), // Adjust the line height as needed
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

            //Menu display
            //Menu display
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
//Menu chart
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
                            textDirection: TextDirection.rtl,
                            children: [
                              SizedBox(height: 20),
                              Text(
                                "\t\t\t\t\t\t\t\t\t\t\t Quantity",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "\t\t\t\t\t\t\t\tPrices",
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
                              return ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${menuItems[index]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "RS:${menuPrices[index]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.remove_circle_outline,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              // Add your logic to handle quantity decrement
                                            });
                                          },
                                        ),
                                        Text(
                                          "0", // Add your logic to get the actual quantity
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.add_circle_outline,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              // Add your logic to handle quantity increment
                                            });
                                          },
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
            //Totel pay and Totel item
            Container(
              height: 100,
              child: Column(
                children: [
                  SizedBox(height: 10,),

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
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      "Total Items:  $total_Items",
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
            // Make Reservation
            ElevatedButton(
              onPressed: () {
                // Add your button's click action here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button background color
                elevation: 5, // Button elevation (shadow)
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Rounded corners
                ),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40), // Button padding
              ),
              child: Text(
                "Make Reservation",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Text color
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}