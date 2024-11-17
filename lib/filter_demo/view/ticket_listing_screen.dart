import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../user_data/widget/common_text_widget.dart';
import '../controller/ticket_controller.dart';
import '../model/ticket_data_response.dart';
import 'filter_screen_view.dart';

class TicktListingScreen extends StatelessWidget {
  TicktListingScreen({Key? key}) : super(key: key);

  final TicketController controller = Get.put(TicketController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const CommonText(
          text: "Tickets Data",
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          Obx(() {
            return Text(
              controller.filterTicketDataList.length.toString(),
              style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w700),
            );
          }),
          IconButton(
              onPressed: () {
                Get.to(FilterScreen());
              },
              icon: const Icon(
                Icons.sort,
                color: Colors.white,
              )),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.filterTicketDataList.length,
          itemBuilder: (context, index) {
            TicketDataResponse ticket = controller.filterTicketDataList[index];

            return Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey.shade100),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText(
                        text: ticket.companyName,
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      CommonText(
                        text: "${ticket.remainingDays} seat remaining",
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText(
                        text: ticket.startTime,
                        color: Colors.indigo,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      const Icon(Icons.arrow_right_alt_sharp),
                      CommonText(
                        text: ticket.endTime,
                        color: Colors.indigo,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText(
                        text: ticket.startingDate,
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      const Icon(Icons.bus_alert_rounded),
                      CommonText(
                        text: ticket.destinationDate,
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonText(
                        text: ticket.duration,
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CommonText(
                        text: ticket.price.toString(),
                        color: Colors.green.shade800,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CommonText(
                        text: ticket.classType.name,
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
