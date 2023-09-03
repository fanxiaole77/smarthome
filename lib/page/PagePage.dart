import 'package:flutter/material.dart';
import 'package:untitled3/page/LoginPage.dart';

class PagePage extends StatefulWidget {
  const PagePage({Key? key}) : super(key: key);

  @override
  _PagePageState createState() => _PagePageState();
}

class _PagePageState extends State<PagePage> {

  final PageController _pageController = PageController();

  int _currentIndex = 0;

  void onPage(index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _jiemian = [
      Container(child: Image.asset("images/tu1.jpg",fit: BoxFit.fill,)),
      Container(child: Image.asset("images/tu2.jpg",fit: BoxFit.fill,)),
      Container(child: Stack(
        children: [
          Image.asset("images/tu3.jpg",fit: BoxFit.fill,width: double.infinity,height: double.infinity,),
          Positioned(
            left: 50,
            right: 50,
            bottom: 70,
            child: ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
            }, child: Text("Start")),
          )
        ],
      )),
    ];
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: Stack(
                children: [
                  PageView(
                    controller: _pageController,
                    onPageChanged: onPage,
                    children: _jiemian,
                  ),
                  Positioned(
                    left: 10,
                    right: 10,
                    bottom: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_jiemian.length, (index) => Container(
                        width: 10,
                        height: 10,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:  _currentIndex == index
                            ?Colors.red
                              :Colors.green
                        ),
                      )),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            Image.asset("images/logo.png",fit: BoxFit.fill,width: 100,)
          ],
        )
      ),
    );
  }
}
