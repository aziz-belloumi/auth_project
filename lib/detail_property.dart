import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailProperty extends StatelessWidget {
  DetailProperty({super.key});

  CarouselController buttonCarouselController = CarouselController();

  List<String> imagesList = [
    "assets/images/img.jpg",
    "assets/images/img.jpg",
    "assets/images/img.jpg",
    "assets/images/img.jpg",
    "assets/images/img.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          // title: Text("dfg"),
          ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            // Carousel images
            // SizedBox(
            //   height: size.height * 0.25,
            //   child: CarouselSlider(
            //     items: [
            //       GestureDetector(
            //         onTap: () {
            //           Get.toNamed('view360_screen');
            //         },
            //         child: SizedBox(
            //             height: size.height * 0.3,
            //             width: size.width,
            //             child: Image.asset("assets/images/img.jpg")),
            //       ),
            //       SizedBox(
            //           width: size.width,
            //           height: size.height * 0.3,
            //           child: Image.asset("assets/images/img.jpg")),
            //       SizedBox(
            //           width: size.width,
            //           height: size.height * 0.3,
            //           child: Image.asset("assets/images/img.jpg")),
            //     ],
            //     carouselController: buttonCarouselController,
            //     options: CarouselOptions(
            //       autoPlay: false,
            //       enlargeCenterPage: true,
            //       scrollDirection: Axis.vertical,
            //       // viewportFraction: 2,
            //       aspectRatio: 2.0,
            //       initialPage: 2,
            //     ),
            //   ),
            // ),
            // ElevatedButton(
            //   onPressed: () => buttonCarouselController.nextPage(
            //       duration: Duration(milliseconds: 300), curve: Curves.linear),
            //   child: Text('→'),
            // )
            SizedBox(
              height: size.height * 0.3,
              width: size.width,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Image.asset(imagesList[0], fit: BoxFit.cover)),
                  Positioned(
                    bottom: 0,
                    left: size.width * 0.35,
                    right: size.width * 0.35,
                    child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed('view360_screen');
                        },
                        child: Text("VR View")),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                      height: size.height * 0.07,
                      width: size.width * 0.17,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          child:
                              Image.asset(imagesList[0], fit: BoxFit.cover))),
                  SizedBox(
                      height: size.height * 0.07,
                      width: size.width * 0.17,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          child:
                              Image.asset(imagesList[0], fit: BoxFit.cover))),
                  SizedBox(
                      height: size.height * 0.07,
                      width: size.width * 0.17,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          child:
                              Image.asset(imagesList[0], fit: BoxFit.cover))),
                  SizedBox(
                      height: size.height * 0.07,
                      width: size.width * 0.17,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          child:
                              Image.asset(imagesList[0], fit: BoxFit.cover))),
                  SizedBox(
                      height: size.height * 0.07,
                      width: size.width * 0.17,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          child:
                              Image.asset(imagesList[0], fit: BoxFit.cover))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
