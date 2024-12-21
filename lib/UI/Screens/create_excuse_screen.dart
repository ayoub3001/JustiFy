import '../../Domain/models/imports.dart';

class CreateExcuseScreen extends StatefulWidget {
  const CreateExcuseScreen({super.key});

  @override
  CreateExcuseScreenState createState() => CreateExcuseScreenState();
}

class CreateExcuseScreenState extends State<CreateExcuseScreen> {
  final TextEditingController _excuseController = TextEditingController();
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Añadir Excusa',
            style: TextStyle(
                color: Colors.blue.shade900, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue.shade900),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _excuseController,
              decoration: InputDecoration(
                hintText: 'Escribe tu excusa',
                filled: true,
                fillColor: Colors.blue.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Selecciona Categoría',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            const SizedBox(height: 10),
            _buildCategoryOption('Trabajo', Icons.work),
            _buildCategoryOption('Familia', Icons.family_restroom),
            _buildCategoryOption('Amigos', Icons.group),
            _buildCategoryOption('Colegio', Icons.school),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (_excuseController.text.isNotEmpty &&
                      _selectedCategory != null) {
                    final box = Hive.box('excusesBox');

                    // Crea un nuevo mapa para representar la excusa
                    final newExcuse = {
                      'excusa': _excuseController.text,
                      'categoria': _selectedCategory,
                    };

                    // Añade la excusa al box
                    await box.add(newExcuse);

                    // Limpia los campos
                    _excuseController.clear();
                    setState(() {
                      _selectedCategory = null;
                    });
                    final ctx = context;
                    if (!ctx.mounted) return;
                    // Navega hacia atrás
                    Navigator.pop(ctx);
                  } else {
                    // Manejo de error si los campos están vacíos
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                ),
                child: const Text(
                  'Guardar',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryOption(String category, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedCategory == category
                ? Colors.blue.shade700
                : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue.shade700),
            const SizedBox(width: 10),
            Text(
              category,
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
