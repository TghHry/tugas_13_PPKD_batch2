
import 'package:absensi_sederhana/laporan_kehadiran.dart';
import 'package:absensi_sederhana/register_page.dart';
import 'package:flutter/material.dart';
import 'package:absensi_sederhana/login_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        "/": (context) => LoginPage(),
        "/laporan": (context) => LaporanKehadiranPage(),
        "/registrasi": (context) => RegisterPage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'PPKD B 2',
      theme: ThemeData(
        // useMaterial3: true,
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder()},
        ),
      ),
    );
  }
}



