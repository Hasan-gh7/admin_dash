abstract class StatsState {}

class StatsInitial extends StatsState {}

class StatsLoading extends StatsState {}

class StatsLoaded extends StatsState {
  final int propertiesCount;
  final int usersCount;

  StatsLoaded({required this.propertiesCount, required this.usersCount});
}

class StatsError extends StatsState {
  final String message;

  StatsError(this.message);
}