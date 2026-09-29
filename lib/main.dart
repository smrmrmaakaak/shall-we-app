import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/home_ticket_screen.dart';

void main() {
  runApp(const ShallWeApp());
}

class ShallWeApp extends StatefulWidget {
  const ShallWeApp({super.key});

  @override
  State<ShallWeApp> createState() => _ShallWeAppState();
}

class _ShallWeAppState extends State<ShallWeApp> {
  Locale _currentLocale = const Locale('ko');

  void _setLocale(Locale locale) {
    setState(() {
      _currentLocale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shall We?',
      debugShowCheckedModeBanner: false,
      locale: _currentLocale,
      supportedLocales: const [
        Locale('ko', ''),
        Locale('en', ''),
        Locale('ja', ''),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        fontFamily: 'NotoSansKR',
        scaffoldBackgroundColor: const Color(0xFFF4EFE9),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE11D48),
          primary: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: HomeTicketScreen(
        currentLocale: _currentLocale,
        onLocaleChange: _setLocale,
      ),
    );
  }
}
