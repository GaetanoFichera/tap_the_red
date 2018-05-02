import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tap_the_red/View/HomePage.dart';

void main() {
  //controllare se si può fare a meno di questa funzione
  //SharedPreferences.setMockInitialValues({});
  runApp(new HomePageSL());
}