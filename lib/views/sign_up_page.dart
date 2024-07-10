import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode fullNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _passwordError;

  @override
  void dispose() {
    fullNameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    _scrollController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    dobController.dispose();
    super.dispose();
  }

  void _scrollToFocusedField(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
    _scrollController.position.ensureVisible(
      focusNode.context!.findRenderObject()!,
      alignment: 0.5,
      duration: Duration(milliseconds: 500),
    );
  }

  void _validatePasswords() {
    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        _passwordError = 'Passwords do not match';
      });
    } else {
      setState(() {
        _passwordError = null;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        dobController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/signupbg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  controller: _scrollController,
                  children: [
                    SizedBox(height: 250),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15.0,
                            spreadRadius: 1.0,
                            offset: Offset(0.0, 10.0),
                          ),
                        ],
                      ),
                      child: TextField(
                        focusNode: fullNameFocusNode,
                        onTap: () => _scrollToFocusedField(context, fullNameFocusNode),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Full Name',
                          labelStyle: TextStyle(color: Color.fromARGB(255, 161, 162, 163)),
                          
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15.0,
                            spreadRadius: 1.0,
                            offset: Offset(0.0, 10.0),
                          ),
                        ],
                      ),
                      child: TextField(
                        focusNode: emailFocusNode,
                        onTap: () => _scrollToFocusedField(context, emailFocusNode),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Color.fromARGB(255, 161, 162, 163)),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15.0,
                            spreadRadius: 1.0,
                            offset: Offset(0.0, 10.0),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: dobController,
                        onTap: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          await _selectDate(context);
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.calendar_today),
                          labelText: 'Date of Birth',
                          labelStyle: TextStyle(color: Color.fromARGB(255, 161, 162, 163)),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15.0,
                            spreadRadius: 1.0,
                            offset: Offset(0.0, 10.0),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: passwordController,
                        focusNode: passwordFocusNode,
                        onTap: () => _scrollToFocusedField(context, passwordFocusNode),
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Color.fromARGB(255, 161, 162, 163)),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15.0,
                            spreadRadius: 1.0,
                            offset: Offset(0.0, 10.0),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: confirmPasswordController,
                        focusNode: confirmPasswordFocusNode,
                        onTap: () => _scrollToFocusedField(context, confirmPasswordFocusNode),
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(color: Color.fromARGB(255, 161, 162, 163)),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword = !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                        onChanged: (value) => _validatePasswords(),
                      ),
                    ),
                    if (_passwordError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Center(
                          child: Text(
                            _passwordError!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    SizedBox(height: 30),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6, // 60% of screen width
                        child: ElevatedButton(
                          onPressed: () {
                            _validatePasswords();
                            if (_passwordError == null) {
                              // Handle sign up
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0FA4DC),
                            foregroundColor: Colors.white,
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
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                color: Color(0xFF43BEE7),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20), // Add space at the bottom if needed
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
