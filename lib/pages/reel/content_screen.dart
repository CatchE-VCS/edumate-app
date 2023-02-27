// import 'package:chewie/chewie.dart';
// import 'package:edumate/pages/reel/like_screen.dart';
// import 'package:edumate/pages/reel/options_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// class ContentScreen extends StatefulWidget {
//   final String? src;
//
//   const ContentScreen({Key? key, this.src}) : super(key: key);
//
//   @override
//   _ContentScreenState createState() => _ContentScreenState();
// }
//
// class _ContentScreenState extends State<ContentScreen> {
//   VideoPlayerController? _videoPlayerController;
//   ChewieController? _chewieController;
//   bool _liked = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _videoPlayerController =
//         VideoPlayerController.asset('assets/video/video-1.mp4')
//           ..initialize().then((_) {
//             setState(() {});
//             _videoPlayerController!.play();
//           });
//   }
//
//   @override
//   void dispose() {
//     _videoPlayerController!.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         Center(
//           child: _videoPlayerController!.value.isInitialized
//               ? VideoPlayer(_videoPlayerController!)
//               : Container(),
//         ),
//         // ? GestureDetector(
//         //     onDoubleTap: () {
//         //       setState(() {
//         //         print(_chewieController);
//         //         _liked = !_liked;
//         //       });
//         //     },
//         //   )
//         // : Column(
//         //     mainAxisAlignment: MainAxisAlignment.center,
//         //     children: [
//         //       CircularProgressIndicator(),
//         //       SizedBox(height: 10),
//         //       Text('Loading...')
//         //     ],
//         //   ),
//         if (_liked)
//           Center(
//             child: LikeIcon(),
//           ),
//         OptionsScreen()
//       ],
//     );
//   }
// }
