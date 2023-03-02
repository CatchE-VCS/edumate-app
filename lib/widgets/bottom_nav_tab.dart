import 'package:flutter/material.dart';

class BottomNavTab extends StatelessWidget {
  const BottomNavTab({
    super.key,
    required this.val,
    required this.icon,
    required this.text,
    required this.selected,
    required this.callback,
  });
  final int val;
  final IconData icon;
  final String text;
  final bool? selected;
  final callback;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: selected! ? 108 : 68,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: selected! ? Color(0xffE8EAF6) : Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)))),
        onPressed: (() {
          callback(val);
        }),
        child: RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            children: [
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(
                  icon,
                  size: selected! ? 18 : 24,
                  color: selected!
                      ? const Color(0xff303F9F)
                      : const Color(0xFFB7B7B7),
                ),
              ),
              selected!
                  ? TextSpan(
                      text: "  ${text}",
                      style: const TextStyle(
                        color: Color(0xff303F9F),
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : const TextSpan(
                      text: "",
                    ),
            ],
          ),
        ),
      ),
    );
  }
}