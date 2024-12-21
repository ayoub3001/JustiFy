
import 'Domain/models/imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('excusesBox');
  await Hive.openBox('myFavoriteExcuses');
  runApp(const MyBlocProvider());
}

class MyBlocProvider extends StatelessWidget {
  const MyBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => ExcusesBloc()),
    ], child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'JustiFy',
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
