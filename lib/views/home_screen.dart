import 'package:flutter/material.dart';
import 'package:projm/userreports.dart';
import 'camera_page.dart';
import 'pdf_upload_page.dart';
import 'sidebar.dart';
// import 'statistics_page.dart';
import 'floating_navigation_bar.dart'; // Import the floating navigation bar
import 'tile_widget.dart'; // Import the tile widget
// import 'package:projm/userreports.dart'; // Import the records page
import 'about_page.dart'; // Import the about page

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(), // Add the sidebar here
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          // Background image covering the top part of the screen
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/halfscreen.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // SafeArea to handle the notch and status bar
          SafeArea(
            child: Column(
              children: [
                // Drawer icon
                Align(
                  alignment: Alignment.topLeft,
                  child: Builder(
                    builder: (context) => IconButton(
                      icon: Icon(Icons.menu, color: const Color.fromARGB(255, 255, 255, 255)),
                      onPressed: () {
                        Scaffold.of(context).openDrawer(); // Open navigation drawer
                      },
                    ),
                  ),
                ),
                // Spacer to push the rest of the content down
                Spacer(),
                // Grid of tiles
                Padding(
                  padding: const EdgeInsets.only(
                      top: 60.0, bottom: 150.0), // Adjusted padding to position tiles correctly
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    padding: EdgeInsets.all(16),
                    physics: NeverScrollableScrollPhysics(), // Prevent scrolling
                    children: [
                      TileWidget(
                        backgroundImage: 'camera tile.png', // Updated image
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CameraPage()),
                          );
                        },
                      ),
                      TileWidget(
                        backgroundImage: 'upload pdf tile.png', // Updated image
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PdfUploadPage()),
                          );
                        },
                      ),
                      TileWidget(
                        backgroundImage: 'about tile.png', // Updated image
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AboutPage()), // Link to StatisticsPage
                          );
                        },
                      ),
                      TileWidget(
                        backgroundImage: 'contact tile.png', // Updated image
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RecordsPage(email: 'wagamo112@gmail.com')), // Link to RecordsPage
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Floating navigation bar
          FloatingNavigationBar(),
        ],
      ),
    );
  }
}
