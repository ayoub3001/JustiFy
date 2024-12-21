import '../../Domain/models/imports.dart';

AnimatedContainer categoryTag({required String category, required bool isSelected}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    decoration: BoxDecoration(
      color: isSelected ? Colors.blue : Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: isSelected ? Colors.blue : Colors.blueAccent,
        width: 1,
      ),
    ),
    child: Text(
      category,
      style: TextStyle(
        color: isSelected ? Colors.white : Colors.blue,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
