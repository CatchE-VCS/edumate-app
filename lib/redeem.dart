import 'package:edumate/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

class Tshirt extends StatefulWidget {
  const Tshirt({Key? key}) : super(key: key);

  @override
  State<Tshirt> createState() => _TshirtState();
}

class _TshirtState extends State<Tshirt> {
  @override
  Widget build(BuildContext context) {
    // List of items in our dropdown menu
    const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
    String dropdownValue = list.first;

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
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          bottomNavigationBar: BottomNav(context: context),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios)),
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text("Redeem Page"),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: 311,
                  height: 187,
                  decoration: BoxDecoration(
                    color: Color(0xFF5D5392),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Column(children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Image.asset('assets/images/tshirt.png'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Programming T-Shirt"),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("1500"),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset('assets/images/coin.png')
                      ],
                    )
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(children: [
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline_rounded,
                            color: Colors.white),
                        fillColor: Colors.grey,
                        hintText: "Email/Mobile",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        labelText: 'Email/Mobile',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_on_outlined,
                            color: Colors.white),
                        fillColor: Colors.grey,
                        hintText: "Address Line 1",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        labelText: 'Address Line 1',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_on_outlined,
                            color: Colors.white),
                        fillColor: Colors.grey,
                        hintText: "Address Line 2",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        labelText: 'Address Line 2',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline_rounded,
                            color: Colors.white),
                        fillColor: Colors.grey,
                        hintText: "Email/Mobile",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        labelText: 'Email/Mobile',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon:
                            Icon(Icons.phone_outlined, color: Colors.white),
                        fillColor: Colors.grey,
                        hintText: "Phone Number",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ]),
                ),
                Text("Select Size"),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 25,
                  style: const TextStyle(color: Colors.white),
                  underline: Container(
                    height: 2,
                    color: Colors.white,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
