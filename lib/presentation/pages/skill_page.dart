import 'package:flutter/material.dart';

class SkillScreen extends StatefulWidget {
  const SkillScreen({super.key});

  @override
  State<SkillScreen> createState() => _SkillScreenState();
}

class _SkillScreenState extends State<SkillScreen> {
  String dropdownValue = 'Dog';
  bool _cont = false;
  TextEditingController query = TextEditingController();


  List<String> matchQuery = [];
  List<String> searchTerms = [
    "Flutter",
    "Figma",
    "Django",
    "SQL",
    "HTML",
    "CSS",
    "JavaScript",
    "React",
    "Vue.js",
    "Node.js",
    "Java",
    "Python",
    "C#",
    "C++",
    "Ruby",
    "Swift",
    "Objective-C",
    "Git",
    "Linux",
    "Amazon Web Services (AWS)",
    "Microsoft Azure",
    "Google Cloud Platform (GCP)",
    "Kubernetes",
    "Docker",
  ];

  void formSuggestions() {
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toString().toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _cont = false;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff30547c),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                  boxShadow: kElevationToShadow[8],
                  color: const Color(0xff30547c),
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    child: Text(
                      "What skills do you currently have ?",
                      style: TextStyle(fontSize: 35, color: Colors.white),
                    ),
                  ),
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 36, right: 36, top: 20),
                      child: Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: kElevationToShadow[8],
                        ),
                        child:  Padding(
                          padding:  EdgeInsets.all(3.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "",
                              label: Text("Search skill or domain"),
                              prefixIcon: Icon(Icons.search, color: Colors.black87,)
                            ),
                            textInputAction: TextInputAction.go,
                            onChanged: (value) {
                              setState(() {
                                _cont = true;
                                formSuggestions();
                              });
                            },
                          ),
                        ),
                      )
                  ),
                  _cont ? Container(
                    height: 150,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(

                      children: [
                        ListView.builder(
                            itemCount: matchQuery.length,
                            itemBuilder: (context, index) {
                              var result = matchQuery[index];
                              return ListTile(
                                title: Text(result,
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ) : SizedBox(height: 0,)
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.46,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Don't have any skills yet ?",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.black
                    ),
                  ),
                  Text(
                    "Don’t worry let’s explore\nyour interests !!",
                    style: TextStyle(fontSize: 17, color: Colors.grey),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class CustomSearchDelegate extends SearchDelegate {
//
//
//
//
// // Demo list to show querying
//   List<String> searchTerms = [
//     "Flutter",
//     "Figma",
//     "Django",
//     "SQL",
//     "HTML",
//     "CSS",
//     "JavaScript",
//     "React",
//     "Vue.js",
//     "Node.js",
//     "Java",
//     "Python",
//     "C#",
//     "C++",
//     "Ruby",
//     "Swift",
//     "Objective-C",
//     "Git",
//     "Linux",
//     "Amazon Web Services (AWS)",
//     "Microsoft Azure",
//     "Google Cloud Platform (GCP)",
//     "Kubernetes",
//     "Docker",
//   ];
//
// // first overwrite to
// // clear the search text
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = '';
//         },
//         icon: const Icon(Icons.clear),
//       ),
//     ];
//   }
//
// // second overwrite to pop out of search menu
//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, null);
//       },
//       icon: Icon(Icons.arrow_back),
//     );
//   }
//
// // third overwrite to show query result
//   @override
//   Widget buildResults(BuildContext context) {
//     List<String> matchQuery = [];
//     for (var fruit in searchTerms) {
//       if (fruit.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(fruit);
//       }
//     }
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context, index) {
//         var result = matchQuery[index];
//         return ListTile(
//           title: Text(result,
//             style: TextStyle(color: Colors.black),
//           ),
//         );
//       },
//     );
//   }
//
// // last overwrite to show the
// // querying process at the runtime
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> matchQuery = [];
//     for (var fruit in searchTerms) {
//       if (fruit.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(fruit);
//       }
//     }
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context, index) {
//         var result = matchQuery[index];
//         return ListTile(
//           title: Text(result, style: const TextStyle(color: Colors.black),),
//         );
//       },
//     );
//   }
// }
