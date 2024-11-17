import 'dart:convert';

import '../model/ticket_data_response.dart';
import 'package:http/http.dart'as http;

class TicketRepository{

  Future<List<TicketDataResponse>> getTicketData() async{
    final response=await http.get(Uri.parse("https://mocki.io/v1/2fb77337-aaec-412c-88d8-a44d74477d21"));

    var data=jsonDecode(response.body);

    List<TicketDataResponse> dataList=[];
    for(var d in data){
      dataList.add(TicketDataResponse.fromJson(d));
    }
    return dataList;
  }


}