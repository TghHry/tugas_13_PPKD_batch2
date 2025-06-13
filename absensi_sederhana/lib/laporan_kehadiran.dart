import 'package:flutter/material.dart';
import 'package:absensi_sederhana/database/db_helper.dart';

class LaporanKehadiranPage extends StatefulWidget {
  static const String id = "/LaporanKehadiranPage";

  @override
  _LaporanKehadiranPageState createState() => _LaporanKehadiranPageState();
}

class _LaporanKehadiranPageState extends State<LaporanKehadiranPage> {
  Map<String, Map<String, int>> laporanPerOrang = {};

  Future<void> loadLaporan() async {
    final db = await DbHelper.initDB();
    final result = await db.rawQuery('''
    SELECT nama, 
           SUM(CASE WHEN keterangan = 'Hadir' THEN 1 ELSE 0 END) AS Hadir,
           SUM(CASE WHEN keterangan = 'Izin' THEN 1 ELSE 0 END) AS Izin,
           SUM(CASE WHEN keterangan = 'Alpha' THEN 1 ELSE 0 END) AS Alpha
    FROM kehadiran 
    GROUP BY nama
    ''');

    setState(() {
      Map<String, Map<String, int>> laporanBaru = {};

      for (var row in result) {
        String nama = row['nama'] as String? ?? '';
        int hadir = row['Hadir'] as int? ?? 0;
        int izin = row['Izin'] as int? ?? 0;
        int alpha = row['Alpha'] as int? ?? 0;

        laporanBaru[nama] = {
          'Hadir': hadir,
          'Izin': izin,
          'Alpha': alpha,
        };
      }

      laporanPerOrang = laporanBaru;
    });
  }

  @override
  void initState() {
    super.initState();
    loadLaporan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEFE0),
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.teal[300],
        title: Text("Laporan Kehadiran", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: laporanPerOrang.length,
        itemBuilder: (context, index) {
          String nama = laporanPerOrang.keys.elementAt(index);
          var data = laporanPerOrang[nama]!;
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person, color: Colors.teal, size: 40),
                  SizedBox(height: 8),
                  Text(
                    nama,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Hadir: ${data['Hadir'] ?? 0}"),
                        Text("Izin: ${data['Izin'] ?? 0}"),
                        Text("Alpha: ${data['Alpha'] ?? 0}"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}