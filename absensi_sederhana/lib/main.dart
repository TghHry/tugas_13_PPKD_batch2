import 'package:absensi_sederhana/laporan_kehadiran.dart';
import 'package:absensi_sederhana/list_kehadiran.dart';
import 'package:absensi_sederhana/register_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:absensi_sederhana/login_page.dart';
import 'package:absensi_sederhana/profil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final name = prefs.getString('name');
  final email = prefs.getString('email');
  final phone = prefs.getString('phone');

  runApp(
    MyApp(
      isLoggedIn: name != null && email != null && phone != null,
      name: name,
      email: email,
      phone: phone,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String? name;
  final String? email;
  final String? phone;

  const MyApp({
    super.key,
    required this.isLoggedIn,
    this.name,
    this.email,
    this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        LaporanKehadiranPage.id: (context) => LaporanKehadiranPage(),
        ListKehadiranPage.id: (context) => ListKehadiranPage(),
        RegisterPage.id: (context) => RegisterPage(),
      },
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      home:
          isLoggedIn
              ? ProfilPage(name: name!, email: email!, phone: phone!)
              : LoginPage(),
    );
  }
}
