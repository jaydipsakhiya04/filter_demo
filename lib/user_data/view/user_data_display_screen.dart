import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskdemoproject/user_data/controller/user_data_controller.dart';
import 'package:taskdemoproject/user_data/model/user_data_model.dart';
import 'package:taskdemoproject/user_data/widget/common_text_widget.dart';
import 'package:taskdemoproject/user_data/widget/common_textfield_widget.dart';
import 'package:taskdemoproject/utils/enum/user_type_enum.dart';

class UserDataDisplayScreen extends GetView<UserDataController> {
  UserDataDisplayScreen({super.key});

  final UserDataController controller1 = Get.put(UserDataController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserDataController>(
      initState: (state) {
       controller. addDataIntoSearchList();
      },
      builder: (_) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.indigo.shade200,
              title: const Text("User Data",
                  style: TextStyle(fontSize: 24, color: Colors.black)),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                controller.clearData();
                controller.selectedUser.value = UserType.student;
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const CommonText(
                                text: "Add User Here",
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              CommonTextField(
                                  labelText: "Name",
                                  controller: controller.nameController),
                              CommonTextField(
                                  labelText: "Age",
                                  controller: controller.ageController),
                              CommonTextField(
                                  labelText: "Mobile Number",
                                  controller: controller.mobileNoController),
                              CommonTextField(
                                  labelText: "Address",
                                  controller: controller.addressController),
                              Column(
                                children: [
                                  Obx(
                                    () => ListTile(
                                      title: const Text("Student"),
                                      leading: Radio<UserType>(
                                        value: UserType.student,
                                        groupValue: controller.selectedUser.value,
                                        onChanged: (value) {
                                          controller.updateUserType(value!);
                                        },
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => ListTile(
                                      title: const Text("Teacher"),
                                      leading: Radio<UserType>(
                                        value: UserType.teacher,
                                        groupValue: controller.selectedUser.value,
                                        onChanged: (value) {
                                          controller.updateUserType(value!);
                                        },
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => ListTile(
                                      title: const Text("Parents"),
                                      leading: Radio<UserType>(
                                        value: UserType.parent,
                                        groupValue: controller.selectedUser.value,
                                        onChanged: (value) {
                                          controller.updateUserType(value!);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    controller.userDetailList.add(UserDataModel(
                                        name: controller.nameController.text,
                                        age: controller.ageController.text,
                                        mobileNo:
                                            controller.mobileNoController.text,
                                        address: controller.addressController.text,
                                        userType: controller.selectedUser.value));
                                    controller.addDataIntoSearchList();




                                    Get.back();
                                    controller.clearData();
                                  },
                                  child: const CommonText(
                                    text: "Add User",
                                  ))
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Icon(Icons.add),
            ),
            body: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(
                      () => (controller.isSearch.value)
                          ? Expanded(
                              child: CommonTextField(
                                labelText: "",
                                controller: controller.searchController,
                                hintText: "Search here....",
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.isSearch.value = false;
                                      controller.searchController.clear();
                                    },
                                    icon: const Icon(Icons.clear)),
                                onChanged: (p0) {
                                  controller.searchQuery.value = p0;
                                  controller.searchedUserDetailList.value =
                                      controller.userDetailList
                                          .where((element) => element.name
                                              .toLowerCase()
                                              .contains(p0.toLowerCase()))
                                          .toList();
                                },
                              ).paddingSymmetric(horizontal: 16),
                            )
                          : IconButton(
                              onPressed: () {
                                controller.isSearch.value = true;
                              },
                              icon: const Icon(Icons.search_rounded)),
                    ),
                  ],
                ),
                // Obx(
                //   () => (controller.searchedUserDetailList.isEmpty ||
                //           controller.searchQuery.isEmpty)
                //       ? Expanded(
                //           child: ListView.builder(
                //             itemCount: controller.userDetailList.length,
                //             padding: const EdgeInsets.all(16),
                //             itemBuilder: (context, index) => GestureDetector(
                //               onTap: () {
                //                 showDialog(
                //                   context: context,
                //                   builder: (BuildContext context) {
                //                     return Dialog(
                //                       insetPadding: const EdgeInsets.symmetric(
                //                           horizontal: 16),
                //                       child: Padding(
                //                         padding: const EdgeInsets.symmetric(
                //                             horizontal: 16, vertical: 16),
                //                         child: SingleChildScrollView(
                //                           child: Column(
                //                             mainAxisSize: MainAxisSize.min,
                //                             children: [
                //                               const CommonText(
                //                                 text: "Edit User Here",
                //                                 color: Colors.black,
                //                                 fontSize: 24,
                //                                 fontWeight: FontWeight.w600,
                //                               ),
                //                               const SizedBox(
                //                                 height: 12,
                //                               ),
                //                               CommonTextField(
                //                                   labelText: "Name",
                //                                   controller:
                //                                       controller.nameController
                //                                         ..text = controller
                //                                             .userDetailList[index]
                //                                             .name),
                //                               CommonTextField(
                //                                   labelText: "Age",
                //                                   controller:
                //                                       controller.ageController
                //                                         ..text = controller
                //                                             .userDetailList[index]
                //                                             .age),
                //                               CommonTextField(
                //                                   labelText: "Mobile Number",
                //                                   controller:
                //                                       controller.mobileNoController
                //                                         ..text = controller
                //                                             .userDetailList[index]
                //                                             .mobileNo),
                //                               CommonTextField(
                //                                   labelText: "Address",
                //                                   controller:
                //                                       controller.addressController
                //                                         ..text = controller
                //                                             .userDetailList[index]
                //                                             .address),
                //                               Column(
                //                                 children: [
                //                                   Obx(
                //                                     () => ListTile(
                //                                       title: const Text("Student"),
                //                                       leading: Radio<UserType>(
                //                                         value: UserType.student,
                //                                         groupValue: controller
                //                                             .selectedUser.value,
                //                                         onChanged: (value) {
                //                                           controller.updateUserType(
                //                                               value!);
                //                                         },
                //                                       ),
                //                                     ),
                //                                   ),
                //                                   Obx(
                //                                     () => ListTile(
                //                                       title: const Text("Teacher"),
                //                                       leading: Radio<UserType>(
                //                                         value: UserType.teacher,
                //                                         groupValue: controller
                //                                             .selectedUser.value,
                //                                         onChanged: (value) {
                //                                           controller.updateUserType(
                //                                               value!);
                //                                         },
                //                                       ),
                //                                     ),
                //                                   ),
                //                                   Obx(
                //                                     () => ListTile(
                //                                       title: const Text("Parents"),
                //                                       leading: Radio<UserType>(
                //                                         value: UserType.parent,
                //                                         groupValue: controller
                //                                             .selectedUser.value,
                //                                         onChanged: (value) {
                //                                           controller.updateUserType(
                //                                               value!);
                //                                         },
                //                                       ),
                //                                     ),
                //                                   ),
                //                                 ],
                //                               ),
                //                               ElevatedButton(
                //                                   onPressed: () {
                //                                     controller.userDetailList[index]
                //                                             .name =
                //                                         controller
                //                                             .nameController.text;
                //                                     controller.userDetailList[index]
                //                                             .age =
                //                                         controller
                //                                             .ageController.text;
                //                                     controller.userDetailList[index]
                //                                             .mobileNo =
                //                                         controller
                //                                             .mobileNoController
                //                                             .text;
                //                                     controller.userDetailList[index]
                //                                             .address =
                //                                         controller
                //                                             .addressController.text;
                //                                     controller.userDetailList[index]
                //                                             .userType =
                //                                         controller
                //                                             .selectedUser.value;
                //                                     controller.userDetailList
                //                                         .refresh();
                //                                     Get.back();
                //                                   },
                //                                   child: const CommonText(
                //                                     text: "Edit User",
                //                                   ))
                //                             ],
                //                           ),
                //                         ),
                //                       ),
                //                     );
                //                   },
                //                 );
                //               },
                //               child: Container(
                //                 width: double.infinity,
                //                 padding: const EdgeInsets.all(16),
                //                 decoration: BoxDecoration(
                //                     color: Colors.indigo.shade100,
                //                     borderRadius: BorderRadius.circular(16)),
                //                 margin: const EdgeInsets.only(
                //                   bottom: 10,
                //                 ),
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         CommonText(
                //                           text:
                //                               controller.userDetailList[index].name,
                //                           color: Colors.black,
                //                           fontSize: 24,
                //                           fontWeight: FontWeight.w600,
                //                         ),
                //                         IconButton(
                //                             onPressed: () {
                //                               controller.userDetailList
                //                                   .removeAt(index);
                //                               controller.userDetailList.refresh();
                //                             },
                //                             icon: const Icon(
                //                               Icons.delete_forever_rounded,
                //                               color: Colors.red,
                //                               size: 30,
                //                             ))
                //                       ],
                //                     ),
                //                     CommonText(
                //                       text: controller.userDetailList[index].age,
                //                       color: Colors.black,
                //                       fontSize: 22,
                //                     ),
                //                     CommonText(
                //                       text:
                //                           controller.userDetailList[index].address,
                //                       color: Colors.black,
                //                       fontSize: 18,
                //                       fontWeight: FontWeight.w600,
                //                     ),
                //                     CommonText(
                //                       text:
                //                           controller.userDetailList[index].mobileNo,
                //                       color: Colors.black,
                //                       fontSize: 20,
                //                       fontWeight: FontWeight.w600,
                //                     ),
                //                     Row(
                //                       children: [
                //                         CommonText(
                //                           text:
                //                               "User Type:  ${controller.userDetailList[index].userType.toShortString}",
                //                           color: Colors.black,
                //                           fontSize: 18,
                //                           fontWeight: FontWeight.w600,
                //                         ),
                //                       ],
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           ),
                //         )
                //       : (controller.searchQuery.isNotEmpty &&
                //               controller.searchedUserDetailList.isNotEmpty)
                //           ? Expanded(
                //               child: ListView.builder(
                //                 itemCount: controller.searchedUserDetailList.length,
                //                 padding: const EdgeInsets.all(16),
                //                 itemBuilder: (context, index) => GestureDetector(
                //                   onTap: () {
                //                     showDialog(
                //                       context: context,
                //                       builder: (BuildContext context) {
                //                         return Dialog(
                //                           insetPadding: const EdgeInsets.symmetric(
                //                               horizontal: 16),
                //                           child: Padding(
                //                             padding: const EdgeInsets.symmetric(
                //                                 horizontal: 16, vertical: 16),
                //                             child: SingleChildScrollView(
                //                               child: Column(
                //                                 mainAxisSize: MainAxisSize.min,
                //                                 children: [
                //                                   const CommonText(
                //                                     text: "Edit User Here",
                //                                     color: Colors.black,
                //                                     fontSize: 24,
                //                                     fontWeight: FontWeight.w600,
                //                                   ),
                //                                   const SizedBox(
                //                                     height: 12,
                //                                   ),
                //                                   CommonTextField(
                //                                       labelText: "Name",
                //                                       controller: controller
                //                                           .nameController
                //                                         ..text = controller
                //                                             .searchedUserDetailList[
                //                                                 index]
                //                                             .name),
                //                                   CommonTextField(
                //                                       labelText: "Age",
                //                                       controller: controller
                //                                           .ageController
                //                                         ..text = controller
                //                                             .searchedUserDetailList[
                //                                                 index]
                //                                             .age),
                //                                   CommonTextField(
                //                                       labelText: "Mobile Number",
                //                                       controller: controller
                //                                           .mobileNoController
                //                                         ..text = controller
                //                                             .searchedUserDetailList[
                //                                                 index]
                //                                             .mobileNo),
                //                                   CommonTextField(
                //                                       labelText: "Address",
                //                                       controller: controller
                //                                           .addressController
                //                                         ..text = controller
                //                                             .searchedUserDetailList[
                //                                                 index]
                //                                             .address),
                //                                   Column(
                //                                     children: [
                //                                       Obx(
                //                                         () => ListTile(
                //                                           title:
                //                                               const Text("Student"),
                //                                           leading: Radio<UserType>(
                //                                             value: UserType.student,
                //                                             groupValue: controller
                //                                                 .selectedUser.value,
                //                                             onChanged: (value) {
                //                                               controller
                //                                                   .updateUserType(
                //                                                       value!);
                //                                             },
                //                                           ),
                //                                         ),
                //                                       ),
                //                                       Obx(
                //                                         () => ListTile(
                //                                           title:
                //                                               const Text("Teacher"),
                //                                           leading: Radio<UserType>(
                //                                             value: UserType.teacher,
                //                                             groupValue: controller
                //                                                 .selectedUser.value,
                //                                             onChanged: (value) {
                //                                               controller
                //                                                   .updateUserType(
                //                                                       value!);
                //                                             },
                //                                           ),
                //                                         ),
                //                                       ),
                //                                       Obx(
                //                                         () => ListTile(
                //                                           title:
                //                                               const Text("Parents"),
                //                                           leading: Radio<UserType>(
                //                                             value: UserType.parent,
                //                                             groupValue: controller
                //                                                 .selectedUser.value,
                //                                             onChanged: (value) {
                //                                               controller
                //                                                   .updateUserType(
                //                                                       value!);
                //                                             },
                //                                           ),
                //                                         ),
                //                                       ),
                //                                     ],
                //                                   ),
                //                                   ElevatedButton(
                //                                       onPressed: () {
                //                                         controller
                //                                                 .searchedUserDetailList[
                //                                                     index]
                //                                                 .name =
                //                                             controller
                //                                                 .nameController
                //                                                 .text;
                //                                         controller
                //                                                 .searchedUserDetailList[
                //                                                     index]
                //                                                 .age =
                //                                             controller
                //                                                 .ageController.text;
                //                                         controller
                //                                                 .searchedUserDetailList[
                //                                                     index]
                //                                                 .mobileNo =
                //                                             controller
                //                                                 .mobileNoController
                //                                                 .text;
                //                                         controller
                //                                                 .searchedUserDetailList[
                //                                                     index]
                //                                                 .address =
                //                                             controller
                //                                                 .addressController
                //                                                 .text;
                //                                         controller
                //                                                 .searchedUserDetailList[
                //                                                     index]
                //                                                 .userType =
                //                                             controller
                //                                                 .selectedUser.value;
                //                                         controller
                //                                             .searchedUserDetailList
                //                                             .refresh();
                //                                         Get.back();
                //                                       },
                //                                       child: const CommonText(
                //                                         text: "Edit User",
                //                                       ))
                //                                 ],
                //                               ),
                //                             ),
                //                           ),
                //                         );
                //                       },
                //                     );
                //                   },
                //                   child: Container(
                //                     width: double.infinity,
                //                     padding: const EdgeInsets.all(16),
                //                     decoration: BoxDecoration(
                //                         color: Colors.indigo.shade100,
                //                         borderRadius: BorderRadius.circular(16)),
                //                     margin: const EdgeInsets.only(
                //                       bottom: 10,
                //                     ),
                //                     child: Column(
                //                       crossAxisAlignment: CrossAxisAlignment.start,
                //                       children: [
                //                         Row(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.spaceBetween,
                //                           children: [
                //                             CommonText(
                //                               text: controller
                //                                   .searchedUserDetailList[index]
                //                                   .name,
                //                               color: Colors.black,
                //                               fontSize: 24,
                //                               fontWeight: FontWeight.w600,
                //                             ),
                //                             IconButton(
                //                                 onPressed: () {
                //                                   controller.searchedUserDetailList
                //                                       .removeAt(index);
                //                                   controller.searchedUserDetailList
                //                                       .refresh();
                //                                 },
                //                                 icon: const Icon(
                //                                   Icons.delete_forever_rounded,
                //                                   color: Colors.red,
                //                                   size: 30,
                //                                 ))
                //                           ],
                //                         ),
                //                         CommonText(
                //                           text: controller
                //                               .searchedUserDetailList[index].age,
                //                           color: Colors.black,
                //                           fontSize: 22,
                //                         ),
                //                         CommonText(
                //                           text: controller
                //                               .searchedUserDetailList[index]
                //                               .address,
                //                           color: Colors.black,
                //                           fontSize: 18,
                //                           fontWeight: FontWeight.w600,
                //                         ),
                //                         CommonText(
                //                           text: controller
                //                               .searchedUserDetailList[index]
                //                               .mobileNo,
                //                           color: Colors.black,
                //                           fontSize: 20,
                //                           fontWeight: FontWeight.w600,
                //                         ),
                //                         Row(
                //                           children: [
                //                             CommonText(
                //                               text:
                //                                   "User Type:  ${controller.searchedUserDetailList[index].userType.toShortString}",
                //                               color: Colors.black,
                //                               fontSize: 18,
                //                               fontWeight: FontWeight.w600,
                //                             ),
                //                           ],
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             )
                //           : Expanded(
                //               child: const Center(
                //                 child: CommonText(
                //                   text: "No Data Found",
                //                   color: Colors.black,
                //                   fontSize: 24,
                //                   fontWeight: FontWeight.w700,
                //                 ),
                //               ),
                //             ),
                // ),
                Obx(() => controller.searchedUserDetailList.isNotEmpty ?  Expanded(
                  child: ListView.builder(
                    itemCount: controller.searchedUserDetailList.length,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              insetPadding: const EdgeInsets.symmetric(
                                  horizontal: 16),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const CommonText(
                                        text: "Edit User Here",
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      CommonTextField(
                                          labelText: "Name",
                                          controller: controller
                                              .nameController
                                            ..text = controller
                                                .searchedUserDetailList[
                                            index]
                                                .name),
                                      CommonTextField(
                                          labelText: "Age",
                                          controller: controller
                                              .ageController
                                            ..text = controller
                                                .searchedUserDetailList[
                                            index]
                                                .age),
                                      CommonTextField(
                                          labelText: "Mobile Number",
                                          controller: controller
                                              .mobileNoController
                                            ..text = controller
                                                .searchedUserDetailList[
                                            index]
                                                .mobileNo),
                                      CommonTextField(
                                          labelText: "Address",
                                          controller: controller
                                              .addressController
                                            ..text = controller
                                                .searchedUserDetailList[
                                            index]
                                                .address),
                                      Column(
                                        children: [
                                          Obx(
                                                () => ListTile(
                                              title:
                                              const Text("Student"),
                                              leading: Radio<UserType>(
                                                value: UserType.student,
                                                groupValue: controller
                                                    .selectedUser.value,
                                                onChanged: (value) {
                                                  controller
                                                      .updateUserType(
                                                      value!);
                                                },
                                              ),
                                            ),
                                          ),
                                          Obx(
                                                () => ListTile(
                                              title:
                                              const Text("Teacher"),
                                              leading: Radio<UserType>(
                                                value: UserType.teacher,
                                                groupValue: controller
                                                    .selectedUser.value,
                                                onChanged: (value) {
                                                  controller
                                                      .updateUserType(
                                                      value!);
                                                },
                                              ),
                                            ),
                                          ),
                                          Obx(
                                                () => ListTile(
                                              title:
                                              const Text("Parents"),
                                              leading: Radio<UserType>(
                                                value: UserType.parent,
                                                groupValue: controller
                                                    .selectedUser.value,
                                                onChanged: (value) {
                                                  controller
                                                      .updateUserType(
                                                      value!);
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            controller
                                                .searchedUserDetailList[
                                            index]
                                                .name =
                                                controller
                                                    .nameController
                                                    .text;
                                            controller
                                                .searchedUserDetailList[
                                            index]
                                                .age =
                                                controller
                                                    .ageController.text;
                                            controller
                                                .searchedUserDetailList[
                                            index]
                                                .mobileNo =
                                                controller
                                                    .mobileNoController
                                                    .text;
                                            controller
                                                .searchedUserDetailList[
                                            index]
                                                .address =
                                                controller
                                                    .addressController
                                                    .text;
                                            controller
                                                .searchedUserDetailList[
                                            index]
                                                .userType =
                                                controller
                                                    .selectedUser.value;
                                            controller
                                                .searchedUserDetailList
                                                .refresh();
                                            Get.back();
                                          },
                                          child: const CommonText(
                                            text: "Edit User",
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.indigo.shade100,
                            borderRadius: BorderRadius.circular(16)),
                        margin: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                CommonText(
                                  text: controller
                                      .searchedUserDetailList[index]
                                      .name,
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                                IconButton(
                                    onPressed: () {
                                      controller.searchedUserDetailList
                                          .removeAt(index);
                                    },
                                    icon: const Icon(
                                      Icons.delete_forever_rounded,
                                      color: Colors.red,
                                      size: 30,
                                    ))
                              ],
                            ),
                            CommonText(
                              text: controller
                                  .searchedUserDetailList[index].age,
                              color: Colors.black,
                              fontSize: 22,
                            ),
                            CommonText(
                              text: controller
                                  .searchedUserDetailList[index]
                                  .address,
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            CommonText(
                              text: controller
                                  .searchedUserDetailList[index]
                                  .mobileNo,
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            Row(
                              children: [
                                CommonText(
                                  text:
                                  "User Type:  ${controller.searchedUserDetailList[index].userType.toShortString}",
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ) : Expanded(
                  child: const Center(
                    child: CommonText(
                      text: "No Data Found",
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),)
              ],
            ));
      }
    );
  }
}
