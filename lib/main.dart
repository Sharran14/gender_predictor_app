import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Import HomeScreen
import 'splash_screen.dart'; // Import SplashScreen
import 'bloc/gender_bloc.dart'; // Import GenderBloc

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenderBloc(),
      child: MaterialApp(
        home: SplashScreen(), // Set SplashScreen as the initial screen
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
      ),
    );
  }
}
