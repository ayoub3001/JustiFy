import '../../models/imports.dart';

class ExcusesState extends Equatable {
  final bool hasExcuse;
  final String? excuse;
  final String? category;

  const ExcusesState({
    required this.hasExcuse,
    this.excuse,
    this.category,
  });

  @override
  List<Object?> get props => [hasExcuse, excuse, category];
}

class ExcusesInitial extends ExcusesState {
  const ExcusesInitial() : super(hasExcuse: false);
}

class ExcusesLoading extends ExcusesState {
  const ExcusesLoading() : super(hasExcuse: false);
}

class ExcusesLoaded extends ExcusesState {
  const ExcusesLoaded({required String excuse, required String category})
      : super(hasExcuse: true, excuse: excuse, category: category);
}

class ExcusesError extends ExcusesState {
  const ExcusesError() : super(hasExcuse: false);
}
