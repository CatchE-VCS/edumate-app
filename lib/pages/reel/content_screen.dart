import 'package:chewie/chewie.dart';
import 'package:edumate/pages/reel/like_screen.dart';
import 'package:edumate/pages/reel/options_screen.dart';
import 'package:edumate/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ContentScreen extends StatefulWidget {
  final String src;

  const ContentScreen({super.key, required this.src});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _liked = false;
  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future initializePlayer() async {
    // Initialize the video player controller with the network URL
    final Uri videoUrl = Uri.parse(widget.src);
    _videoPlayerController = VideoPlayerController.networkUrl(videoUrl);
    await Future.wait([_videoPlayerController!.initialize()]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      showControls: false,
      looping: true,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color(0xFF1F0E14),
            Color(0xBF37194C),
            Color(0xB34E2178),
            Color(0xD934134F),
            Color(0xFF1F0E24),
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            _chewieController != null &&
                    _chewieController!.videoPlayerController.value.isInitialized
                ? GestureDetector(
                    onDoubleTap: () {
                      setState(() {
                        _liked = !_liked;
                      });
                    },
                    child: Chewie(
                      controller: _chewieController!,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text('Loading...')
                    ],
                  ),
            if (_liked)
              Center(
                child: LikeIcon(),
              ),
            OptionsScreen(
              src: widget.src,
            )
          ],
        ),
        bottomNavigationBar: BottomNav(
          context: context,
        ),
        extendBody: true,
      ),
    );
  }
}
