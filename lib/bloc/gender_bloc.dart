import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'gender_event.dart';
import 'gender_state.dart';

class GenderBloc extends Bloc<GenderEvent, GenderState> {
  GenderBloc() : super(GenderInitial()) {
    on<FetchGender>(_onFetchGender); // Registering the handler for FetchGender event
  }

Future<void> _onFetchGender(FetchGender event, Emitter<GenderState> emit) async {
  emit(GenderLoading()); // Emit loading state

  try {
    var url = "https://api.genderize.io/?name=${event.name}";
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      
      // Handle possible null values and invalid types
      final gender = body['gender'] as String? ?? 'Unknown'; // Default to 'Unknown' if null
      final probability = body['probability'] is String
          ? double.tryParse(body['probability']) ?? 0.0
          : (body['probability'] as num?)?.toDouble() ?? 0.0;

      emit(GenderLoaded(
        gender: gender,
        probability: probability,
      )); // Emit loaded state
    } else {
      emit(GenderError("Failed to fetch gender prediction."));
    }
  } catch (e) {
    emit(GenderError("An error occurred: $e"));
  }
}
}