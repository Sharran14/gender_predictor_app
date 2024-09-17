import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/gender_bloc.dart';
import 'ui/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => GenderBloc(),
        child: HomeScreen(),
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    );
  }
}
