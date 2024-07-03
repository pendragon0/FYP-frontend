import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:projm/pdfscanpage.dart';

// import 'package:projm/controllers/model_controller.dart';

class SliderScreen extends StatelessWidget {
  const SliderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      headerBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      controllerColor: Colors.black,
      finishButtonText: 'Register',
      finishButtonStyle: const FinishButtonStyle(
          backgroundColor: Color.fromARGB(255, 0, 0, 0)),
      skipTextButton: const Text('Skip'),
      trailing: const Text('Login'),
      
      
      // Navigation Function ********************
      trailingFunction: () {

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ScanPDF())
        );
        print('******************PRESSED');
        // OCR SERVICE TESTING ****

        // generatingText();
        
      },

      background: [
        Image.asset('images/sliderimage1.png'),
        Image.asset('images/sliderimage2.png'),
        Image.asset('images/sliderimage1.png')
      ],
      totalPage: 3,
      speed: 1.8,
      centerBackground: true,
      pageBodies: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 400,
                ),
                Column(
                  children: [
                    RichText(text: const TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.0,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Welcome to MedScan', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '\n\nYour Personal Health Assistant', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        TextSpan(text: '\n\nEmpowering you with the ability to understand your health better. Get quick insights and diagnoses based on your reports.', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w100))
                      ]
                    )),
                  ],
                ),
              ],
            )),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 400,
                ),
                Column(
                  children: [
                    RichText(text: const TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.0,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Upload Reports Easily', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '\n\nScan or upload your CBC reports', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        TextSpan(text: '\n\nSimply scan or upload your CBC reports in PDF format. Our app will analyze and provide detailed insights into your blood profile.', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w100))
                      ]
                    )),
                  ],
                ),
              ],
            )),
            Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 400,
                ),
                Column(
                  children: [
                    RichText(text: const TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.0,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Instant Diagnosis', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '\n\nReceive quick and accurate results', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        TextSpan(text: '\n\nGet instant analysis and diagnosis based on your CBC reports. Undetstand your health status comprehensively.', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w100))
                      ]
                    )),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}

class SlideModel {
  final String imagePath;
  final String title;
  final String desc;
  final Color backgroundColor;

  SlideModel({
    required this.imagePath,
    required this.title,
    required this.desc,
    required this.backgroundColor,
  });
}