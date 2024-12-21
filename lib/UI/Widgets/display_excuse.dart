import '../../Domain/models/imports.dart';

class DisplayExcuse extends StatelessWidget {
  const DisplayExcuse({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExcusesBloc, ExcusesState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          width: MediaQuery.of(context).size.width * .9,
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade300, Colors.blue.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: _buildContent(state, context),
        );
      },
    );
  }

  Widget _buildContent(ExcusesState state, context) {
    if (state is ExcusesLoaded) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Text(
              state.excuse ?? '',
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            IconButton(
                onPressed: () async {
                  final box = Hive.box('myFavoriteExcuses');

                  // Crea un nuevo mapa para representar la excusa
                  final newExcuse = {
                    'excusa': state.excuse,
                    'categoria': state.category,
                  };

                  // Añade la excusa al box
                  await box.add(newExcuse);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        context.read<ExcusesBloc>().resetExcuse();
                        return const SavedExcusesScreen();
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.favorite,
                    color: Colors.red, size: 40.0)),
          ],
        ),
      );
    } else if (state is ExcusesError) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.redAccent,
            size: 56.0,
          ),
          SizedBox(height: 12.0),
          Text(
            '¡Ups! Ocurrió un error\nIntenta de nuevo',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.comment_outlined,
            color: Colors.white70,
            size: 56.0,
          ),
          SizedBox(height: 12.0),
          Text(
            'Aquí se verá su excusa\ncuando la genere',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
  }
}
