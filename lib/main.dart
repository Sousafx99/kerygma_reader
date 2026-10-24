import 'package:flutter/material.dart';
import 'screens/reader_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const KerygmaApp());
}

class KerygmaApp extends StatelessWidget {
  const KerygmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kerygma Focus Reader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const ReaderScreen(),
    );
  }
}
