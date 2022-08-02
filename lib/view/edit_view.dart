import 'package:flutter/material.dart';

import '../view_model/home_view_model.dart';
import '../model/Category.dart';
import '../model/Tags.dart';
import '../res/widgets/round_button.dart';
import '../res/color.dart';
import '../res/string.dart';
import '../utils/utils.dart';

class EditView extends StatefulWidget {
  EditView({
    Key? key,
    this.petID,
    this.petCategory,
    this.petName,
    required this.petPhotoUrls,
    required this.petTags,
    this.petStatus,
  }) : super(key: key);

  String? petID;
  Category? petCategory = Category();
  String? petName;
  List<String> petPhotoUrls = [];
  List<Tags> petTags = [];
  String? petStatus;

  @override
  _EditViewState createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();

  TextEditingController _idController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _categoryNameController = TextEditingController();

  FocusNode idFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode categoryNameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _idController.text = widget.petID!;
    _nameController.text = widget.petName!;
    _categoryNameController.text =
        (widget.petCategory != null) ? widget.petCategory!.name.toString() : "";
  }

  @override
  void dispose() {
    super.dispose();

    _idController.dispose();
    _nameController.dispose();
    _categoryNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        automaticallyImplyLeading: true,
        title: const Text(
          Strings.EDIT_SCREEN_NAME,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildProductDescription(),
            ),
            RoundButton(
              title: Strings.UPDATE_BTN,
              loading: homeViewViewModel.editLoading,
              onPress: () {
                if (_idController.text.isEmpty) {
                  Utils.flushBarErrorMessage(
                    Strings.ID_ERROR_MSG,
                    Colors.red,
                    context,
                  );
                } else if (_nameController.text.isEmpty) {
                  Utils.flushBarErrorMessage(
                    Strings.NAME_ERROR_MSG,
                    Colors.red,
                    context,
                  );
                } else if (_categoryNameController.text.isEmpty) {
                  Utils.flushBarErrorMessage(
                    Strings.CAT_NAME_ERROR_MSG,
                    Colors.red,
                    context,
                  );
                } else {
                  var params = {
                    'id': (_idController.text.isEmpty) ? 0 : _idController.text,
                    'category': {
                      'id': 0,
                      'name': _categoryNameController.text,
                    },
                    'name': _nameController.text,
                    'photoUrls': (widget.petPhotoUrls != null &&
                            widget.petPhotoUrls.isNotEmpty)
                        ? widget.petPhotoUrls
                        : [],
                    'tags':
                        (widget.petTags != null && widget.petTags.isNotEmpty)
                            ? widget.petTags
                            : [],
                    'status': widget.petStatus
                  };

                  homeViewViewModel.editPetApi(
                    params,
                    context,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductDescription() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
        border: Border.all(
          width: 1.0,
          color: (widget.petStatus == Strings.STATUS_AVAILABLE)
              ? AppColors.STATUS_AVAILABLE
              : (widget.petStatus == Strings.STATUS_PENDING)
                  ? AppColors.STATUS_PENDING
                  : (widget.petStatus == Strings.STATUS_SOLD)
                      ? AppColors.STATUS_SOLD
                      : Colors.blueAccent,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 30.0,
          right: 30.0,
          top: 20.0,
          bottom: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// PRODUCT_ID_LABEL
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    Strings.PRODUCT_ID_LABEL,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    controller: _idController,
                    keyboardType: TextInputType.number,
                    focusNode: idFocusNode,
                    decoration: const InputDecoration(
                      hintText: Strings.ID_LABEL,
                      labelText: Strings.ID_LABEL,
                      prefixIcon: Icon(
                        Icons.numbers,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 10,
                        minHeight: 10,
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      Utils.fieldFocusChange(
                        context,
                        idFocusNode,
                        nameFocusNode,
                      );
                    },
                  ),
                ],
              ),
            ),

            /// NAME_LABEL
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    Strings.NAME_LABEL,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    focusNode: nameFocusNode,
                    decoration: const InputDecoration(
                      hintText: Strings.NAME_LABEL,
                      labelText: Strings.NAME_LABEL,
                      prefixIcon: Icon(
                        Icons.pets,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 10,
                        minHeight: 10,
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      Utils.fieldFocusChange(
                        context,
                        nameFocusNode,
                        categoryNameFocusNode,
                      );
                    },
                  ),
                ],
              ),
            ),

            /// CATEG_NAME_LABEL
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    Strings.CATEG_NAME_LABEL,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    controller: _categoryNameController,
                    keyboardType: TextInputType.name,
                    focusNode: categoryNameFocusNode,
                    decoration: const InputDecoration(
                      hintText: Strings.CATEG_NAME_LABEL,
                      labelText: Strings.CATEG_NAME_LABEL,
                      prefixIcon: Icon(
                        Icons.pets,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 10,
                        minHeight: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// STATUS_LABEL
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    Strings.STATUS_LABEL,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    widget.petStatus.toString().toUpperCase(),
                    style: TextStyle(
                      color: (widget.petStatus == Strings.STATUS_AVAILABLE)
                          ? AppColors.STATUS_AVAILABLE
                          : (widget.petStatus == Strings.STATUS_PENDING)
                              ? AppColors.STATUS_PENDING
                              : (widget.petStatus == Strings.STATUS_SOLD)
                                  ? AppColors.STATUS_SOLD
                                  : Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
