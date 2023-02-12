import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:udemy_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';

import '../../../shared/styles/colors.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});

}

class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardingController = PageController();
  bool isLast = false;
  List<BoardingModel> boarding = [
    BoardingModel(title: 'On Board 1 title' , image: 'assets/image/pic_1.png' , body: 'On Board 1 Body'),
    BoardingModel(title: 'On Board 2 title' , image: 'assets/image/pic_2.png' , body: 'On Board 2 Body'),
    BoardingModel(title: 'On Board 3 title' , image: 'assets/image/pic_3.png' , body: 'On Board 3 Body'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: Text(
              'SKIP',
            ),
            onPressed: (){
              submit();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index){
                  if(index == boarding.length -1){
                    setState(() {
                      isLast = true;
                    });
                  }else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardingController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController ,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                    activeDotColor: defaultColor
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      submit();
                    }else{
                      boardingController.nextPage(
                          duration: Duration(
                              milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel boarding) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage(boarding.image),
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        boarding.title,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,

        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        boarding.body,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
    ],
  );

  void submit(){
    CacheHelper.saveData(key:'onBoarding' , value: true).then((value){
      if(value){
        navigateAndFinish(
            context: context ,
            widget: ShopLoginScreen()
        );
      }
    });

  }
}
