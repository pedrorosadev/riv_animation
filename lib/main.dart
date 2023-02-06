import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeAnimation(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeAnimation extends StatefulWidget {
  const HomeAnimation({super.key});

  @override
  State<HomeAnimation> createState() => _HomeAnimationState();
}

class _HomeAnimationState extends State<HomeAnimation> {
  Artboard? _artboard;
  RiveAnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _loadRiveFile();
  }

  void _loadRiveFile() async {
    final bytes = await rootBundle.load('assets/bonfire_animation.riv');
    final file = RiveFile.import(bytes);

    setState(() {
      _artboard = file.mainArtboard;
    });
  }

  void _aceso() {
    _artboard?.addController(_animationController = SimpleAnimation('aceso'));
    setState(() => _animationController?.isActive = true);
  }

  void _apagado() {
    _artboard?.addController(_animationController = SimpleAnimation('apagado'));
    setState(() => _animationController?.isActive = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _aceso,
        onDoubleTap: _apagado,
        child: Center(
          child: _artboard != null
              ? Rive(
                  artboard: _artboard!,
                  fit: BoxFit.cover,
                )
              : Container(
                  color: Colors.red,
                ),
        ),
      ),
    );
  }
}
