import 'package:absensi_sederhana/model/model.dart';
import 'package:flutter/material.dart';
import 'package:absensi_sederhana/database/db_helper.dart';

class EditKehadiranPage extends StatefulWidget {
  static const String id = "/EditKehadiranPage";

  final Kehadiran kehadiran;
  EditKehadiranPage({required this.kehadiran});

  @override
  _EditKehadiranPageState createState() => _EditKehadiranPageState();
}

class _EditKehadiranPageState extends State<EditKehadiranPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController namaController;

  late String selectedKeterangan;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.kehadiran.nama);
    selectedKeterangan = widget.kehadiran.keterangan;
  }

  @override
  void dispose() {
    namaController.dispose();
    super.dispose();
  }

  Future<void> _updateData() async {
    if (_formKey.currentState!.validate()) {
      final db = await DbHelper.initDB();
      await db.update(
        'kehadiran',
        {
          'nama': namaController.text.trim(), // Menggunakan trim() untuk membersihkan input
          'keterangan': selectedKeterangan,
        },
        where: 'id = ?',
        whereArgs: [
          // widget.kehadiran.id, // Menggunakan id dari objek Kehadiran
        ],
      );
      if (context.mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEFE0),
      appBar: AppBar(
        title: Text('Edit Kehadiran', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.teal[300],
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 12),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
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
                    validator: (val) => val!.isEmpty ? 'Nama tidak boleh kosong' : null,
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedKeterangan,
                    items: ['Hadir', 'Izin', 'Alpha'].map((status) {
                      return DropdownMenuItem(
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
                    validator: (val) => val == null || val.isEmpty ? 'Keterangan wajib dipilih' : null,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(onPressed: _updateData, child: Text('Update')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
