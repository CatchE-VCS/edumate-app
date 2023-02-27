// import 'package:card_swiper/card_swiper.dart';
// import 'package:edumate/pages/reel/content_screen.dart';
// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatelessWidget {
//   final List<String> videos = [
//     'https://assets.mixkit.co/videos/preview/mixkit-winter-fashion-cold-looking-woman-concept-video-39874-large.mp4',
//     'https://assets.mixkit.co/videos/preview/mixkit-womans-feet-splashing-in-the-pool-1261-large.mp4',
//     'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           child: Stack(
//             children: [
//               //We need swiper for every content
//               Swiper(
//                 itemBuilder: (BuildContext context, int index) {
//                   return ContentScreen(
//                     src: videos[0],
//                   );
//                 },
//                 itemCount: videos.length,
//                 scrollDirection: Axis.vertical,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Flutter Shorts',
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     Icon(Icons.camera_alt),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
