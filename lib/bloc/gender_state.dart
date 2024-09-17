import 'package:equatable/equatable.dart';

abstract class GenderState extends Equatable {
  const GenderState();

  @override
  List<Object?> get props => [];
}

class GenderInitial extends GenderState {}

class GenderLoading extends GenderState {}

class GenderLoaded extends GenderState {
  final String gender;
  final double probability;

  GenderLoaded({required this.gender, required this.probability});

  @override
  List<Object?> get props => [gender, probability];
}

class GenderError extends GenderState {
  final String message;

  GenderError(this.message);

  @override
  List<Object?> get props => [message];
}
