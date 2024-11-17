import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskdemoproject/filter_demo/repository/ticket_repository.dart';

import '../model/ticket_data_response.dart';

class TicketController extends GetxController {
  RxList<TicketDataResponse> ticketDataList = <TicketDataResponse>[].obs;
  RxList<TicketDataResponse> filterTicketDataList = <TicketDataResponse>[].obs;
  TicketRepository ticketRepository = TicketRepository();

  Future getDataAPiCall() async {
    try {
      ticketDataList.value = await ticketRepository.getTicketData();
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getDataAPiCall();
      filterTicketDataList.clear();
      filterTicketDataList.addAll(ticketDataList);
      filterTicketDataList.refresh();
    });
    super.onInit();
  }
}
