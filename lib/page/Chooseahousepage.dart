

import 'package:flutter/material.dart';
import 'package:untitled3/page/CommintPage.dart';
import 'package:untitled3/service/MyFuturebuilder.dart';
import 'package:untitled3/service/http-config.dart';
import 'package:untitled3/service/http-service.dart';
var bl = 0;

class Chooseahousepage extends StatefulWidget {
  const Chooseahousepage({Key? key}) : super(key: key);

  @override
  _ChooseahousepageState createState() => _ChooseahousepageState();
}

class _ChooseahousepageState extends State<Chooseahousepage> {

  List aa = [];
  bool bb = true;

  @override
  Widget build(BuildContext context) {
    return MyFutureBilder(
        future: Future.wait([
          post(postListAllSysHouse)
        ]),
        success: aa,
        fail: [],
        builder: (){
          return Scaffold(
            appBar: AppBar(
              title: Text("Choose a house"),centerTitle: true,
              leading: TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("back",style: TextStyle(color: Colors.white),),),
              actions: [TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CommintPage(Itemid:aa[0]["data"][bl]["id"].toString()),));
              }, child: Text("next",style: TextStyle(color: Colors.white),),),],
            ),
            body: Row(
              children: [
                SizedBox(
                  width: 100,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: (aa[0]["data"] as List).length,
                    itemBuilder: (context, index) {
                      return _Item(context, index);
                    },
                  ),
                ),
                Container(
                  width: 1,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black,
                ),
                Expanded(child:
                 ListView.builder(
                   itemCount: (aa[0]["data"][bl]["space"] as List).length,
                   itemBuilder: (context, index) {
                     return _item1(context,index,aa[0]["data"][bl]["space"] as List);
                   },
                 ),)
              ],
            ),
          );
        },
        isRequest: bb
    );
  }
  Widget _Item(context,index){
    return InkWell(
      onTap: (){
        setState(() {
          bl = index;
        });
      },
      child: Container(
          width: 100,
          height: 40,
          child:Text(aa[0]["data"][index]["name"])
      )
    );
  }
  Widget _item1(context,index,data){
    return Column(
        children: [
          Text(data[index]["name"]),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: (data[index]["device"] as List).length,
            itemBuilder: (context, index1) {
              return Column(
                children: [
                  Image.network("$base_url/${data[index]["device"][index1]["icon"]}",fit: BoxFit.fill,width: 50,height: 50,),
                  Text(data[index]["device"][index1]["device_name"],),
                ],
              );
            },
          )
        ]
    );
  }
}
