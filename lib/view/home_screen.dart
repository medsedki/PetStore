import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../view_model/home_view_model.dart';
import '../data/response/status.dart';
import 'detail_view.dart';
import 'edit_view.dart';
import '../res/color.dart';
import '../res/string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();

  String dropdownvalue = "available";
  List<String> listitems = ["available", "pending", "sold"];

  @override
  void initState() {
    super.initState();

    homeViewViewModel.fetchPetsListApi(
      (dropdownvalue.toString().isNotEmpty || dropdownvalue.toString() != null)
          ? dropdownvalue.toString()
          : 'available',
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(Strings.HOME_SCREEN_NAME),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              homeViewViewModel.fetchPetsListApi(
                dropdownvalue.toString(),
                context,
              );
            },
            child: const Center(
              child: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          buildStatusDropDown(),
          const SizedBox(
            height: 10.0,
          ),
          ChangeNotifierProvider<HomeViewViewModel>(
            create: (BuildContext context) => homeViewViewModel,
            child: Consumer<HomeViewViewModel>(builder: (context, value, _) {
              switch (value.petsList.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(child: Text(value.petsList.message.toString()));
                case Status.COMPLETED:
                  if (value.petsList.data!.length == 0) {
                    return const Center(
                      child: Text(
                        Strings.LIST_EMPTY,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: value.petsList.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: (value.petsList.data![index].status ==
                                      Strings.STATUS_AVAILABLE)
                                  ? AppColors.STATUS_AVAILABLE
                                  : (value.petsList.data![index].status ==
                                          Strings.STATUS_PENDING)
                                      ? AppColors.STATUS_PENDING
                                      : (value.petsList.data![index].status ==
                                              Strings.STATUS_SOLD)
                                          ? AppColors.STATUS_SOLD
                                          : Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: SizedBox(
                              width: 40.0,
                              child: Text(
                                value.petsList.data![index].id.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            title: Text(
                              (value.petsList.data![index].name
                                          .toString()
                                          .isEmpty ||
                                      value.petsList.data![index].name
                                              .toString() ==
                                          null ||
                                      value.petsList.data![index].name
                                              .toString() ==
                                          "null")
                                  ? "- - -"
                                  : value.petsList.data![index].name.toString(),
                            ),
                            trailing: Wrap(
                              spacing: 12,
                              children: [
                                /// view
                                GestureDetector(
                                  child: const Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: Colors.blueAccent,
                                  ),
                                  onTap: () {
                                    navigateToDetail(
                                      value.petsList.data![index].id.toString(),
                                      value.petsList.data![index].category,
                                      value.petsList.data![index].name
                                          .toString(),
                                      value.petsList.data![index].photoUrls,
                                      value.petsList.data![index].tags,
                                      value.petsList.data![index].status
                                          .toString(),
                                    );
                                  },
                                ),

                                /// edit
                                GestureDetector(
                                  child: const Icon(
                                    Icons.edit_road,
                                    color: Colors.blueAccent,
                                  ),
                                  onTap: () {
                                    navigateToEdit(
                                      value.petsList.data![index].id.toString(),
                                      value.petsList.data![index].category,
                                      value.petsList.data![index].name
                                          .toString(),
                                      value.petsList.data![index].photoUrls,
                                      value.petsList.data![index].tags,
                                      value.petsList.data![index].status
                                          .toString(),
                                    );
                                  },
                                ),

                                /// delete
                                GestureDetector(
                                  child: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.blueAccent,
                                  ),
                                  onTap: () {
                                    homeViewViewModel
                                        .deletePetByIdApi(
                                      value.petsList.data![index].id.toString(),
                                      context,
                                    )
                                        .whenComplete(() {
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        setState(() {
                                          value.petsList.data!.removeAt(index);
                                        });
                                      });
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
              }
              return Container();
            }),
          ),
        ],
      ),
    );
  }

  Widget buildStatusDropDown() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color(0xFF36A9E1),
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color(0xFF36A9E1),
            width: 1.0,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: Strings.STATUS_AVAILABLE,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color(0xFFFF0000),
            width: 1.0,
          ),
        ),
      ),
      hint: const Text(
        Strings.STATUS_AVAILABLE,
      ),
      validator: (value) {
        if (value == null) {
          return Strings.STATUS_ERROR_MSG;
        }
        return null;
      },
      dropdownColor: Colors.white,
      value: dropdownvalue,
      isDense: true,
      onChanged: (var newValue) {
        setState(() {
          dropdownvalue = newValue as String;
        });
      },
      items: listitems.map((items) {
        return DropdownMenuItem(
          value: items.toString(),
          onTap: () {
            homeViewViewModel.fetchPetsListApi(items.toString(), context);
          },
          child: Text(
            items.toString(),
          ),
        );
      }).toList(),
    );
  }

  navigateToDetail(
    idPet,
    categoryPet,
    namePet,
    photoUrlsPet,
    tagsPet,
    statusPet,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => DetailView(
          petID: idPet,
          petCategory: categoryPet,
          petName: namePet,
          petPhotoUrls: photoUrlsPet,
          petTags: tagsPet,
          petStatus: statusPet,
        ),
      ),
    );
  }

  navigateToEdit(
    idPet,
    categoryPet,
    namePet,
    photoUrlsPet,
    tagsPet,
    statusPet,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => EditView(
          petID: idPet,
          petCategory: categoryPet,
          petName: namePet,
          petPhotoUrls: photoUrlsPet,
          petTags: tagsPet,
          petStatus: statusPet,
        ),
      ),
    );
  }
}
