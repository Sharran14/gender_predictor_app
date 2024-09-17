// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

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
      resizeToAvoidBottomInset: false, // Disable automatic resizing when the keyboard appears
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color.fromARGB(255, 67, 220, 255), const Color.fromARGB(255, 244, 83, 255)], // Adjust colors as needed
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // White layer
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width - 60, // Adjust width as needed
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
                  // Logo image at the top
                  Image.asset(
                    'assets/logo_gender.png', // Replace with the path to your logo image
                    height: 200, // Adjust the height as needed
                    width: 200,  // Adjust the width as needed
                  ), // Space between the logo and the text

                  // Text at the top of the white layer
                  Text(
                    "GenderName Genie",
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
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                      ),
                       style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final name = _nameController.text;
                      if (name.isNotEmpty) {
                        BlocProvider.of<GenderBloc>(context).add(FetchGender(name));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 117, 0, 159), // Text color
                      minimumSize: Size(100, 50), // Button size
                      padding: EdgeInsets.symmetric(vertical: 15), // Padding inside the button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Button corner radius
                      ),
                    ),
                    child: Text("Predict"),
                  ),
                  SizedBox(height: 30), // Space between the button and the result

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                // Display the entered name
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text(
                  "Name: ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text(
                  _nameController.text, // Display the name entered by the user
                  style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10), // Space between rows

            // Display the predicted gender
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Gender: ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.gender.toUpperCase(),
                  style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10), // Space between rows

            // Display the predicted probability
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Probability: ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${(state.probability * 100).toStringAsFixed(0)}%",
                style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
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
        ],
      ),
    );
  }
}
