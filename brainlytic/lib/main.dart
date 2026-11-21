import 'package:brainlytic/features/onboarding/pages/splash_screen.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: const SplashScreen()
    )
  );
}
