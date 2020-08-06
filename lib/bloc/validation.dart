import 'dart:async';

class Validation{

  //check if search query is empty
  final validateQuery = StreamTransformer<String,String>.fromHandlers(handleData: (value, sink){
    if(value.isEmpty){
      sink.add(null);
    }else {
      sink.add(value);
    }
  });

}