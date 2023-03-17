import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

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
                  Icon(
                    Icons.favorite_outline,
                    size: 32,
                  ),
                  Text(
                    '0',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(height: 20),
                  Icon(
                    Icons.comment_rounded,
                    size: 32,
                  ),
                  Text(
                    '0',
                    style: TextStyle(color: Colors.white, fontSize: 14),
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
