import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class OptionsScreen extends StatelessWidget {
  final String src;
  const OptionsScreen({Key? key, required this.src}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      final uri = Uri.parse(src);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      } else {
                        throw 'Could not launch $src';
                      }
                    },
                    child: Icon(
                      Icons.comment_rounded,
                      size: 32,
                    ),
                  ),
                  SizedBox(height: 20),
                  Transform(
                    transform: Matrix4.rotationZ(5.8),
                    child: GestureDetector(
                      onTap: () async {
                        await Share.share(src);
                      },
                      child: Icon(
                        Icons.send,
                        size: 32,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
