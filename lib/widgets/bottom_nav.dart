import 'package:edumate/widgets/bottom_nav_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key, required this.context});
  // final double width;
  final BuildContext context;
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final bool bottomText1 = true,
      bottomText2 = false,
      bottomText3 = false,
      bottomText4 = false;

  Map<int, bool> selected = {0: true, 1: false, 2: false, 3: false};

  changeBottomtab(int x) {
    setState(() {
      for (int i = 0; i < 4; i++) {
        if (x == i) {
          selected[i] = true;
        } else {
          selected[i] = false;
        }
      }
    });
    if (x == 0) Navigator.of(widget.context).pushNamed('/');
    if (x == 1) Navigator.of(widget.context).pushNamed('/skill');
    if (x == 2) Navigator.of(widget.context).pushNamed('/reels');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(widget.context).size.width * 0.09),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffEEEEEE), width: 1),
            borderRadius: const BorderRadius.all(Radius.elliptical(20, 20)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                // offset: Offset(0, 2),
                color: Colors.grey,
                blurStyle: BlurStyle.outer,
                blurRadius: 3,
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomNavTab(
                  val: 0,
                  icon: Icons.home_rounded,
                  text: "Home",
                  selected: selected[0],
                  callback: changeBottomtab),
              BottomNavTab(
                  val: 1,
                  icon: Icons.credit_card_outlined,
                  text: "Credit",
                  selected: selected[1],
                  callback: changeBottomtab),
              BottomNavTab(
                val: 2,
                icon: Icons.pie_chart_outline,
                text: "Analysis",
                selected: selected[2],
                callback: changeBottomtab,
              ),
              Container(
                width: selected[3]! ? 108 : 68,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor:
                        selected[3]! ? Color(0xffE8EAF6) : Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                  onPressed: (() {
                    changeBottomtab(3);
                  }),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: selected[3]! ? 18 : 24,
                                  padding: EdgeInsets.all(selected[3]! ? 4 : 4),
                                  child: SvgPicture.asset(
                                    "assets/images/Vectoraward.svg",
                                    width: selected[3]! ? 18 : 20,
                                    color: selected[3]!
                                        ? const Color(0xff303F9F)
                                        : const Color(0xFFB7B7B7),
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                selected[3]!
                                    ? const Text(
                                        "Award",
                                        style: TextStyle(
                                          color: Color(0xff303F9F),
                                          fontFamily: 'Poppins',
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    : const Text(
                                        "",
                                      ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
