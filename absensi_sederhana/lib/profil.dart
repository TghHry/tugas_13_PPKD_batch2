import 'package:flutter/material.dart';
import 'package:absensi_sederhana/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilPage extends StatefulWidget {
  static const String id = "/ProfilPage";

  final String name;
  final String email;
  final String phone;

  const ProfilPage({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
  }) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD1D8BE),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Profil Lengkap",
          style: TextStyle(color: Color(0xffEEEFE0)),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.clear();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const TugasTigasBelas()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.account_circle, size: 100),
                  const SizedBox(height: 16),
                  // Nama
                  Text(
                    "${widget.name}",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff819A91),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Email Box
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.email, color: Color(0xff819A91)),
                          SizedBox(width: 30),
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.right,
                              "${widget.email}",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff819A91),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Phone+
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Flexible(
                        child: Row(
                          children: [
                            Icon(Icons.phone, color: Color(0xff819A91)),
                            SizedBox(height: 10),
                            Expanded(
                              child: Text(
                                textAlign: TextAlign.right,
                                "${widget.phone}",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff819A91),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Deskripsi",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => AboutPage(),
            child: Text("About Page"),
          ),
        ],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: [
          Text(
            'Tentang Aplikasi',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Aplikasi ini dibuat sebagai tugas Flutter 7 & 8 yang menampilkan form input interaktif dengan Drawer, dan navigasi bawah menggunakan BottomNavigationBar.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Text('Developer: Ali Rosi', style: TextStyle(fontSize: 16)),
          Text(
            'Versi: 1.0.0',
            style: TextStyle(fontSize: 16, color: Colors.deepPurple),
          ),
        ],
      ),
    );
  }
}
