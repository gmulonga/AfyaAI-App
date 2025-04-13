import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:afyaai/utils/constants.dart';
import 'package:afyaai/views/mobile/auth/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:afyaai/views/widgets/custom_button.dart';
// import 'package:afyaai/routes/';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activeIndex = 0;
  final controller = CarouselController();

  final List<String> images = [
    'images/image_1.png',
    'images/image_3.png',
    'images/image_2.png',
  ];

  final List<String> captions = [
    "Describe how you feel — get instant health insights powered by AI.",
    "Your symptoms, decoded. Know what could be wrong and what to do next.",
    "Get smart advice, home remedies, and when to visit a clinic — all in one place.",
  ];

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(children: [
        SafeArea(
          child: Container(
            height: screenHeight,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Expanded(
                        child: CarouselSlider.builder(
                          itemCount: images.length,
                          itemBuilder: (context, index, realIndex) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    captions[index],
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.04,
                                      color: kGreen,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Expanded(
                                  child: Image.asset(
                                    images[index],
                                    fit: BoxFit.contain,
                                    width: screenWidth * 0.9,
                                  ),
                                ),
                              ],
                            );
                          },
                          options: CarouselOptions(
                            height: screenHeight * 0.4,
                            // Adjust for responsiveness
                            autoPlay: true,
                            enlargeCenterPage: true,
                            viewportFraction: 0.9,
                            onPageChanged: (index, reason) {
                              setState(() {
                                activeIndex = index;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      AnimatedSmoothIndicator(
                        activeIndex: activeIndex,
                        count: images.length,
                        effect: ExpandingDotsEffect(
                          dotWidth: 10,
                          dotHeight: 10,
                          activeDotColor: kGreen,
                          dotColor: kLightGreen,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 10),
                        SizedBox(height: 10),
                        CustomButton(
                          callBackFunction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          label: 'Get Started',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child:
                                Divider(thickness: 0.5, color: kGreen)),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                              child: Text("AfyaAI",
                                  style: TextStyle(
                                    color: kGreen,
                                    fontSize: screenWidth * 0.04,
                                  )),
                            ),
                            Expanded(
                                child:
                                Divider(thickness: 0.5, color: kGreen)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}