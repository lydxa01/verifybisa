import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uas_traveleasy/page/login.dart';
import 'package:uas_traveleasy/page/AddToCart.dart';
import 'package:uas_traveleasy/page/history_pemesanan.dart'; // Import the history_pemesanan.dart file
import 'package:uas_traveleasy/page/pengaturan.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _userName = "";
  late User? user;

  Future<void> fetchUserData() async {
    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          _userName =
              (userDoc.data() as Map<String, dynamic>)['fullName'] ?? "No Name";
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser; // Initialize the user variable
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Profile Information',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Name: $_userName',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Email: ${user!.email}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddToCart()),
                );
              },
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text("Add to Cart"),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPemesanan()),
                );
              },
              icon: const Icon(Icons.history),
              label: const Text("History Pemesanan"),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Pengaturan()),
                );
              },
              icon: const Icon(Icons.settings),
              label: const Text("Pengaturan"),
            ),
          ],
        ),
      ),
    );
  }
}
