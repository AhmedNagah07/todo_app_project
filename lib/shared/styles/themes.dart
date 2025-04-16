import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  // primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: Color.fromARGB(255, 252, 240, 148),
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    // backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 236, 219, 84),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Color.fromARGB(255, 236, 219, 84),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Pacifico',
      
    ),
    iconTheme: IconThemeData(
      color: Colors.black,


    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(  
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.grey[50],
    unselectedItemColor: Colors.grey[400],
    elevation: 20.0,
    backgroundColor: const Color.fromARGB(255, 236, 219, 84),
    
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xfffae53d),
    
  ),
  // useMaterial3: true,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Caveat',
      
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    labelStyle: TextStyle(color: Colors.grey),
    hintStyle: TextStyle(color: Colors.grey),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.black),

    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.black),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.black),
    ),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Pacifico',
    ),
    contentTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 18.0,
      fontFamily: 'Caveat',
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  colorScheme: ColorScheme.light(
    primary: Color(0xfffae53d),
    secondary: Color(0xfffae53d),
    error: const Color.fromARGB(255, 227, 60, 60)


  ),
 
    
  
  fontFamily: 'Caveat',

  
);

ThemeData darkTheme = ThemeData(
  // primarySwatch: Colors.red,
  scaffoldBackgroundColor: const Color.fromARGB(255, 66, 63, 63),
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    
    // backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.grey,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Color.fromARGB(255, 49, 46, 46),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Pacifico',
    ),
    iconTheme: 
    IconThemeData(
      // color: Colors.red,
    ),
    
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: false,
    fillColor: Colors.black,
    prefixIconColor: Colors.black,
    // suffixIconColor: Colors.black,
    labelStyle: TextStyle(color: Colors.black),
    hintStyle: TextStyle(color: Colors.black),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.white),

    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.white),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(  
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Color.fromARGB(255, 49, 46, 46),
    
  ),
  textTheme: TextTheme(
    bodyLarge: const TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Caveat',
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Color.fromARGB(255, 108, 101, 101),
    
    titleTextStyle: TextStyle(
      color: Colors.deepOrange,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Pacifico',
    ),
    contentTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontFamily: 'Caveat',
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.deepOrange,
    secondary: Colors.deepOrange,
    error: const Color.fromARGB(255, 227, 60, 60),
  ),

    fontFamily: 'Caveat',

  
  
);