import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskdemoproject/filter_demo/controller/ticket_controller.dart';
import 'package:taskdemoproject/filter_demo/model/ticket_data_response.dart';

class FilterController {
  final Rxn<RangeValues> priceRange = Rxn<RangeValues>();

  TicketController ticketController = Get.find();
  RxString classSelect = "".obs;
  RxString priceFilter = "".obs;
  RxString classType = "".obs;
  RxString priceSort = "".obs;

  RxList<String> companyNames = <String>[
    "Swift Travels",
    "Elite Journeys",
    "Budget Rides",
    "Express Lines",
    "Glide Transit"
  ].obs;

  RxList<String> selectedCompanies = <String>[].obs;
  RxList<bool> checkedStates = <bool>[].obs;

  void filterListOnClassType({required String classType}) {
    log('classtype ---- ${classType}');
    ticketController.filterTicketDataList.clear();
    for (TicketDataResponse ele in ticketController.ticketDataList) {
      if (ele.classType.name == classType) {
        ticketController.filterTicketDataList.add(ele);
      }
    }

    ticketController.filterTicketDataList.refresh();
    log('length ------ ${ticketController.filterTicketDataList.length}');
  }

  void filterListOnPriceLowToHigh({required String task}) {
    if (task == 'lowToHigh') {
      ticketController.filterTicketDataList.sort(
        (a, b) => a.price.compareTo(b.price),
      );
    } else if (task == 'highToLow') {
      ticketController.filterTicketDataList.sort(
        (a, b) => b.price.compareTo(a.price),
      );
    } else {}

    ticketController.filterTicketDataList.refresh();
  }

  void filterListOnPriceRange() {
    ticketController.filterTicketDataList.clear();

    List<TicketDataResponse> tempList = [];

    if (priceRange.value != null) {
      tempList = ticketController.ticketDataList
          .where((data) =>
              (data.price >= priceRange.value!.start) &&
              (data.price <= priceRange.value!.end))
          .toList();
    }

    ticketController.filterTicketDataList.addAll(tempList);
  }

  void filterOnSelectedCompanies() {
    ticketController.filterTicketDataList.clear();
    for (String selectedCompanies in selectedCompanies) {
      for (TicketDataResponse ele in ticketController.ticketDataList) {
        if (ele.companyName == selectedCompanies) {
          ticketController.filterTicketDataList.add(ele);
        }
      }
    }
  }

  void applyCombinedFilters() {
    ticketController.filterTicketDataList.clear();
    log("=======>>>>  if (priceRange");

    // Start with the full list
    List<TicketDataResponse> filteredList =
        List.from(ticketController.ticketDataList);

    // Apply filters conditionally

    // Filter by class type only if selected
    if (classSelect.value.isNotEmpty) {
      log("=======>>>>  if (classSelect");

      filteredList = filteredList
          .where((ticket) => ticket.classType.name == classSelect.value)
          .toList();
    }

    if (priceRange.value != null) {
      // Filter by price range only if the range is explicitly set
      if (priceRange.value!.start != 0.0 || priceRange.value!.end != 1.0) {
        log("=======>>>>  if (priceRange");
        filteredList = filteredList
            .where((ticket) =>
                ticket.price >= priceRange.value!.start &&
                ticket.price <= priceRange.value!.end)
            .toList();
      }
    }

    if (selectedCompanies.isNotEmpty) {
      log("=======>>>>  if (selectedCompanies");

      filteredList = filteredList
          .where((ticket) => selectedCompanies.contains(ticket.companyName))
          .toList();
    }
    if (priceSort.value == 'lowToHigh') {
      filteredList.sort((a, b) => a.price.compareTo(b.price));
    } else if (priceSort.value == 'highToLow') {
      filteredList.sort((a, b) => b.price.compareTo(a.price));
    }
    ticketController.filterTicketDataList.addAll(filteredList);
    ticketController.filterTicketDataList.refresh();

    log('Filtered List Count: ${ticketController.filterTicketDataList.length}');
  }
}
