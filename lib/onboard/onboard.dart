import 'package:onboardscreenflutter/home.dart';
import 'package:onboardscreenflutter/onboard/onboard_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int currentIndex = 0;
  late PageController _pageController;
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
        img: 'assets/images/img-1.png',
        text: "Belajar Dengan Metode Learning by Doing",
        desc:
            "Sebuah metode belajar yang terbuktiampuh dalam meningkatkan produktifitas belajar, Learning by Doing",
        bg: Colors.amber,
        btnBg: Color(0xFF4756DF),
        nextColor: Colors.white,
        smBtnBg: Colors.red,
        skipColor: Colors.black,
        text1Color: Colors.black,
        text2Color: Colors.black)
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: screens[currentIndex].bg,
        appBar: AppBar(
          backgroundColor: screens[currentIndex].bg,
          elevation: 0.0,
          actions: [
            TextButton(
              onPressed: () {
                _storeOnboardInfo();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: Text(
                "Skip",
                style: TextStyle(
                  color: screens[currentIndex].skipColor,
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: PageView.builder(
              itemCount: screens.length,
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(screens[index].img),
                    Container(
                      height: 10.0,
                      child: ListView.builder(
                        itemCount: screens.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 3.0),
                                  width: currentIndex == index ? 25 : 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: screens[currentIndex].smBtnBg,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ]);
                        },
                      ),
                    ),
                    Text(
                      screens[index].text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: screens[index].text1Color,
                      ),
                    ),
                    Text(
                      screens[index].desc,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'Montserrat',
                        color: screens[index].text2Color,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        print(index);
                        if (index == screens.length - 1) {
                          await _storeOnboardInfo();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        }

                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.bounceIn,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10),
                        decoration: BoxDecoration(
                            color: screens[index].btnBg,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Text(
                            "Next",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: screens[index].nextColor),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Icon(
                            Icons.arrow_forward_sharp,
                            color: screens[index].nextColor,
                          )
                        ]),
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
