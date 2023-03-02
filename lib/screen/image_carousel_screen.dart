import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageCarouselScreen extends StatefulWidget {
  const ImageCarouselScreen({Key? key}) : super(key: key);

  @override
  State<ImageCarouselScreen> createState() => _ImageCarouselScreenState();
}

class _ImageCarouselScreenState extends State<ImageCarouselScreen> {

  final PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer.periodic(
        Duration(seconds: 3),
            (timer) {
          // 현재 페이지
          int? nextPage = pageController.page?.toInt();

          if(nextPage == null){ // 페이지 값이 없을 때 예외처리
            return;
          }

          if(nextPage == 4){
            nextPage = 0;
          }else{
            nextPage++;
          }
          pageController.animateToPage(nextPage, duration: Duration(milliseconds: 500), curve: Curves.ease);
        }
        );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [1, 2, 3, 4, 5].map((number) => Image.asset('assets/img/image_$number.jpeg', fit: BoxFit.fill,),
        ).toList(),
      ),
    );
  }
}
