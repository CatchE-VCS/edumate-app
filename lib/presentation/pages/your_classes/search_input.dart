import 'package:edumate/themes/color.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            margin: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: kFontLight.withValues(alpha: 0.3), width: 2),
            ),
            child: TextField(
              cursorColor: kFontLight,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                fillColor: kFontLight.withValues(alpha: 0.1),
                filled: true,
                contentPadding: const EdgeInsets.all(18),
                border: InputBorder.none,
                hintText: 'Search for history, classes,...',
                hintStyle: const TextStyle(color: kFontLight),
                labelText: 'Search courses and classes',
              ),
            )),
        Positioned(
          right: 45,
          top: 35,
          child: Container(
            decoration: BoxDecoration(
                color: kAccent, borderRadius: BorderRadius.circular(8)),
          ),
        )
      ],
    );
  }
}
