import 'package:equatable/equatable.dart';
import 'package:etranzazct_test/features/home/data/cat_model.dart';

abstract class ApiImageStates extends Equatable {}

final class LoadingState extends ApiImageStates {
  @override
  List<Object?> get props => [];
}

final class ErrorState extends ApiImageStates {
  final String error;

  ErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

final class SuccessState extends ApiImageStates {
  final CatModel catModel;

  SuccessState(this.catModel);

  @override
  List<Object?> get props => [catModel];
}
