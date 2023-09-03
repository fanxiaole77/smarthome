import 'package:flutter/material.dart';
import 'package:untitled3/page/ConditioningPage.dart';
import 'package:untitled3/page/LightPage.dart';
import 'package:untitled3/service/MyFuturebuilder.dart';
import 'package:untitled3/service/http-config.dart';
import 'package:untitled3/service/http-service.dart';

int selectedValue = 0;


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List aa =[];
  bool bb = true;
  bool isVisible = true;

  void _show(context,List data){
    showModalBottomSheet(context: context, builder:(context){
      return Container(
        child: Padding(padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return RadioListTile(
                    value: index,
                    title: Text(data[index]["name"]),
                    groupValue: selectedValue,
                    onChanged: (int ?value){
                      setState(() {
                        selectedValue = value!;
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              )
            ],
          ),),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home",),centerTitle: true,leading: TextButton(onPressed: (){
        Navigator.pop(context);
      }, child: Text("back",style: TextStyle(color: Colors.white),)),
        actions: [TextButton(onPressed: (){
          _show(context,aa[0]["data"]);
        }, child: Text("switch house",style: TextStyle(color: Colors.white)))],),
      body: MyFutureBilder(
          future:Future.wait([
            post(postListUserAllHouses)
          ]),
          success: aa,
          fail: [],
          builder: (){
            if((aa[0]["data"] as List).length == 0){
              isVisible = true;
            }else{
              isVisible = false;
            }
            return ListView(

              children: [
                if(isVisible)Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,child: Column(
                  children: [
                    Text("No house")
                  ],
                ),)
                else ListView(
                  shrinkWrap:true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    fangwu(homelist: aa[0]["data"]),
                    zxiang(zixiangList: aa[0]["data"],)
                  ],
                )
              ],
            );
          },
          isRequest: bb
      ),

    );
  }
}
class fangwu extends StatefulWidget {
  final List homelist;
  const fangwu({required this.homelist});

  @override
  _fangwuState createState() => _fangwuState(homelist);
}

class _fangwuState extends State<fangwu> {
  final List homelist;
  _fangwuState(this.homelist);
  @override
  Widget build(BuildContext context) {
    // print(homelist[0]["image"]);
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 180,
        decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: Colors.black
          ),
        ),
        child:  Stack(
          children: [
            Image.network("$base_url/${homelist[0]["space"][0]["image"]}",fit: BoxFit.fill,height: double.infinity,),
            Container(width: MediaQuery.of(context).size.width,height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Living room",style:TextStyle(color: Colors.white),),
                  Text("${homelist[0]["space"][0]["device_count"]}    devices",style:TextStyle(color: Colors.white),)
                ],
              ),),
            Positioned(bottom:0,child:  Container(width: MediaQuery.of(context).size.width,height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Temperature:${homelist[0]["space"][0]["temperature"]}°C",style:TextStyle(color: Colors.white),),
                  Text("humidity:${homelist[0]["space"][0]["humidity"]}%rh",style:TextStyle(color: Colors.white),),
                  Text("ligth:${homelist[0]["space"][0]["luminosity"]}",style:TextStyle(color: Colors.white),),
                ],
              ),))
          ],
        )
    );
  }
}

class zxiang extends StatefulWidget {

  final List zixiangList;
  const zxiang({required this.zixiangList,Key? key}) : super(key: key);

  @override
  _zxiangState createState() => _zxiangState(zixiangList);
}

class _zxiangState extends State<zxiang> {
  final List zixiangList;
  _zxiangState(this.zixiangList);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2.0,crossAxisSpacing: 1.5),
      itemCount: zixiangList[0]["space"][0]["device_count"],
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context,index){
        return _item(context, index);
      },
    );
  }
  Widget _item(context,index){
    return InkWell(
      onTap: (){
        if(zixiangList[selectedValue]["space"][0]["device"][index]["function"][0]["device_type"] == 1){
          Navigator.push(context,MaterialPageRoute(builder: (context) => LightPage(
            cardid:zixiangList[selectedValue]["main_card_id"].toString(),
            did:zixiangList[selectedValue]["space"][0]["device"][index]["d_id"].toString(),
            funid:zixiangList[selectedValue]["space"][0]["device"][index]["function"][0]["id"].toString(),
          ),));
        }
        if(zixiangList[selectedValue]["space"][0]["device"][index]["function"][0]["device_type"] == 5){
          Navigator.push(context,MaterialPageRoute(builder: (context) => ConditioningPage(
            cardid:zixiangList[selectedValue]["main_card_id"].toString(),
            did:zixiangList[selectedValue]["space"][0]["device"][index]["d_id"].toString(),
            funid:zixiangList[selectedValue]["space"][0]["device"][index]["function"][0]["id"].toString(),
          ),));
        }
      },
      child: Container(
        width:  150,
        height: 75,
        child: Card(
          child: Column(
            children: [
              Container(
                width: 150,
                height: 50,
                child: Image.network("$base_url/${zixiangList[selectedValue]["space"][0]["device"][index]["icon"]}",fit: BoxFit.fill,),
              ),
              Text("${zixiangList[selectedValue]["space"][0]["device"][index]["device_name"]}"),
              if(zixiangList[selectedValue]["space"][0]["device"][index]["function"][0]["device_type"] == 1)
                Text("开关状态：关")
            ],
          ),
        ),
      ),
    );
  }
}