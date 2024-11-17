import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskdemoproject/filter_demo/controller/filter_controller.dart';

import '../../user_data/widget/common_text_widget.dart';

class FilterScreen extends StatefulWidget {
  FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  FilterController controller = Get.put(FilterController());

  @override
  void dispose() {
    Get.delete<FilterController>();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.checkedStates =
        RxList<bool>.filled(controller.companyNames.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const CommonText(
          text: "Filter screen",
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommonText(
                text: "Class Type :-",
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              Obx(
                () => Column(
                  children: [
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: const CommonText(
                        text: "Vip",
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      leading: Radio<String>(
                        value: "vip",
                        groupValue: controller.classSelect.value,
                        onChanged: (value) {
                          controller.classType.value = value ?? '';
                          controller.classType.refresh();
                          controller.classSelect.value = value!;
                          // controller.filterListOnClassType(
                          //     classType: controller.classType.value);
                        },
                      ),
                    ),
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: const CommonText(
                        text: "Standard",
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      leading: Radio<String>(
                        value: "standard",
                        groupValue: controller.classSelect.value,
                        onChanged: (value) {
                          controller.classType.value = value ?? '';
                          controller.classType.refresh();
                          controller.classSelect.value = value!;
                          // controller.filterListOnClassType(
                          //     classType: controller.classType.value);
                          log('message ----- $value');
                        },
                      ),
                    ),
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: CommonText(
                        text: "Local",
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      leading: Radio<String>(
                        value: "local",
                        groupValue: controller.classSelect.value,
                        onChanged: (value) {
                          controller.classType.value = value ?? '';
                          controller.classType.refresh();
                          controller.classSelect.value = value!;
                          // controller.filterListOnClassType(
                          //     classType: controller.classType.value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              CommonText(
                text: "Price :-",
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              Obx(
                () => RangeSlider(
                  min: 0,
                  max: 300,
                  divisions: 20,
                  values: controller.priceRange.value ?? RangeValues(0, 0),
                  labels: RangeLabels(
                      '${controller.priceRange.value?.start ?? 0}',
                      '${controller.priceRange.value?.end ?? 0}'),
                  onChanged: (value) {
                    controller.priceRange.value = value;

                    // controller.filterListOnPriceRange();

                    print("valueee=====4$value");
                  },
                ),
              ),
              Obx(() {
                return Text(
                  'Price :- ${controller.priceRange.value?.start} to ${controller.priceRange.value?.end}',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                );
              }),
              SizedBox(
                height: 20,
              ),
              CommonText(
                text: "Price Type :-",
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              Obx(
                () => Column(
                  children: [
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: CommonText(
                        text: "Low to High",
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      leading: Radio<String>(
                        value: "lowToHigh",
                        groupValue: controller.priceFilter.value,
                        onChanged: (value) {
                          controller.priceFilter.value = value!;
                          controller.priceSort.value = value ?? '';
                          // controller.filterListOnPriceLowToHigh(task:controller.priceSort.value);
                        },
                      ),
                    ),
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: CommonText(
                        text: "High to Low",
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      leading: Radio<String>(
                        value: "highToLow",
                        groupValue: controller.priceFilter.value,
                        onChanged: (value) {
                          controller.priceFilter.value = value!;
                          controller.priceSort.value = value ?? '';
                          // controller.filterListOnPriceLowToHigh(task:controller.priceSort.value);
                        },
                      ),
                    ),
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: CommonText(
                        text: "None",
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      leading: Radio<String>(
                        value: "None",
                        groupValue: controller.priceFilter.value,
                        onChanged: (value) {
                          controller.priceFilter.value = value!;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              /*   CommonText(
                text: "Time Selection :-",
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              Obx(
                () => RangeSlider(
                  values: controller.priceRange.value,
                  onChanged: (value) {
                    controller.priceRange.value = value;
                    print("valueee=====4$value");
                  },
                ),
              ),*/
              SizedBox(
                height: 20,
              ),
              CommonText(
                text: "Company Selection :-",
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              Obx(() {
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.companyNames.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        title: Text(controller.companyNames[index]),
                        value: controller.checkedStates[index],
                        onChanged: (bool? value) {
                          controller.checkedStates[index] = value ?? false;
                          if (controller.checkedStates[index]) {
                            controller.selectedCompanies
                                .add(controller.companyNames[index]);
                          } else {
                            controller.selectedCompanies
                                .remove(controller.companyNames[index]);
                          }

                          controller.checkedStates.refresh();
                          controller.companyNames.refresh();
                          controller.selectedCompanies.refresh();
                        },
                      );
                    });
              }),
              ElevatedButton(
                  onPressed: () {
                    // controller.filterOnSelectedCompanies();
                    // controller.applyFilters(
                    //   classType: controller.classType.value,
                    //   priceRange: controller.priceRange.value,
                    //   priceSort: controller.priceSort.value,
                    //   selectedCompanies: controller.selectedCompanies,
                    // );

                    controller.applyCombinedFilters();
                    Get.back();
                  },
                  child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
