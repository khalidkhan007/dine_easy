import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Bank_card.dart';
import 'Wallet.dart';

class paymentpage extends StatefulWidget {
  const paymentpage({super.key});

  @override
  State<paymentpage> createState() => _paymentpageState();
}

class _paymentpageState extends State<paymentpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
    Center(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 120,
              ),
              Text("Select a payment method"),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Bank_card()),
                        );
                      }, child: Text("Bank cards"))),
              SizedBox(
                height: 15,
              ),
              Container(
                  width: double.infinity,
                  height: 50,
                  child:
                      ElevatedButton(onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Wallet()),
                        );
                      }, child: Text("Wallet"))),
              SizedBox(
                height: 15,
              ),
              Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(onPressed: () {}, child: Text("FAQ"))),
              SizedBox(
                height: 15,
              ),
              Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(onPressed: () {}, child: Text("Back"))),
            ],
          ),
        ),
      ),
    )
    );
  }
}
