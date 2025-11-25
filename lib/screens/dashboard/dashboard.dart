import 'package:flutter/material.dart';
import '../../components/custom_drawer.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  final Map<String, dynamic> _userData = const {
    "name": "Santosh Asole",
    "email": "santosh@example.com",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DashboardScreen"),
      ),
      drawer: CustomDrawer(userData: _userData),
      body: Center(
        child: Text(
          "Welcome to DashboardScreen",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
