import 'package:brainlytic/brainlytic.dart';
import 'package:brainlytic/features/onboarding/provider/init.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:brainlytic/core/theme/pallete.dart';
import 'package:material_ui/material_ui.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});
  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends ConsumerState<SplashScreen> {

  final _logo = const AssetImage("assets/Logo.png");

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final init = ref.watch(initProvider);
    return init.when(
      data: (_) => const Brainlytic(),
      error: (_,_) {
        throw UnimplementedError();
      },
      loading: () => Directionality(
        textDirection: TextDirection.ltr,
        child: ColoredBox(
          color: Pallete.blackColor,
          child: Center(
            child: Image(image: _logo,
              width: 280,
              height: 280,
            ),
          ),
        ),
      ),
    );
  }
}