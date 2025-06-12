import 'package:flutter/material.dart';
import 'package:absensi_sederhana/database/db_helper.dart';

class EditKehadiranPage extends StatefulWidget {
  static const String id = "/EditKehadiranPage";

  final Map<String, dynamic> data;

  EditKehadiranPage({required this.data});

  @override
  _EditKehadiranPageState createState() => _EditKehadiranPageState();
}

class _EditKehadiranPageState extends State<EditKehadiranPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController namaController;

  String selectedKeterangan = 'Hadir';

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.data['nama']);
    if (['Hadir', 'Izin', 'Alpha'].contains(widget.data['keterangan'])) {
      selectedKeterangan = widget.data['keterangan'];
    } else {
      selectedKeterangan = 'Hadir';
    }
  }

  @override
  void dispose() {
    namaController.dispose();
    super.dispose();
  }

  Future<void> _updateData() async {
    // memperbarui data berdasarkan id
    if (_formKey.currentState!.validate()) {
      final db = await DbHelper.initDB();
      await db.update(
        'kehadiran',
        {'nama': namaController.text, 'keterangan': selectedKeterangan},
        where: 'id = ?',
        whereArgs: [
          widget.data['id'],
        ], // kenapa pakai where? agar data dapat diubah pda baris tertentu
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
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator:
                    (val) => val!.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedKeterangan,
                items:
                    ['Hadir', 'Izin', 'Alpha'].map((status) {
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
                validator:
                    (val) =>
                        val == null || val.isEmpty
                            ? 'Keterangan wajib dipilih'
                            : null,
              ),
              SizedBox(height: 16),
              ElevatedButton(onPressed: _updateData, child: Text('Update')),
            ],
          ),
        ),
      ),
    );
  }
}
