
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled3/page/IndexPage.dart';
import 'package:untitled3/service/http-config.dart';
import 'package:untitled3/service/http-service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final username = TextEditingController();
  final password = TextEditingController();

  void Login(){
    post(
      postLogo,
      {"username":username.text,"password":password.text},
      null
    ).then((value){
      if(value["code"] == 200){
        token = value["data"]["token"];
        final toast = SnackBar(content: Text(value["msg"]),duration: Duration(seconds: 3),backgroundColor: Colors.grey,behavior: SnackBarBehavior.fixed,);
        ScaffoldMessenger.of(context).showSnackBar(toast);
        Navigator.push(context, MaterialPageRoute(builder: (context) => IndexPage(),));
      }else{
        final toast = SnackBar(content: Text(value["msg"]),duration: Duration(seconds: 3),backgroundColor: Colors.grey,behavior: SnackBarBehavior.fixed,);
        ScaffoldMessenger.of(context).showSnackBar(toast);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Sign in"),centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/logo.png",fit: BoxFit.fill,width: 100,),
            SizedBox(height: 20,),
            Container(
              width: 270,
              height: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Username"),
                  Container(
                    width: 270,
                    height: 40,
                    child: TextField(
                      controller: username,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(16),
                        WhitelistingTextInputFormatter(
                          RegExp('[a-zA-Z0-9]')
                        ),
                      ],
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_circle_rounded),
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
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: 270,
              height: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Password"),
                  Container(
                    width: 270,
                    height: 40,
                    child: TextField(
                      controller: password,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(16),
                        WhitelistingTextInputFormatter(
                          RegExp('[a-zA-Z0-9]')
                        ),
                      ],
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: (){
                            password.clear();
                          },
                          child: Icon(Icons.clear),
                        ),
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
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: 270,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Forgost Password?"),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: 270,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: (){Login();}, child: Text("Sign in")),
                  ElevatedButton(onPressed: (){}, child: Text("Sign up")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
