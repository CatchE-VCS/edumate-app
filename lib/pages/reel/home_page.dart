import 'package:card_swiper/card_swiper.dart';
import 'package:edumate/pages/reel/content_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> linkss = [
      'https://www.figma.com/login',
      'https://www.canva.com/',
      'https://www.programiz.com/cpp-programming/online-compiler/',
      'https://www.figma.com/login',
      'https://www.figma.com/login',
      'https://www.figma.com/login',
      'https://www.programiz.com/cpp-programming/online-compiler/',
      'https://www.figma.com/login',
      'https://www.figma.com/login',
      'https://www.programiz.com/cpp-programming/online-compiler/',
      'https://www.programiz.com/cpp-programming/online-compiler/',
      'https://www.figma.com/login',
      'https://www.figma.com/login',
    ];
    final List<String> videos = [
      'https://akg-hackathons.github.io/edumate_videos/videoplayback (2).mp4',
      'https://akg-hackathons.github.io/edumate_videos/videoplayback (6).mp4',
      'https://akg-hackathons.github.io/edumate_assets/Why%20should%20we%20hire%20you_%20Interview%20Question%20%236.mp4',
      'https://akg-hackathons.github.io/edumate_videos/videoplayback (1).mp4',
      'https://akg-hackathons.github.io/edumate_videos/videoplayback.mp4'
          'https://akg-hackathons.github.io/edumate_videos/videoplayback (3).mp4',
      'https://akg-hackathons.github.io/edumate_videos/videoplayback (4).mp4',
      'https://akg-hackathons.github.io/edumate_videos/videoplayback.mp4',
      'https://akg-hackathons.github.io/edumate_videos/videoplayback (5).mp4',
      'https://akg-hackathons.github.io/edumate_videos/videoplayback (7).mp4',
      'https://akg-hackathons.github.io/edumate_videos/videoplayback (8).mp4',
      'https://akg-hackathons.github.io/edumate_videos/5 Tricks of Google Search.mp4',
      'https://akg-hackathons.github.io/edumate_videos/videoplayback (9).mp4',
    ];
    return Scaffold(
      backgroundColor: Color(0xff1f0e34),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff1f0e34),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text('Educational Shorts'),
      ),
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              //We need swiper for every content
              Swiper(
                itemHeight: MediaQuery.of(context).size.height * 1.2,
                itemBuilder: (BuildContext context, int index) {
                  return ContentScreen(
                    src: videos[index],
                    ss: linkss[index],
                  );
                },
                itemCount: videos.length,
                scrollDirection: Axis.vertical,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // String getUrl(String title) async {
  //   String w = "";
  //   final res = await http
  //       .get(Uri.parse('https://youtube-to-mp4.p.rapidapi.com/url=&title'));
  //   if (res.statusCode == 200) {}
  //   return w;
}
