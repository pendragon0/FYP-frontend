import 'package:flutter/material.dart';
import 'package:projm/views/home_screen.dart'; // Ensure this import points to your actual HomeScreen file

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  _SliderScreenState createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onNextButtonPressed() {
    if (_currentIndex < 2) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to HomeScreen on the last page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(email: 'wagamo112@gmail.com', name: 'Wahaj',)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              Image.asset('assets/sliderimage1.png', fit: BoxFit.cover),
              Image.asset('assets/sliderimage2.png', fit: BoxFit.cover),
              Image.asset('assets/sliderimage3.png', fit: BoxFit.cover),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? Color(0xFFDEBCFF)
                            : Color(0xFFDEBCFF).withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _onNextButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFDEBCFF),
                    padding: EdgeInsets.symmetric(horizontal: 70, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadowColor: Colors.black.withOpacity(0.5),
                    elevation: 10,
                  ),
                  child: Text(
                    _currentIndex < 2 ? 'Next →' : 'Get Started',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
