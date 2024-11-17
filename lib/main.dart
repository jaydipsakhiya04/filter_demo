import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'filter_demo/view/ticket_listing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: TicktListingScreen(),
    );
  }
}
