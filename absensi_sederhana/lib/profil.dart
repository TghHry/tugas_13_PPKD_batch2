import 'package:absensi_sederhana/dashboard.dart';
import 'package:absensi_sederhana/database/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:absensi_sederhana/login_page.dart';

class ProfilPage extends StatelessWidget {
  final String name;
  final String email;
  final String phone;

  const ProfilPage({required this.name, required this.email, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profil')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 80),
            SizedBox(height: 10),
            Text('Nama:', style: TextStyle(fontSize: 16)),
            Text(name ?? '-', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('email:', style: TextStyle(fontSize: 16)),
            Text(email ?? '-', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
             Text('Nomor HP: ', style: TextStyle(fontSize: 16)),
            Text(phone ?? '-', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Email Login:', style: TextStyle(fontSize: 16)),
            Text(email ?? 'Tidak tersedia', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Logout'),
               onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
            ),
            ElevatedButton(
              child: Text('Info Page'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => InfoPage()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Laporan Page'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LaporanPage()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Dashboard'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => DashboardPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Info Aplikasi')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 80, color: Colors.blue),
            SizedBox(height: 10),
            Text('Versi Aplikasi:', style: TextStyle(fontSize: 16)),
            Text('1.0.0', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Text('Dikembangkan oleh : ', style: TextStyle(fontSize: 16)),
            Text('Teguh Hariyanto', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

class LaporanPage extends StatefulWidget {
  @override
  _LaporanPageState createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  Map<String, Map<String, int>> laporanPerOrang = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadLaporan();
  }

  Future<void> loadLaporan() async {
    final db = await DbHelper.initDB();
    final result = await db.rawQuery('''
      SELECT nama, keterangan, COUNT(*) as jumlah 
      FROM kehadiran 
      GROUP BY nama, keterangan
    ''');

    Map<String, Map<String, int>> laporanBaru = {};

    for (var row in result) {
      String nama = row['nama'] as String? ?? '';
      String ket = row['keterangan'] as String? ?? 'Tidak Diketahui';
      int jumlah = row['jumlah'] as int? ?? 0;

      laporanBaru[nama] = laporanBaru[nama] ?? {};
      laporanBaru[nama]![ket] = jumlah;
    }

    setState(() {
      laporanPerOrang = laporanBaru;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Laporan Kehadiran')),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: laporanPerOrang.length,
                itemBuilder: (context, index) {
                  String nama = laporanPerOrang.keys.elementAt(index);
                  Map<String, int> data = laporanPerOrang[nama]!;

                  return Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(
                        nama,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hadir: ${data['Hadir'] ?? 0} hari"),
                          Text("Alpha: ${data['Alpha'] ?? 0} hari"),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class ProfilPage extends StatelessWidget {
  final String name;
  final String email;
  final String phone;

  const ProfilPage({super.key, required this.name, required this.email, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nama: $name", style: TextStyle(fontSize: 18)),
            Text("Email: $email", style: TextStyle(fontSize: 18)),
            Text("Phone: $phone", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
