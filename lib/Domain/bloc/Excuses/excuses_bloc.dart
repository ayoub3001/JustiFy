import 'package:justify/Domain/models/Data/excuses.dart';

import '../../models/imports.dart';

class ExcusesBloc extends Cubit<ExcusesState> {
  ExcusesBloc() : super(const ExcusesInitial());
  final random = Random();

  void generateExcuse({required CategoriesEnum category}) async {
    try {
      emit(const ExcusesLoading());
      final String categoryString = category.toString().split('.').last;

      int numeroAleatorio = random.nextInt(excuses[categoryString]!.length);  
      String excuse = excuses[categoryString]![numeroAleatorio];

      await Future.delayed(const Duration(milliseconds: 3500)); // Espera 3500 milisegundos

      emit(ExcusesLoaded(excuse: excuse, category: categoryString));
    } catch (e) {
      emit(const ExcusesError());
    }
  }

  void resetExcuse() {
    emit(const ExcusesInitial());
  }
}
