import 'dart:convert';

import 'package:blocproject/src/model/ResturantModel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var catergoryWiseData = Map<String, dynamic>();
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    dataCall();
  }

  Future<void> dataCall() async {
    var snapshot =
        await DefaultAssetBundle.of(context).loadString("Assets/sample.json");
    List<dynamic> restrodata = json.decode(snapshot.toString());
    print("resto data${restrodata}");
    restrodata.forEach((element) {
      var category = element['category'];
      if (this.categories.contains(category)) {
        List<ResturantModel> existingModelArray = catergoryWiseData[category];
        existingModelArray.add(ResturantModel.fromJson(element));
        catergoryWiseData[category] = existingModelArray;
      } else {
        List<ResturantModel> newModelArray = [];
        newModelArray.add(ResturantModel.fromJson(element));
        this.categories.add(category);
        catergoryWiseData[category] = newModelArray;
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            "Restaurant",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "Poppins",
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          child: ListView.builder(
              itemCount: categories.length,
              itemExtent: 200,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                var category = categories[i];
                List<ResturantModel> modelArray = catergoryWiseData[category];
                return ListView.builder(
                    itemCount: modelArray.length + 1,
                    itemExtent: 50,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, j) {
                      if (j == 0) {
                        return ListTile(
                            title: Text(
                          category,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: "Poppins",
                          ),
                        ));
                      }
                      var model = modelArray[j - 1];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                          height: 60,
                          child: ListTile(
                              title: Text(model.productName,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                  )),
                              trailing: Column(
                                children: [
                                  Text("Price",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey,
                                        fontFamily: "Poppins",
                                      )),
                                  Text("Rs. ${model.price.toString()}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                      ))
                                ],
                              )),
                        ),
                      );
                    });
              }),
        ));
  }
}
