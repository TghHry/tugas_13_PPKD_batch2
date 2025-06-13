import 'package:flutter/material.dart';
import 'package:absensi_sederhana/tambah_kehadiran.dart';
import 'package:absensi_sederhana/edit_kehadiran.dart';
import 'package:absensi_sederhana/database/db_helper.dart';
import 'package:absensi_sederhana/model/model.dart';

class ListKehadiranPage extends StatefulWidget {
  static const String id = "/ListKehadiran";

  @override
  _ListKehadiranPageState createState() => _ListKehadiranPageState();
}

class _ListKehadiranPageState extends State<ListKehadiranPage> {
  Future<List<Kehadiran>> getData() async {
    final db = await DbHelper.initDB();
    final List<Map<String, dynamic>> maps = await db.query('kehadiran', orderBy: 'tanggal DESC');

    return List.generate(maps.length, (i) {
      return Kehadiran.fromMap(maps[i]); // Menggunakan metode dariMap
    });
  }

  Future<void> _deleteData(int id) async {
    final db = await DbHelper.initDB();
    await db.delete('kehadiran', where: 'id = ?', whereArgs: [id]);
    setState(() {}); // Refresh UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEFE0),
      appBar: AppBar(
        leading: Container(),
        title: Text("List Kehadiran", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.teal[300],
      ),
      body: FutureBuilder<List<Kehadiran>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Terjadi kesalahan: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Belum ada data kehadiran."));
          }
          final data = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  color: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.person, color: Colors.teal),
                    title: Text(
                      item.nama,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${item.keterangan} (${item.tanggal.substring(0, 10)})",
                      style: TextStyle(color: Colors.black54),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.teal),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditKehadiranPage(kehadiran: item),
                              ),
                            ).then((_) => setState(() {}));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // Menampilkan dialog konfirmasi
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Konfirmasi Hapus"),
                                  content: Text(
                                    "Apakah Anda yakin ingin menghapus data ini?",
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text("Batal"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                    child: Text("Hapus"),
                                    onPressed: () {
                                    if (item.id != null) { 
                                    _deleteData(item.id!); 
                                         }
                                    Navigator.of(context).pop(); 
                                      },
                                    ) ,

                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TambahKehadiranPage()),
        ).then((_) => setState(() {})), // Refresh after return
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
