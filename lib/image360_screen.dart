import 'package:convergeimmob/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:imageview360/imageview360.dart';
import 'package:panorama_viewer/panorama_viewer.dart';
import 'package:video_360/video_360.dart';

class Image360Screen extends StatelessWidget {
  const Image360Screen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Video360Controller? video360Controller;

    String durationText = '';

    String totalText = '';

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: SizedBox(
              width: size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icon(
                  //   Icons.menu,
                  //   size: size.width * 0.08,
                  // ),
                  // Icon(
                  //   Icons.notifications_none_rounded,
                  //   size: size.width * 0.08,
                  // ),
                ],
              ),
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: AppColors.white,
      ),
      body: Center(
        child: PanoramaViewer(
          child: Image.asset('assets/images/img.jpg'),
        ),
      ),

      // Container(
      //   height: MediaQuery.of(context).size.height,
      //   child: Column(
      //     children: [
      //       // ElevatedButton(onPressed: () {}, child: Text("gkdfjn")),
      //       //The 3D viewer widget
      //       // Container(
      //       //   width: MediaQuery.of(context).size.width,
      //       //   height: MediaQuery.of(context).size.height * 0.2,
      //       //   child: Flutter3DViewer(
      //       //     controller: controller,
      //       //     src: 'assets/models/bean.glb',
      //       //   ),
      //       // ),
      //       // Stack(
      //       //   children: [
      //       //     Center(
      //       //       child: Container(
      //       //         width: width,
      //       //         height: height,
      //       //         child: Video360View(
      //       //           onVideo360ViewCreated: _onVideo360ViewCreated,
      //       //           url:
      //       //               'https://bitmovin-a.akamaihd.net/content/playhouse-vr/m3u8s/105560.m3u8',
      //       //           onPlayInfo: (Video360PlayInfo info) {
      //       //             setState(() {
      //       //               durationText = info.duration.toString();
      //       //               totalText = info.total.toString();
      //       //             });
      //       //           },
      //       //         ),
      //       //       ),
      //       //     ),
      //       //     Column(
      //       //       children: [
      //       //         Row(
      //       //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       //           children: [
      //       //             MaterialButton(
      //       //               onPressed: () {
      //       //                 video360Controller?.play();
      //       //               },
      //       //               color: Colors.grey[100],
      //       //               child: Text('Play'),
      //       //             ),
      //       //             MaterialButton(
      //       //               onPressed: () {
      //       //                 video360Controller?.stop();
      //       //               },
      //       //               color: Colors.grey[100],
      //       //               child: Text('Stop'),
      //       //             ),
      //       //             MaterialButton(
      //       //               onPressed: () {
      //       //                 video360Controller?.reset();
      //       //               },
      //       //               color: Colors.grey[100],
      //       //               child: Text('Reset'),
      //       //             ),
      //       //             MaterialButton(
      //       //               onPressed: () {
      //       //                 video360Controller?.jumpTo(80000);
      //       //               },
      //       //               color: Colors.grey[100],
      //       //               child: Text('1:20'),
      //       //             ),
      //       //           ],
      //       //         ),
      //       //         Row(
      //       //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       //           children: [
      //       //             MaterialButton(
      //       //               onPressed: () {
      //       //                 video360Controller?.seekTo(-2000);
      //       //               },
      //       //               color: Colors.grey[100],
      //       //               child: Text('<<'),
      //       //             ),
      //       //             MaterialButton(
      //       //               onPressed: () {
      //       //                 video360Controller?.seekTo(2000);
      //       //               },
      //       //               color: Colors.grey[100],
      //       //               child: Text('>>'),
      //       //             ),
      //       //             Flexible(
      //       //               child: MaterialButton(
      //       //                 onPressed: () {},
      //       //                 color: Colors.grey[100],
      //       //                 child: Text(durationText + ' / ' + totalText),
      //       //               ),
      //       //             ),
      //       //           ],
      //       //         )
      //       //       ],
      //       //     )
      //       //   ],
      //       // ),
      //       // Container(
      //       //     height: MediaQuery.of(context).size.height,
      //       //     child: ImageView360Example())
      //       Center(
      //         child: PanoramaViewer(
      //           child: Image.asset('assets/images/img.jpg'),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

class ImageView360Example extends StatefulWidget {
  @override
  _ImageView360ExampleState createState() => _ImageView360ExampleState();
}

class _ImageView360ExampleState extends State<ImageView360Example> {
  List<ImageProvider> imageList = [];

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  void loadImages() {
    for (int i = 1; i <= 36; i++) {
      imageList.add(AssetImage('assets/images/img.jpg'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return imageList.isEmpty
        ? CircularProgressIndicator()
        : SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ImageView360(
              key: UniqueKey(),
              imageList: imageList,
              autoRotate: true,
              rotationCount: 2,
              rotationDirection: RotationDirection.anticlockwise,
              frameChangeDuration: Duration(milliseconds: 50),
              swipeSensitivity: 2,
              allowSwipeToRotate: true,
            ),
          );
  }
}
