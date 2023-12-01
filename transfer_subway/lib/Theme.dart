import 'package:transfer_subway/imports.dart';

class MyThemes {


  static final light = ThemeData().copyWith(

    scaffoldBackgroundColor: AppColor.backgroundColor,


    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Colors.yellow,
      onPrimary: Colors.white,
      secondary: Colors.grey,
      onSecondary: Colors.grey, 
      error: Colors.white, 
      onError: Colors.white, 
      background: Colors.red, 
      onBackground: Colors.red, 
      surface: Colors.orange, 
      onSurface: Colors.orange,
      primaryContainer:  Colors.white,
      secondaryContainer: AppColor.blueColor),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,

    ),

  );

  static final dark = ThemeData.dark().copyWith(

    scaffoldBackgroundColor: Colors.black,

    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.grey,
      onPrimary: Color.fromARGB(255, 0, 0, 0),
      secondary: Colors.yellow,
      onSecondary: Colors.grey, 
      error: Colors.white, 
      onError: Colors.white, 
      background: Colors.blue, 
      onBackground: Colors.blue, 
      surface: Colors.teal, 
      onSurface: Colors.teal,
      primaryContainer:  Color.fromRGBO(46, 46, 46, 1),
      secondaryContainer: AppColor.navyColor
      ),
  
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.white,
    ),

  );

}