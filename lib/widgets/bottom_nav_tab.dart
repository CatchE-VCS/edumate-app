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
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: selected! ? 69 : 58,
      padding: EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shape: selected!
              ? const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                )
              : const RoundedRectangleBorder(),
        ),
        onPressed: (() {
          callback(val);
        }),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              size: selected! ? 24 : 18,
              color: selected! ? Colors.white : const Color(0xFFB7B7B7),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: selected! ? 8 : 6,
                color: selected! ? Colors.white : const Color(0xFFB7B7B7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
