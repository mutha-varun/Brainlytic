import 'package:material_ui/material_ui.dart';

class Button extends StatelessWidget {
  final VoidCallback onTap;
  const Button({required this.onTap ,super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap, 
      child: const Text("Continue",)
    );
  }
}