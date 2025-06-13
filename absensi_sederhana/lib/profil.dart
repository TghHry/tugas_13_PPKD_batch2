import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:absensi_sederhana/login_page.dart';

class ProfilPage extends StatefulWidget {
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
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEFE0),
      appBar: AppBar(
        title: Text('Profil'),
        centerTitle: true,
        backgroundColor: Colors.teal[300],
        leading: Container(),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // Menampilkan dialog konfirmasi sebelum logout
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Konfirmasi Logout'),
                    content: const Text('Apakah Anda yakin ingin logout?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Batal'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Menutup dialog
                        },
                      ),
                      TextButton(
                        child: const Text('Logout'),
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs
                              .clear(); // Menghapus data pengguna dari SharedPreferences
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ), // Navigasi ke halaman login
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.person, size: 50, color: Colors.grey),
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Icon(Icons.person, color: Colors.grey),
                SizedBox(width: 8),
                Text("Full Name", style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 4),
            Text("       ${widget.name}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 4),

            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.email, color: Colors.grey),
                SizedBox(width: 8),
                Text('Email'),
              ],
            ),
            SizedBox(height: 4),
            Text("       ${widget.email}", style: TextStyle(fontSize: 18)),
            // Divider(),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.grey),
                SizedBox(width: 8),
                Text("Telepon", style: TextStyle(fontSize: 16)),
                SizedBox(height: 4),
              ],
            ),
            Text("        ${widget.phone}", style: TextStyle(fontSize: 18)),
            // Divider(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
