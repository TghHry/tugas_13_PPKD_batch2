import 'package:flutter/material.dart';
import 'package:absensi_sederhana/database/db_helper.dart';

class EditKehadiranPage extends StatefulWidget {
  final Map<String, dynamic> data; // menerima data dari halaman sebelumnya (list)

  EditKehadiranPage({required this.data});

  @override
  _EditKehadiranPageState createState() => _EditKehadiranPageState();
}

class _EditKehadiranPageState extends State<EditKehadiranPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController namaController;
  // Hapus keteranganController karena akan diganti dengan selectedKeterangan
  // late TextEditingController keteranganController;

  String selectedKeterangan = 'Hadir'; // Default value

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.data['nama']);

    // Set nilai awal dropdown berdasarkan data yang diterima
    // Pastikan 'keterangan' ada di dalam data dan sesuai dengan opsi dropdown
    if (['Hadir', 'Izin', 'Alpha'].contains(widget.data['keterangan'])) {
      selectedKeterangan = widget.data['keterangan'];
    } else {
      selectedKeterangan = 'Hadir'; // Fallback jika data tidak valid
    }
  }

  // Penting: Pastikan untuk membuang controller saat widget tidak lagi digunakan
  @override
  void dispose() {
    namaController.dispose();
    super.dispose();
  }

  Future<void> _updateData() async {
    if (_formKey.currentState!.validate()) { // Pastikan validasi form berjalan
      final db = await DbHelper.initDB();
      await db.update(
        'kehadiran',
        {
          'nama': namaController.text,
          'keterangan': selectedKeterangan, // Gunakan nilai dari dropdown
        },
        where: 'id = ?',
        whereArgs: [
          widget.data['id'],
        ],
      );
      if (context.mounted) {
        Navigator.pop(context, true); // Kirim 'true' sebagai sinyal data berubah
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Kehadiran')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (val) => val!.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
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
                decoration: const InputDecoration(labelText: 'Keterangan'),
                validator: (val) => val == null || val.isEmpty ? 
                'Keterangan wajib dipilih' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _updateData, child: const Text('Update')),
            ],
          ),
        ),
      ),
    );
  }
}