import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled3/page/HouseManagementPage.dart';
import 'package:untitled3/service/MyFuturebuilder.dart';
import 'package:untitled3/service/http-config.dart';
import 'package:untitled3/service/http-service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  List aa =[];
  bool bb = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile"),centerTitle: true,
      leading:TextButton(onPressed: (){}, child: Text("back",style: TextStyle(color: Colors.white),)),
      actions: [
        TextButton(onPressed: (){
          SystemNavigator.pop();
        }, child: Text("Sign out",style: TextStyle(color: Colors.white),)),
      ],),
      body: MyFutureBilder(
          future: Future.wait([
            post(postAccountInfo)
          ]),
          success: aa,
          fail: [],
          builder: (){
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(backgroundImage: NetworkImage("$base_url/${aa[0]["data"]["avatar"]}"),radius: 50,),
                  SizedBox(height: 20,),
                  Text("${aa[0]["data"]["nick_name"]}"),
                  Text("${aa[0]["data"]["signature"]}"),
                  SizedBox(height: 20,),
                  Container(
                    width: 270,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Number of house            1")
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: 270,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HouseManagementPage(),));
                        }, child: Text("House Management",style: TextStyle(color: Colors.black),))
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: 270,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: Colors.black
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home),
                        TextButton(onPressed: (){}, child: Text("clear cache",style: TextStyle(color: Colors.black),))
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: 270,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: Colors.black
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home),
                        TextButton(onPressed: (){}, child: Text("About",style: TextStyle(color: Colors.black),))
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          isRequest: bb
      )
    );
  }
}
