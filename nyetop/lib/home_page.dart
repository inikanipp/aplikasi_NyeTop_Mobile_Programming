import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'second_page.dart';



class LaptopRentalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laptop Rental',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final String userName = "Shin Tae Young";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selamat datang, $userName"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: ()async{
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SecondPage()),
              );
            },
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("Rental Aktif", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text("2 Unit"),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Saldo Kredit", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text("Rp 150.000"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Text("Jelajahi Layanan Kami", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 10),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            physics: NeverScrollableScrollPhysics(),
            children: [
              _buildServiceItem(Icons.laptop, "Laptop"),
              _buildServiceItem(Icons.headset, "Aksesoris"),
              _buildServiceItem(Icons.local_offer, "Promo"),
              _buildServiceItem(Icons.support_agent, "Bantuan"),
              _buildServiceItem(Icons.security, "Asuransi"),
              _buildServiceItem(Icons.info_outline, "Tentang Kami"),
            ],
          ),
          SizedBox(height: 20),
          Text("Penawaran Anda", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 10),
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.blue.shade100,
            ),
            child: Center(
              child: ElevatedButton(onPressed: ()async{
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SecondPage()),
              );
              }, child:Text("logout")),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.laptop), label: "Rental"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildServiceItem(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.blue.shade50,
          child: Icon(icon, color: Colors.blue),
        ),
        SizedBox(height: 6),
        Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
