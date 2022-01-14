import 'package:flutter/material.dart';
import 'package:movies_booking/pages/add_card_info_page.dart';
import 'package:movies_booking/pages/item_order_page.dart';
import 'package:movies_booking/pages/home_page.dart';
import 'package:movies_booking/pages/movie_choose_time_page.dart';
import 'package:movies_booking/pages/movie_detail_page.dart';
import 'package:movies_booking/pages/movie_seats_page.dart';
import 'package:movies_booking/pages/movie_ticket_page.dart';
import 'package:movies_booking/pages/payment_page.dart';
import 'package:movies_booking/pages/registration_page.dart';
import 'package:movies_booking/pages/welcome_page.dart';
import 'package:movies_booking/resources/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
            primary: WELCOME_SCREEN_BACKGROUND_COLOR, secondary: Colors.grey),
      ),
      home: WelcomePage(),
    );
  }
}
