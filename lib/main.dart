import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:WeatherToday/weather_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.w500,
          ),
          displayMedium: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          titleLarge: GoogleFonts.oswald(
            fontSize: 30,
            // fontStyle: FontStyle.italic,
          ),
          titleMedium: GoogleFonts.merriweather(
            fontSize: 20,
            // fontStyle: FontStyle.italic,
          ),
          bodyMedium: GoogleFonts.merriweather(),
          displaySmall: GoogleFonts.pacifico(),
          bodySmall: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
          surface: const Color.fromARGB(255, 16, 77, 126),
        ),
      ),
      home: const WeatherScreen(),
      debugShowCheckedModeBanner: false,
      title: 'Weather Today',
    );
  }
}


// LEARN ABOUT LAYOUT THEORY, 
// TREES IN FLUTTER THAT ARE:WIDGET TREE,RENDER TREE, RENDER OBJECT TREE,
