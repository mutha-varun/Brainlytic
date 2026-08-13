part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeDataFetch extends HomeEvent{}

final class StarRefreshed extends HomeEvent{}
