import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:untitled3/page/HouseManagementPage.dart';
import 'package:untitled3/service/http-config.dart';
import 'package:untitled3/service/http-service.dart';

class CommintPage extends StatefulWidget {

  final String Itemid;

  const CommintPage({required this.Itemid,Key? key}) : super(key: key);

  @override
  _CommintPageState createState() => _CommintPageState(Itemid);
}

class _CommintPageState extends State<CommintPage> {

  final String Itemid;
  _CommintPageState(this.Itemid);

  final name = TextEditingController();
  final cardid = TextEditingController();

  void coomint(){
    post(
      postAddUserHouse,
      {"houseid":int.parse(Itemid),"housename":name.text,"maincardid":cardid.text},
      null
    ).then((value){
      if(value["code"]== 200){
        print(value["msg"]);
        Navigator.push(context, MaterialPageRoute(builder: (context) => HouseManagementPage(),));
      }else{
        print(value["msg"]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    String house;
    if(Itemid == "1"){
      house = "三室两厅";
    }else{
      house = "两室小居";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Choose a house"),centerTitle: true,
        leading: TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("back",style: TextStyle(color: Colors.white),),),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Select house template",style: TextStyle(fontSize: 20),),
            Text("$house",style: TextStyle(fontSize: 20),),
            SizedBox(height:20,),
            Text("Plase enter the name of the house:"),
            Container(
              width: 270,
              height: 40,
              child: TextField(
                controller: name,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(8),
                  WhitelistingTextInputFormatter(
                      RegExp('[a-zA-Z0-9]')
                  ),
                ],
                decoration: InputDecoration(
                  hintText: "input house name",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.black
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.black
                      ),
                      borderRadius: BorderRadius.circular(20),
                    )
                ),
              ),
            ),

            SizedBox(height:20,),
            Text("Plase enter main_card_id:"),
            Container(
              width: 270,
              height: 40,
              child: TextField(
                controller: cardid,
                decoration: InputDecoration(
                    hintText: "input main_card_id",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.black
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.black
                      ),
                      borderRadius: BorderRadius.circular(20),
                    )
                ),
              ),
            ),

            SizedBox(height:20,),
            Container(
              width: 270,
              height: 40,
              child: ElevatedButton(onPressed: (){
                coomint();
              }, child: Text("Commint"))
            ),

          ],
        ),
      ),
    );
  }
}
