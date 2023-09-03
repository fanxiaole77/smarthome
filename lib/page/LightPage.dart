import 'package:flutter/material.dart';
import 'package:untitled3/service/MyFuturebuilder.dart';
import 'package:untitled3/service/http-config.dart';
import 'package:untitled3/service/http-service.dart';


class LightPage extends StatefulWidget {

  final String cardid;
  final String did;
  final String funid;


  const LightPage({required this.cardid,required this.did,required this.funid,Key? key}) : super(key: key);

  @override
  _LightPageState createState() => _LightPageState(cardid,did,funid);

}

class _LightPageState extends State<LightPage> {
  String cardid;
  String did;
  String funid;

  List aa = [];
  bool bb =true;

  void kai(seq){
    post(
        postRunActions,
        {"cardid":cardid,"parms":[{"funid":int.parse(funid),"seq":seq}]}
    ).then((value){

      print("${value["data"][0]["seq"]}");
    });
  }


  _LightPageState(this.cardid,this.did,this.funid);
  @override
  Widget build(BuildContext context) {

    return MyFutureBilder(
        future: Future.wait([
          post(postSerachDeviceState,{"cardid":cardid,"d_id":int.parse(did)},null)
        ]),
        success: aa,
        fail: [],
        builder: (){
          return Scaffold(
            appBar: AppBar(title: Text("Light"),centerTitle: true,leading: TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("back",style: TextStyle(color: Colors.white),)),
              actions: [
                TextButton(onPressed: (){}, child: Text("History",style: TextStyle(color: Colors.white),))
              ],),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(aa[0]["data"]["functions"][0]["val"] == 1)
                    Column(children: [
                      CircleAvatar(backgroundImage: AssetImage("images/light.png"), radius: 50,),
                      SizedBox(height: 150,),
                      Container(width: 200,height: 40,child: ElevatedButton(onPressed: (){
                        setState(() {
                          kai(0);
                        });
                      }, child: Text("OFF")),)
                    ],)
                  else
                    Column(children: [
                      CircleAvatar(backgroundColor: Colors.yellow, radius: 50,),
                      CircleAvatar(backgroundImage: AssetImage("images/light.png"), radius: 50,),
                      SizedBox(height: 150,),
                      Container(width: 200,height: 40,child: ElevatedButton(onPressed: (){
                        setState(() {
                          kai(1);
                        });
                      }, child: Text("ON")),)
                    ],)
                ],
              ),
            ),
          );
        },
        isRequest: bb
    );
  }
}
