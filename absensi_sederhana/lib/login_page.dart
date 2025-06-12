import 'package:absensi_sederhana/register_page.dart';
import 'package:absensi_sederhana/bottom_navigator.dart';
import 'package:absensi_sederhana/database/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String id = "/LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureTextA = true;
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF819A91), // Navy blue
      appBar: AppBar(
        backgroundColor: const Color(0xFF819A91),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text("Login", style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Header Text
              const Text(
                "Hello Welcome Back",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Welcome back please\nsign in again",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),

              const SizedBox(height: 40),

              // Email Field
              TextField(
                controller: emailcontroller,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: "Enter Your Email",
                  hintStyle: TextStyle(color: Colors.white70),
                  prefixIcon: Icon(Icons.email, color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Password Field
              TextField(
                controller: passwordcontroller,
                obscureText: _obscureTextA,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: "Enter Your Password",
                  hintStyle: TextStyle(color: Colors.white70),
                  prefixIcon: Icon(Icons.lock, color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      final userData = await DbHelper.login(
                        emailcontroller.text.trim(),
                        passwordcontroller.text.trim(),
                      );

                      if (userData != null) {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('name', userData['name']);
                        await prefs.setString('email', userData['email']);
                        await prefs.setString('phone', userData['phone']);

                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Login berhasil")),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => BottomNavigator(
                                  name: userData['name'],
                                  email: userData['email'],
                                  phone: userData['phone'],
                                ),
                          ),
                        );
                      }
                    } catch (e) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Email atau password salah")),
                      );
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Color(0xFF001F54),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Divider with "or"
              Row(
                children: const [
                  Expanded(child: Divider(color: Colors.white54)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("or", style: TextStyle(color: Colors.white70)),
                  ),
                  Expanded(child: Divider(color: Colors.white54)),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text(
                      "   Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
