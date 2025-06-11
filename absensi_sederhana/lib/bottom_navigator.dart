import 'package:absensi_sederhana/laporan_kehadiran.dart';
import 'package:absensi_sederhana/list_kehadiran.dart';
import 'package:absensi_sederhana/profil.dart';

import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  BottomNavigator({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
  });

  final String name;
  final String email;
  final String phone;

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.add(ListKehadiranPage());
    _pages.add(LaporanKehadiranPage());
    _pages.add(
      ProfilPage(name: widget.name, email: widget.email, phone: widget.phone),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff819A91),
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List Absensi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Laporan Kehadiran',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Profil'),
        ],
      ),
    );
  }
}
