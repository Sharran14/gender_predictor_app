import 'package:equatable/equatable.dart';

abstract class GenderEvent extends Equatable {
  const GenderEvent();

  @override
  List<Object> get props => [];
}

class FetchGender extends GenderEvent {
  final String name;

  FetchGender(this.name);

  @override
  List<Object> get props => [name];
}
