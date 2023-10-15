import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
    body:Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(height: 100,),

            Text("Please select a payment provider"),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: (){}, child:  Container(

                    child: Image.asset(
                      'Assets/images/3.png',
                      width: 130,
                      height: 130,
                    ),
                  ),),

                  SizedBox(
                    width: 20,
                  ),

                  ElevatedButton(onPressed: (){}, child:  Container(

                    child: Image.asset(
                      'Assets/images/jazzcash.png',
                      width: 130,
                      height: 130,
                    ),
                  ),),


                ],
              ),
            ),

            SizedBox(
              width: 20,
            ),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.attach_money),
                labelText: ("Enter amount"),
              ),
            ),

            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF808080), // Change 808080 to the correct color value
                fixedSize: Size(double.infinity, 60), // Adjust the height as per your requirements
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                    ),
                  ),
                  Icon(
                    Icons.verified,
                    color: Colors.green, // Color of the verification icon
                  ),
                  SizedBox(width: 8), // Add spacing between the icon and text
                  Text('Pay in'),
                ],
              ),
            ),

          ],
        ),
      ) ),
    );
  }
}
