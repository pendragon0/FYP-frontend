import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/profilebg.png'), // Background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Spacer(), // Pushes the rest of the content down
                    ],
                  ),
                  SizedBox(height: 300), // Adjust height to position elements correctly
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.person, color: Color.fromRGBO(3, 195, 183, 1)),
                          title: Text(
                            'Shabbo Babbo', // Replace with actual user name from the backend
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            'Full Name',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Divider(color: Colors.grey),
                        ListTile(
                          leading: Icon(Icons.cake, color: Color.fromRGBO(3, 195, 183, 1)),
                          title: Text(
                            'January 1, 1990', // Replace with actual birthdate from the backend
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            'Birthday',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Divider(color: Colors.grey),
                        ListTile(
                          leading: Icon(Icons.email, color: Color.fromRGBO(3, 195, 183, 1)),
                          title: Text(
                            'shabbo@babbo.com', // Replace with actual email from the backend
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Divider(color: Colors.grey),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
