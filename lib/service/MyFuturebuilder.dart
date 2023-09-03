import 'package:flutter/cupertino.dart';

class MyFutureBilder<T> extends FutureBuilder{
  MyFutureBilder({
    key,
    required Future future,
    required List<dynamic> success,
    required List<dynamic> fail,
    T?iniitialData,
    required Widget Function() builder,
    required isRequest,
}) : super(
    future: future,
    initialData: iniitialData,
    builder: (context, snapshot) {
      if(snapshot.connectionState != ConnectionState.done ||! snapshot.hasData){
        return Center(child: Text("加载中"),);
      }
      if(isRequest){
        List<dynamic> data = snapshot.data;
        success.clear();
        fail.clear();
        success.addAll(data.where((element) => element["code"] == 200).toList());
        fail.addAll(data.where((element) => element["code"] == 200).toList());
      }
      return builder();
    },
  );

}