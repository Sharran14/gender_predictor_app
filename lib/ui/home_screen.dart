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
      backgroundColor: Colors.blueGrey[50], // Set the background color of the screen
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.all(20.0), // Adjust margin to create space around the white layer
          decoration: BoxDecoration(
            color: Colors.white, // White background for the layer
            borderRadius: BorderRadius.circular(12.0), // Rounded corners for the white layer
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 4,
                blurRadius: 8,
                offset: Offset(0, 4), // Change the position of the shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "Enter a name to predict its gender.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
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
              SizedBox(height: 20),
              BlocBuilder<GenderBloc, GenderState>(
                builder: (context, state) {
                  if (state is GenderInitial) {
                    return Text("Enter a name to predict gender.");
                  } else if (state is GenderLoading) {
                    return CircularProgressIndicator();
                  } else if (state is GenderLoaded) {
                    return Text(
                      "Gender: ${state.gender.toUpperCase()}, Probability: ${(state.probability * 100).toStringAsFixed(2)}%",
                      style: TextStyle(fontSize: 16),
                    );
                  } else if (state is GenderError) {
                    return Text(state.message, style: TextStyle(color: Colors.red));
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
