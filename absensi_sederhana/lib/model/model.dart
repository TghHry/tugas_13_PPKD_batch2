import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Kehadiran {
  final int? id;
  final String nama;
  final String keterangan;
  final String tanggal;

  Kehadiran({
    this.id,
    required this.nama,
    required this.keterangan,
    required this.tanggal,
  });

 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'id': id,
      'nama': nama,
      'keterangan': keterangan,
      'tanggal': tanggal,
    };
  }

  factory Kehadiran.fromMap(Map<String, dynamic> map) {
    return Kehadiran(
      id: map['id'] != null ? map['id'] as int : null,
      nama: map['nama'] as String,
      keterangan: map['keterangan'] as String,
      tanggal: map['tanggal'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Kehadiran.fromJson(String source) => Kehadiran.fromMap(json.decode(source) as Map<String, dynamic>);
}
