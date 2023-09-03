import 'package:flutter/material.dart';
import 'package:untitled3/service/MyFuturebuilder.dart';
import 'package:untitled3/service/http-config.dart';
import 'package:untitled3/service/http-service.dart';

class ConditioningPage extends StatefulWidget {

  final String cardid;
  final String did;
  final String funid;

  const ConditioningPage({required this.cardid,required this.did,required this.funid,Key? key}) : super(key: key);

  @override
  _ConditioningPageState createState() => _ConditioningPageState(cardid,did,funid);
}

class _ConditioningPageState extends State<ConditioningPage> {

  final String cardid;
  final String did;
  final String funid;
  _ConditioningPageState(this.cardid,this.did,this.funid);


  List aa =[];
  bool bb = true;


  int Mode = 1601;
  int Mode1 = 1801;
  int Mode2 = 2001;

  int _currentIndex = 0;
  int _currentIndex1 = 0;

  void moshi(int sep){
    post(postRunActions,{"cardid":cardid,"parms":[{"funid":Mode,"seq":sep}]}).then((value){
      print(value["msg"]);
    });
  }

  void fengsu(int sep){
    post(postRunActions,{"cardid":cardid,"parms":[{"funid":Mode1,"seq":sep}]}).then((value){
      print(value["msg"]);
    });
  }

  void wendu(int sep){
    post(postRunActions,{"cardid":cardid,"parms":[{"funid":Mode2,"seq":sep}]}).then((value){
      print(value["msg"]);
    });
  }


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
              appBar: AppBar(title: Text("Air Conditioning"),
                centerTitle: true,
                leading: TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("back",style: TextStyle(color: Colors.white),)),
                actions: [
                  TextButton(onPressed: (){}, child: Text("History",style: TextStyle(color: Colors.white),))
                ],
              ),
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 300,
                      height: 180,
                      color: Colors.grey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${aa[0]["data"]["functions"][4]["val"]}",style: TextStyle(fontSize: 30),),
                          SizedBox(height: 100,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Mode：${_currentIndex == 0?"关闭":_currentIndex == 1 ? "制冷":_currentIndex == 2 ? "制热":_currentIndex == 3?"除湿":""}"),
                              Text("Speed：${aa[0]["data"]["functions"][2]["val"]}"),
                            ],)
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 200,
                      height: 350,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              ElevatedButton(onPressed: (){
                                setState(() {
                                  aa[0]["data"]["functions"][4]["val"] += 1;
                                  if(aa[0]["data"]["functions"][4]["val"] > 30){
                                    aa[0]["data"]["functions"][4]["val"] = 30;
                                  }
                                  wendu(aa[0]["data"]["functions"][4]["val"]);
                                });
                              }, child: Text("+")),
                              ElevatedButton(onPressed: (){
                                setState(() {
                                  aa[0]["data"]["functions"][4]["val"] -= 1;
                                  if(aa[0]["data"]["functions"][4]["val"] < 16){
                                    aa[0]["data"]["functions"][4]["val"] = 16;
                                  }
                                  wendu(aa[0]["data"]["functions"][4]["val"]);
                                });
                              }, child: Text("-")),
                            ],
                          ),
                          Column(
                            children: [
                              ElevatedButton(onPressed: (){
                                setState(() {
                                  _currentIndex = (_currentIndex + 1) % 4;
                                  moshi(_currentIndex);
                                });
                              }, child: Text("Mode")),
                              ElevatedButton(onPressed: (){
                                setState(() {
                                  _currentIndex1 = (_currentIndex1 + 1)%2;
                                  fengsu(_currentIndex1);
                                });
                              }, child: Text("speed")),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
          );
        },
        isRequest: bb
    );
  }
}
