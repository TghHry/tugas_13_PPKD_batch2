
import 'dart:convert';

class Kehadiran {
  int? id;
  String nama;
  String keterangan;
  Kehadiran({
    this.id,
    required this.nama,
    required this.keterangan,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'keterangan': keterangan,
    };
  }

  factory Kehadiran.fromMap(Map<String, dynamic> map) {
    return Kehadiran(
      id: map['id'] != null ? map['id'] as int : null,
      nama: map['nama'] as String,
      keterangan: map['keterangan'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Kehadiran.fromJson(String source) => Kehadiran.fromMap(json.decode(source) as Map<String, dynamic>);
}
