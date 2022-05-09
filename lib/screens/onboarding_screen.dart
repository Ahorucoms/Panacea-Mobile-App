import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panacea/screens/model/onboard_data.dart';
import 'package:panacea/screens/sign_in_options.dart';
import 'package:panacea/screens/sign_up_options.dart';
import 'package:panacea/widgets/app_large_text.dart';
import 'package:panacea/widgets/app_styles.dart';
import 'package:panacea/widgets/size_configs.dart';


class OnBoardingScreen extends StatefulWidget {
  static const String id = 'onboarding-screen';
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPage = 0;

  PageController _pageController = PageController(
    initialPage: 0,

  );
  AnimatedContainer dotIndicator(index){
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 5),
      duration: Duration(milliseconds: 400),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
          color: currentPage == index?kPrimaryColor : kSecondaryColor,
      shape: BoxShape.circle),
    );
  }
  @override
  Widget build(BuildContext context) {
    // initialize size config
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
    double screenHeight= MediaQuery.of(context).size.height;
    double screenWidth= MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 9,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (value){
                          setState(() {
                            currentPage = value;
                          });
                        },
                        itemCount: onboardingContents.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            currentPage == onboardingContents.length -1?
                        Column(
                          children: [
                            SizedBox(
                              height: screenHeight * .025,
                            ),
                            Text(
                              onboardingContents[index].title,
                              style: kTitle,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: screenHeight * .090,),
                            Container(
                              child: Center(child: Text('PANACEA welcome you to the anonymous\n gateway to Healthcare services',
                                style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 16,),
                              textAlign: TextAlign.center,)),
                            ),
                            SizedBox(height: 40,),
                            Center(
                              child: TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, SignUpOptions.id);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Get Started'),
                                    Icon(CupertinoIcons.forward),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Center(
                              child: Image.asset('images/hands.png',
                                height: 250,
                              ),
                            ),
                          ],
                        )
                            // TextButton(onPressed: (){}, child: Text('Get Started'),
                            // )
                            :Column(
                              children: [
                                SizedBox(
                                  height: sizeV * 5,
                                ),
                                Text(
                                  onboardingContents[index].title,
                                  style: kTitle,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: sizeV * 25,
                                ),
                                Text(
                                  onboardingContents[index].text,
                                  style: kTitle,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: sizeV * 5,
                                ),
                                Text(
                                  onboardingContents[index].text1,
                                  style: kBodyText1,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: sizeV * 5,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          currentPage == onboardingContents.length -1?
                              Container()
                              : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              OnBoardNavBtn(onPressed: () {
                                _pageController.nextPage(
                                    duration: Duration(
                                        milliseconds: 400
                                    ),
                                    curve: Curves.easeInOut);
                              }, name: 'Skip',),
                              Row(
                                children: List.generate(
                                    onboardingContents.length, (index) =>
                                dotIndicator(index),
                                ),

                                ),
                              OnBoardNavBtn(onPressed: () {
                                _pageController.nextPage(
                                    duration: Duration(
                                      milliseconds: 400
                                    ),
                                    curve: Curves.easeInOut);
                              }, name: 'Next',),
                            ],
                          ),
                        ],
                      ))
                ],
              ),
            ))
    );
  }
}

class OnBoardNavBtn extends StatelessWidget {
  const OnBoardNavBtn({Key? key, required this.name, required this.onPressed}) : super(key: key);

  final String name;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      splashColor: Colors.black12,
      focusColor: Colors.black12,
      highlightColor: Colors.black12,
      hoverColor: Colors.black12,
      child: Padding(
          padding: const EdgeInsets.all(4.0),
      child: Text(
        name,
        style: kBodyText1,
      ),),
    );
  }
}

