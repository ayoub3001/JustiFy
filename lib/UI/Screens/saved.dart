import '../../Domain/models/imports.dart';

class SavedExcusesScreen extends StatefulWidget {
  const SavedExcusesScreen({super.key});

  @override
  SavedExcusesScreenState createState() => SavedExcusesScreenState();
}

class SavedExcusesScreenState extends State<SavedExcusesScreen> {
  late Box _favoriteExcusesBox;

  @override
  void initState() {
    super.initState();
    _favoriteExcusesBox = Hive.box('myFavoriteExcuses');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Excusas Favoritas'),
      ),
      body: ValueListenableBuilder(
        valueListenable:
            _favoriteExcusesBox.listenable(), // Escucha los cambios
        builder: (context, box, _) {
          if (_favoriteExcusesBox.isNotEmpty) {
            return ListView.builder(
              itemCount: _favoriteExcusesBox.length,
              itemBuilder: (context, index) {
                final excuse = _favoriteExcusesBox.getAt(index);
                return ListTile(
                  title: Text(excuse['excusa']),
                  subtitle: Text('Categoría: ${excuse['categoria']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _favoriteExcusesBox.deleteAt(index); // Elimina la excusa
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                'No tienes excusas favoritas guardadas',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
        },
      ),
    );
  }
}
