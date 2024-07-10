import 'package:flutter/material.dart';

class SignInSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/signinsignup.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                
                  SizedBox(height: 350),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to sign in page
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Background color
                      foregroundColor: Color(0xFF0FA4DC), // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: Color(0xFF0FA4DC)),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to sign up page
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0FA4DC), // Background color
                      foregroundColor: Colors.white, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height:100),
                  Text(
                    'Login with Google',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF43BEE7),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Container(
                      width: 40, // Set the width
                      height: 40, // Set the height
                      child: IconButton(
                        icon: Image.asset(
                          'assets/google_icon.png',
                        ),
                        iconSize: 1, // Adjust the size as needed
                        onPressed: () {
                          // Handle Google login
                        },
                      ),
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
