import 'package:flutter/material.dart';

import '../model/Category.dart';
import '../model/Tags.dart';
import '../res/color.dart';
import '../res/string.dart';

class DetailView extends StatefulWidget {
  DetailView({
    Key? key,
    this.petID,
    this.petCategory,
    this.petName,
    required this.petPhotoUrls,
    required this.petTags,
    this.petStatus,
  }) : super(key: key);

  String? petID;
  Category? petCategory;
  String? petName;
  List<String> petPhotoUrls = [];
  List<Tags> petTags = [];
  String? petStatus;

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
          Strings.DETAILS_SCREEN_NAME,
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
          ],
        ),
      ),
    );
  }

  Widget _buildProductDescription() {
    return Container(
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
              child: Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text(
                      Strings.PRODUCT_ID_LABEL,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      widget.petID.toString(),
                    ),
                  ),
                ],
              ),
            ),

            /// NAME_LABEL
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
              ),
              child: Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text(
                      Strings.NAME_LABEL,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      widget.petName.toString(),
                    ),
                  ),
                ],
              ),
            ),

            /// CATEG_NAME_LABEL
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
              ),
              child: Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text(
                      Strings.CATEG_NAME_LABEL,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      (widget.petCategory != null)
                          ? widget.petCategory!.name.toString()
                          : "null",
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
              child: Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text(
                      Strings.STATUS_LABEL,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
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
                  ),
                ],
              ),
            ),

            /// CARACTERISTIQUE_LABEL
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  Strings.CARACTERISTIQUE_LABEL,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 5.0,
                  ),
                  child: Text(
                    Strings.LOREM_LABEL,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
