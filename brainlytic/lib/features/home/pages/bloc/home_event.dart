part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeDataFetch extends HomeEvent{
  final String userId;
  HomeDataFetch(this.userId);
}

final class StarRefreshed extends HomeEvent{
  final String userId;
  StarRefreshed(this.userId);
}
