import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: GoogleFonts.poppins().fontFamily,
        cardColor: Colors.white,
        buttonColor: bluishColor,
        accentColor: darkCreamColor,
        canvasColor: creamColor,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: Colors.black),
          textTheme: Theme.of(context).textTheme.copyWith(
            headline6:
            context.textTheme.headline6!.copyWith(color: context.theme.accentColor),
          ),
        ),
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.poppins().fontFamily,
      cardColor: Colors.black,
      accentColor: Colors.white,
      canvasColor: darkCreamColor,
      buttonColor: lightBluishColor,
      appBarTheme: AppBarTheme(
        color: Colors.black,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        textTheme: Theme.of(context).textTheme.copyWith(
              headline6: context.textTheme.headline6?.copyWith(color: Colors.white),
            ),
      ));

  static Color creamColor = const Color(0Xfff5f5f5);
  static Color darkCreamColor = Vx.gray900;
  static Color bluishColor = const Color(0Xff403b58);
  static Color lightBluishColor = Vx.indigo500;
}
