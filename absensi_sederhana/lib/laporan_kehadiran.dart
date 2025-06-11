import 'package:flutter/material.dart';

import 'package:absensi_sederhana/database/db_helper.dart';

class LaporanKehadiranPage extends StatefulWidget {
  static const String id = "/LaporanKehadiranPage";
  @override
  _LaporanKehadiranPageState createState() => _LaporanKehadiranPageState();
}

class _LaporanKehadiranPageState extends State<LaporanKehadiranPage> {
  Map<String, int> laporan = {};

  Future<void> loadLaporan() async {
    //query SQLite untuk menghitung absensi setiap orang
    final db = await DbHelper.initDB();
    final result = await db.rawQuery('''
    SELECT nama, keterangan, COUNT(*) as jumlah 
    FROM kehadiran 
    GROUP BY nama, keterangan
    ''');

    setState(() {
      // Group laporan: { "Teguh": {"Hadir": 2, "Alpha": 1}, ... }
      Map<String, Map<String, int>> laporanBaru = {};

      for (var row in result) {
        String nama = row['nama'] as String? ?? '';
        String ket = row['keterangan'] as String? ?? 'Tidak Diketahui';
        int jumlah = row['jumlah'] as int? ?? 0;

        laporanBaru[nama] =
            laporanBaru[nama] ??
            {}; //membuat struktur Map agar data bisa diakses perorang dan per keterangan
        laporanBaru[nama]![ket] = jumlah;
      }

      laporanPerOrang = laporanBaru;
    });
  }

  Map<String, Map<String, int>> laporanPerOrang = {};

  @override
  void initState() {
    super.initState();
    loadLaporan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD1D8BE),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Laporan Kehadiran",
          style: TextStyle(color: Color(0xffEEEFE0)),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: loadLaporan, icon: Icon(Icons.refresh)),
        ],
      ),
      body: ListView.builder(
        itemCount: laporanPerOrang.length,
        itemBuilder: (context, index) {
          String nama = laporanPerOrang.keys.elementAt(index);
          var data = laporanPerOrang[nama]!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Color(0xffA7C1A8),
              child: ListTile(
                title: Text(nama),
                leading: Icon(Icons.person),
                trailing: Icon(Icons.arrow_forward_ios),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hadir: ${data['Hadir'] ?? 0}"),
                    Text("Izin: ${data['Izin'] ?? 0}"),
                    Text("Alpha: ${data['Alpha'] ?? 0}"),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
