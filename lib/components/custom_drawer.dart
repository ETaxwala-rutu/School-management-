import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final Map<String, dynamic> userData;

  const CustomDrawer({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Map<String, bool> expandedModules = {};

  // Module → [Screen name, route]
  final Map<String, List<Map<String, String>>> modules = {
    "Dashboard": [
      {"name": "Home", "route": "/dashboard"},
      {"name": "Notifications", "route": "/dashboard/notifications"},
    ],
    "Academics": [
      {"name": "Dashboard", "route": "/academics/dashboard"},
      {"name": "Timetable", "route": "/academics/timetable"},
      {"name": "Subjects", "route": "/academics/subjects"},
    ],
    "Alumni": [
      {"name": "Directory", "route": "/alumni/directory"},
      {"name": "Events", "route": "/alumni/events"},
    ],
    "Attendance": [
      {"name": "Daily Attendance", "route": "/attendance/daily"},
      {"name": "Reports", "route": "/attendance/reports"},
    ],
    "Certificates": [
      {"name": "Bonafide", "route": "/certificates/bonafide"},
      {"name": "Transfer", "route": "/certificates/transfer"},
    ],
    "Student Information": [
      {"name": "Profile", "route": "/student/profile"},
      {"name": "Guardian Info", "route": "/student/guardian"},
    ],
    "Online Examination": [
      {"name": "Exam List", "route": "/exams/list"},
      {"name": "Results", "route": "/exams/results"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Profile Header
          UserAccountsDrawerHeader(
            accountName: Text(widget.userData['name'] ?? "Guest User"),
            accountEmail: Text(widget.userData['email'] ?? ""),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.grey[700]),
            ),
          ),

          // Drawer Menu
          Expanded(
            child: ListView(
              children: modules.entries.map((entry) {
                String moduleName = entry.key;
                List<Map<String, String>> screens = entry.value;
                bool isExpanded = expandedModules[moduleName] ?? false;

                return ExpansionTile(
                  leading: Icon(Icons.folder),
                  title: Text(moduleName),
                  initiallyExpanded: isExpanded,
                  onExpansionChanged: (expanded) {
                    setState(() {
                      expandedModules[moduleName] = expanded;
                    });
                  },
                  children: screens.map((screen) {
                    return ListTile(
                      leading: Icon(Icons.arrow_right),
                      title: Text(screen["name"]!),
                      onTap: () {
                        Navigator.pop(context); // close drawer
                        Navigator.pushNamed(context, screen["route"]!);
                      },
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          ),

          const Divider(),

          // Logout
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Logged out")),
              );
            },
          ),
        ],
      ),
    );
  }
}
