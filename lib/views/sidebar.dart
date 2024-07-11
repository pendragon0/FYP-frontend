import 'package:flutter/material.dart';
import 'records_page.dart'; // Import the RecordsPage

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white, // Set the background color to white
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                'Shabbo Babbo',
                style: TextStyle(color: Colors.black),
              ),
              accountEmail:
                  Text('User ID', style: TextStyle(color: Colors.black)),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/user.png'), // Add your user image asset here
              ),
              decoration: BoxDecoration(
                color: Colors.white, // Changed the background color to white
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom:
                      26.0), // Add padding between the divider and categories
            ),
            Container(
              margin: EdgeInsets.only(left: 0, right: 30), // Adjusted margin
              decoration: BoxDecoration(
                color: Color.fromRGBO(67, 190, 231, 1),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  splashColor: Colors.blue.withOpacity(0.3),
                  onTap: () {
                    // Navigate to the RecordsPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecordsPage()),
                    );
                  },
                  child: ListTile(
                    leading: Icon(Icons.folder, color: Colors.white),
                    title: Text(
                      'Records',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8), // Space to remove lines above and below
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero, // Removed padding from ListView
                children: [
                  ListTile(
                    leading: Icon(Icons.insert_drive_file_outlined),
                    title: Text('Uploaded Files'),
                    onTap: () {
                      // Handle tap
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.message_outlined),
                    title: Text('Chatbot'),
                    onTap: () {
                      // Handle tap
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.timeline_outlined),
                    title: Text('Shared Records'),
                    onTap: () {
                      // Handle tap
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.help_outline),
                    title: Text('Help'),
                    onTap: () {
                      // Handle tap
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Log out'),
                    onTap: () {
                      // Handle tap
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
