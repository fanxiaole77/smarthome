import 'dart:convert';
import 'dart:io';

import 'package:untitled3/service/http-config.dart';

Future post([String?url,Map<String,dynamic>?body,Map<String,dynamic>?query]) async{

  var uri = Uri.parse(url!);

  uri = uri.replace(queryParameters: query);

  final client = HttpClient();
  final request = await client.postUrl(uri);

  request.headers.add("content-type", "application/json");

  if(token != ""){
    request.headers.add(HttpHeaders.authorizationHeader, token);
  }

  if(body != null){
    request.write(json.encode(body));
  }


  final aa = await request.close();
  final bb = await aa.transform(utf8.decoder).join();
  return json.decode(bb);

}