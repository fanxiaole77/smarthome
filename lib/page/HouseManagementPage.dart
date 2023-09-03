
import 'package:flutter/material.dart';
import 'package:untitled3/page/Chooseahousepage.dart';
import 'package:untitled3/service/MyFuturebuilder.dart';
import 'package:untitled3/service/http-config.dart';
import 'package:untitled3/service/http-service.dart';

class HouseManagementPage extends StatefulWidget {
  const HouseManagementPage({Key? key}) : super(key: key);

  @override
  _HouseManagementPageState createState() => _HouseManagementPageState();
}

class _HouseManagementPageState extends State<HouseManagementPage> {

  List aa = [];
  bool bb = true;
  bool isbool = true;

  void show(context,name,id){
    showDialog(context: context, builder:(context){
      return AlertDialog(
        title: Text("Delte House"),
        content: Text("Delete House Name:$name"),
        actions: [
          TextButton(onPressed: (){
            post(postRemoveUserHouse,{"houseid":id}).then((value) {
              setState(() {
              });
              print(value["msg"]);
            });
            Navigator.pop(context);
          }, child: Text("Delte")),
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Cnacel")),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("House Management"),
        centerTitle:  true,
        leading: TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("back",style: TextStyle(color: Colors.white),)),
      ),
      body: MyFutureBilder(
          future: Future.wait([
            post(
              postListUserAllHouses
            )
          ]),
          success: aa,
          fail: [],
          builder: (){
            if((aa[0]["data"]as List).length == 0){
              isbool  = true;
            }else{
              isbool = false;
            }
            return ListView(
              children: [
                if(isbool) Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No House"),
                    Text("Click the button below to add a house"),
                  ],
                ),)
                else ListView.builder(
                  shrinkWrap: true,
                    physics:NeverScrollableScrollPhysics(),
                    itemCount: (aa[0]["data"] as List).length,
                    itemBuilder: (context, index) {
                      return _item(context, index);
                    },
                ),
              ],
            );
          },
          isRequest: bb
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Chooseahousepage(),));
        }, icon: Icon(Icons.add)),
      ),
    );
  }
  Widget _item(context,index){
    return Container(
      width: MediaQuery.of(context).size.width,
      height:50,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(aa[0]["data"][index]["name"].toString()),
          IconButton(onPressed: (){
            show(context, aa[0]["data"][index]["name"], aa[0]["data"][index]["id"]);
          }, icon: Icon(Icons.clear))
        ],
      ),
    );
  }
}
