// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/gender_bloc.dart';
import '../bloc/gender_event.dart';
import '../bloc/gender_state.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 15, 25), // Background color of the screen
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.all(30.0), // Margin to create space around the white layer
          decoration: BoxDecoration(
            color: Colors.white, // White background for the layer
            borderRadius: BorderRadius.circular(12.0), // Rounded corners for the white layer
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 4,
                blurRadius: 8,
                offset: Offset(0, 4), // Position of the shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
               Image.asset(
                'assets/logo_gender.png', // Replace with the path to your logo image
                height: 200, // Adjust the height as needed
                width: 200,  // Adjust the width as needed
              ),
              SizedBox(height: 20), 
              // Text at the top of the white layer
              Text(
                "Gender Predictor",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20), // Space between the title and the input field
              
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final name = _nameController.text;
                  if (name.isNotEmpty) {
                    BlocProvider.of<GenderBloc>(context).add(FetchGender(name));
                  }
                },
                child: Text("Predict"),
              ),
              SizedBox(height: 20), // Space between the button and the result
              BlocBuilder<GenderBloc, GenderState>(
  builder: (context, state) {
    if (state is GenderInitial) {
      return Column(
        children: [
          SizedBox(height: 30), // Space to move the text lower
          Text(
            "Enter a name to predict gender.",
            style: TextStyle(color: Colors.grey[700], fontSize: 16), // Update color
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else if (state is GenderLoading) {
      return CircularProgressIndicator();
    } else if (state is GenderLoaded) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Gender: ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                state.gender.toUpperCase(),
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 10), // Space between rows
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Probability: ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                "${(state.probability * 100).toStringAsFixed(2)}%",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
        ],
      );
    } else if (state is GenderError) {
      return Text(
        state.message,
        style: TextStyle(color: Colors.red),
      );
    } else {
      return Container();
    }
  },
)
,
            ],
          ),
        ),
      ),
    );
  }
}