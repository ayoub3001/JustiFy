import '../../Domain/models/imports.dart';

class ButtonGenerate extends StatefulWidget {
  final String? category;
  const ButtonGenerate({super.key, required this.category});

  @override
  ButtonGenerateState createState() => ButtonGenerateState();
}

class ButtonGenerateState extends State<ButtonGenerate> {
  bool _isGenerating = false;
  bool _isCompleted = false;
  double _progress = 0.0;

  void _startGenerating() {
    if (widget.category == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecciona una categoría'),
        ),
      );
      return;
    }

    context.read<ExcusesBloc>().generateExcuse(
        category: CategoriesEnum.values.firstWhere((e) =>
            e.toString().split('.').last == widget.category!.toLowerCase()));
    setState(() {
      _isGenerating = true;
      _isCompleted = false;
      _progress = 0.0;
    });

    Timer.periodic(const Duration(milliseconds: 35), (timer) {
      setState(() {
        _progress += 0.01;
        if (_progress >= 1.0) {
          _isGenerating = false;
          _isCompleted = true;
          timer.cancel();
          Timer(const Duration(seconds: 2), () {
            setState(() {
              _isCompleted = false;
            });
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _isGenerating ? null : _startGenerating,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            color: _isCompleted ? Colors.green.shade300 : Colors.white,
            border: Border.all(
              color: Colors.blue,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (_isGenerating)
                LiquidLinearProgressIndicator(
                  value: _progress,
                  backgroundColor: Colors.transparent,
                  valueColor: const AlwaysStoppedAnimation(Colors.blue),
                  borderRadius: 12.0,
                ),
              Center(
                child: Text(
                  _isGenerating
                      ? '${(_progress * 100).toStringAsFixed(0)}%'
                      : _isCompleted
                          ? 'Completado'
                          : 'Generar Excusa',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
