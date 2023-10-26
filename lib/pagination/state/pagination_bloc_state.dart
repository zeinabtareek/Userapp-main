import 'package:equatable/equatable.dart';

sealed class PaginationBlocState extends Equatable {
  const PaginationBlocState();

  @override
  List<Object> get props => [];
}

final class PaginationBlocInitial extends PaginationBlocState {}

class PaginationLoading extends PaginationBlocState {}

class PaginationLoaded<T> extends PaginationBlocState {
  final List<T> items;

  const PaginationLoaded(this.items);

  @override
  List<Object> get props => [items];
}

class PaginationError extends PaginationBlocState {
  final String error;

  const PaginationError(this.error);

  @override
  List<Object> get props => [error];
}

class PaginationNoMoreData<T> extends PaginationBlocState {
  final List<T> items;
  const PaginationNoMoreData(this.items);
  @override
  List<Object> get props => [items];
}

class PaginationNoDataFoundState extends PaginationBlocState {}

class PaginationEmptyPageState extends PaginationBlocState {}
