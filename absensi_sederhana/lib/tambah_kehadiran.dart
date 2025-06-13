import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // untuk DateFormat
import 'package:absensi_sederhana/database/db_helper.dart';
import 'package:absensi_sederhana/model/model.dart';

class TambahKehadiranPage extends StatefulWidget {
  @override
  _TambahKehadiranPageState createState() => _TambahKehadiranPageState();
}

class _TambahKehadiranPageState extends State<TambahKehadiranPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  String selectedKeterangan = 'Hadir';

  void _simpanKehadiran() async {
    if (_formKey.currentState!.validate()) {
      final db = await DbHelper.initDB();

      String nama = namaController.text;
      String tanggal = DateFormat('yyyy-MM-dd').format(DateTime.now());
      String keterangan = selectedKeterangan;

      // Menggunakan model Kehadiran
      Kehadiran kehadiran = Kehadiran(
        nama: nama,
        keterangan: keterangan,
        tanggal: tanggal,
      );

      await db.insert('kehadiran', kehadiran.toMap());

      print(
        'Data yang disimpan: nama=${kehadiran.nama}, tanggal=${kehadiran.tanggal}, keterangan=${kehadiran.keterangan}',
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEFE0),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Tambah Kehadiran', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.teal[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 9,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: namaController,
                    decoration: InputDecoration(labelText: 'Nama'),
                    validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedKeterangan,
                    items: ['Hadir', 'Izin', 'Alpha'].map((status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedKeterangan = val!;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Keterangan'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _simpanKehadiran,
                    child: Text('Simpan'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}