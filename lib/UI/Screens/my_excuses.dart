import '../../Domain/models/imports.dart';

class MyExcusesScreen extends StatefulWidget {
  const MyExcusesScreen({super.key});

  @override
  MyExcusesScreenState createState() => MyExcusesScreenState();
}

class MyExcusesScreenState extends State<MyExcusesScreen> {
  late Box _excusesBox;

  @override
  void initState() {
    super.initState();
    _excusesBox = Hive.box('excusesBox'); // Accede al box de Hive
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Excusas'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _excusesBox.isNotEmpty
                ? ListView.builder(
                    itemCount: _excusesBox.length,
                    itemBuilder: (context, index) {
                      final excuse = _excusesBox.getAt(index);
                      return ListTile(
                        title: Text(excuse['excusa']),
                        subtitle: Text('Categoría: ${excuse['categoria']}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _excusesBox.deleteAt(index); // Elimina la excusa
                            });
                          },
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      'No tienes excusas guardadas',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateExcuseScreen()),
                ).then((_) => setState(() {})); // Refresca la lista al volver
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              ),
              child: const Text(
                'Crear Nueva Excusa',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
