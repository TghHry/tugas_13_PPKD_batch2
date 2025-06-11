import 'package:flutter/material.dart';
import 'package:absensi_sederhana/database/db_helper.dart';
import 'package:absensi_sederhana/edit_kehadiran.dart';
import 'package:absensi_sederhana/tambah_kehadiran.dart';

class ListKehadiranPage extends StatefulWidget {
  static const String id = "/ListKehadiran";
  @override
  _ListKehadiranPageState createState() => _ListKehadiranPageState();
}

class _ListKehadiranPageState extends State<ListKehadiranPage> {
  Future<List<Map<String, dynamic>>> getData() async {
    final db = await DbHelper.initDB();
    return await db.query('kehadiran', orderBy: 'tanggal DESC');
  }

  Future<void> _deleteData(int id) async {
    final db = await DbHelper.initDB();
    await db.delete('kehadiran', where: 'id = ?', whereArgs: [id]);
    setState(() {}); // Refresh UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD1D8BE),
      appBar: AppBar(
        title: Text(
          "List Kehadiran",
          style: TextStyle(color: Color(0xffEEEFE0)),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          final data = snapshot.data!;
          if (data.isEmpty)
            return Center(child: Text("Belum ada data kehadiran."));
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Color(0xffA7C1A8),
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text(item['nama']),
                    subtitle: Text(
                      "${item['keterangan']} (${item['tanggal'].substring(0, 10)})",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditKehadiranPage(data: item),
                              ),
                            ).then((_) => setState(() {}));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteData(item['id']),
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
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TambahKehadiranPage()),
            ).then((_) => setState(() {})), // Refresh after return
        child: Icon(Icons.add, color: Colors.black),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
