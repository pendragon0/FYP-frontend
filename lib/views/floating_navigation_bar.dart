import 'package:flutter/material.dart';
import 'camera_page.dart';

class FloatingNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.grid_view,
                          color: Color.fromRGBO(125, 125, 125, 1)),
                      onPressed: () {
                        // Handle grid view button press
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.person,
                          color: Color.fromRGBO(125, 125, 125, 1)),
                      onPressed: () {
                        // Handle profile button press
                      },
                    ),
                  ],
                ),
              ),
            ),
            FloatingActionButton(
              backgroundColor: Color.fromRGBO(0, 153, 255, 1),
              child: Icon(Icons.add_a_photo, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
