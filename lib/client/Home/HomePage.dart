import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Home/Reservation.dart';

import 'Reservation.dart';

class RestaurantHomePage extends StatefulWidget {

  //consturtor for home screen which recived name parameter
   RestaurantHomePage({Key? key, required this.name});
String name;


  @override
  _RestaurantHomePageState createState() => _RestaurantHomePageState();
}

class _RestaurantHomePageState extends State<RestaurantHomePage> {
  bool isDataLoaded = false;
  var parsedData;
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> originalData = [];
  List<Map<String, dynamic>> restaurantsWithin10Km = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HOME',
          style: TextStyle(fontFamily: 'Pacifico'),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              calculateAndFilterRestaurantsWithin10Km();
            },
            child: Text("Calculate Distance"),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search for food...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: filterData,
            ),
          ),
          Expanded(
            child: isDataLoaded
                ? buildDataList(restaurantsWithin10Km.isNotEmpty
                ? restaurantsWithin10Km
                : data)
                : Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }

  Future<void> calculateAndFilterRestaurantsWithin10Km() async {
    try {
      // Get the customer's current location
      final Position customerLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      // Clear the previous list of restaurants within 10 km
      restaurantsWithin10Km.clear();

      for (var restaurant in data) {
        // Use geocoding to convert the restaurant's address into coordinates
        List<Location> locations =
        await locationFromAddress(restaurant['address']);
        if (locations.isNotEmpty) {
          double restaurantLatitude = locations[0].latitude;
          double restaurantLongitude = locations[0].longitude;

          // Calculate the distance between the customer's location and the restaurant
          double distance = Geolocator.distanceBetween(
            customerLocation.latitude,
            customerLocation.longitude,
            restaurantLatitude,
            restaurantLongitude,
          );

          // Print the distance (in meters)
          double distanceIntoKiloMeter = distance / 1000;

          if (distanceIntoKiloMeter <= 10) {
            // Add the restaurant to the list of restaurants within 10 km
            restaurantsWithin10Km.add(restaurant);
          }

          print('Distance to restaurant: $distanceIntoKiloMeter kilo meters');
        } else {
          print('Unable to determine restaurant coordinates from address.');
        }
      }

      // Update the UI with the filtered data
      setState(() {});
    } catch (e) {
      print('Error during geocoding or distance calculation: $e');
    }
  }

  Future<void> fetchData() async {
    try {
      print("sending request");
      final response = await http.get(
          Uri.parse('https://sparkling-sarong-bass.cyclic.app/customer/signin/home'));
      if (response.statusCode == 200) {
        parsedData = parseJsonResponse(response.body);
        setState(() {
          data = parsedData;
          originalData = parsedData;
          isDataLoaded = true;
        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error while fetching data: $e');
    }
  }

  void filterData(String query) {
    if (query.isEmpty) {
      setState(() {
        data = originalData;
      });
    } else {
      final filteredData = originalData.where((item) {
        final name = item['name'].toString().toLowerCase();
        final address = item['address'].toString().toLowerCase();
        return name.contains(query.toLowerCase()) ||
            address.contains(query.toLowerCase());
      }).toList();
      setState(() {
        data = filteredData;
      });
    }
  }

  List<Map<String, dynamic>> parseJsonResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed;
  }

  Widget buildDataList(List<Map<String, dynamic>> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        print(item);
        return GestureDetector(
          onTap:(){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Reservation( restaurantData: item, name: widget.name,),));
          },
          child: Card(
            color: Colors.teal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            elevation: 4.0,
            child: Container(
              width: 120,
              height: 120,
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              CircleAvatar(
                                radius: 45,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                AssetImage("Assets/images/13.png"),
                                child: Text(
                                  item['name'][0],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Name: ${item['name']}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Address: ${item['address']}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}