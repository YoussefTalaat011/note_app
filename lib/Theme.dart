import 'package:flutter/material.dart';

class NoteTheme {
  static ThemeData get NoteAppTheme {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          fontFamily: 'Open Sans',
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
          size: 25,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide(
            color: Colors.deepPurple,
            width: 2,
          )
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.blue,
        elevation: 4,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          elevation: 4,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          )
        )
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.grey,
          textStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          )
        )
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        titleTextStyle: TextStyle(fontSize: 15),
        contentTextStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
        size:20,
      ),
    );
  }
  
}