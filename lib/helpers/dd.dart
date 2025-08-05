
import 'package:edumate/helpers/contest_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetPage extends StatefulWidget {
  const GetPage({super.key});

  @override
  State<GetPage> createState() => _GetPageState();
}

// Removed unused _userModel variable

class _GetPageState extends State<GetPage> {
  Future<List<NewsModel>> getData() async {
    http.Response response =
        await http.get(Uri.parse('https://kontests.net/api/v1/all'));
    if (response.statusCode == 200) {
      String data = response.body;
      // print(response.body);
      // Debug: print(jsonDecode(data));
      return newsModelFromJson(data);
    } else {
      // Error: Status ${response.statusCode}, Body: ${response.body}
      return [];
    }
  }

  // void _getData() async {
  //   _userModel = await getData();
  //   Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _getData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getData(),
            builder: (context, AsyncSnapshot<List<NewsModel>> snapshot) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(snapshot.data![index].name.toString()),
                              Text(
                                snapshot.data![index].url,
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(snapshot.data![index].duration.toString()),
                              Text(snapshot.data![index].site.toString()),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            }));
  }
}
