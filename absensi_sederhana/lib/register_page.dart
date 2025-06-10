import 'package:absensi_sederhana/model/model.dart';
import 'package:flutter/material.dart';

// import 'package:absensi_sederhana/model/model.dart';
import 'package:absensi_sederhana/database/db_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  // static const String id = "/register_screen_app";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscureTextA = true;
  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001F54), // Navy blue

      appBar: AppBar(
        backgroundColor: const Color(0xFF001F54),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            // Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        title: Text("Registrasi", style: TextStyle(color: Colors.white)),
      ),
      body: Form(
        key: _formkey,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                // Header Text
                Text(
                  "Registrasi",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Welcome back please\nsign in again",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),

                const SizedBox(height: 40),

                const SizedBox(height: 24),

                // NAME
                TextFormField(
                  validator:
                      (value) =>
                          value == null || value.isEmpty ? "Wajib diisi" : null,
                  style: TextStyle(color: Colors.white),
                  controller: namecontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    hintText: "Enter Your Name",
                    hintStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.person, color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white10),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                // USERNAME
                TextFormField(
                  validator:
                      (value) =>
                          value == null || value.isEmpty ? "Wajib diisi" : null,
                  style: TextStyle(color: Colors.white),
                  controller: usernamecontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    hintText: "Enter Your Username",
                    hintStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(
                      Icons.person_2_outlined,
                      color: Colors.white70,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white10),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                //PHONE
                TextFormField(
                  validator:
                      (value) =>
                          value == null || value.isEmpty ? "Wajib diisi" : null,
                  // style: GoogleFonts.roboto(color: Colors.white),
                  controller: phonecontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    hintText: "Enter Your Number",
                    hintStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.phone, color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white10),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                 // Email Field
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Wajib diisi";
                    if (!value.contains("@")) return "Email tidak Valid";
                    return null;
                  },
                  style: TextStyle(color: Colors.white),
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    hintText: "Enter Your Email",
                    hintStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.email, color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white10),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                // Password Field
                TextFormField(
                  validator:
                      (value) =>
                          value == null || value.isEmpty ? "Wajib diisi" : null,
                  controller: passwordcontroller,
                  obscureText: _obscureTextA,
                  style: TextStyle(color: Colors.white70),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.lock, color: Colors.white70),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureTextA ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureTextA = !_obscureTextA;
                        });
                      },
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white10),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Login Button
                SizedBox(
                  width: 300,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        print("Email : ${emailcontroller.text}");
                        print("Name : ${namecontroller.text}");
                        print("Username : ${usernamecontroller.text}");
                        print("Number : ${phonecontroller.text}");
                        print("password : ${passwordcontroller.text}");
                        DbHelper.registerUser(
                          email: emailcontroller.text,
                          phone: phonecontroller.text,
                          name: namecontroller.text,
                          username: usernamecontroller.text,
                          password: passwordcontroller.text,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Registration Successfull",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: const Color(0xFF001F54),
                          ),
                        );
                      }
                      // TODO: Handle login
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Color(0xFF001F54),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 60),

                // Divider with "or"
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.white54)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "or",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.white54)),
                  ],
                ),

                const SizedBox(height: 30),

                // Facebook Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: const Icon(Icons.facebook, color: Colors.white),
                    onPressed: () {},
                    label: const Text(
                      "Facebook",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                SizedBox(height: 30),

                // Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        // TODO : HAndle sign up
                      },
                      child: Text(
                        "   Sign In",
                        style: TextStyle(
                          color: Colors.blue,
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
      ),
    );
  }
}
