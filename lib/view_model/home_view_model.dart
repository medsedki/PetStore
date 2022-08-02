import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../data/response/api_response.dart';
import '../respository/home_repository.dart';
import '../model/Pet.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class HomeViewViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  bool _editLoading = false;

  bool get editLoading => _editLoading;

  ApiResponse<List<Pet>> petsList = ApiResponse.loading();

  setPetsList(ApiResponse<List<Pet>> response) {
    petsList = response;
    notifyListeners();
  }

  Future<void> fetchPetsListApi(String status, BuildContext context) async {
    setPetsList(ApiResponse.loading());

    _myRepo.fetchPetsList(status).then((value) {
      setPetsList(
        ApiResponse.completed(value),
      );
    }).onError((error, stackTrace) {
      setPetsList(
        ApiResponse.error(
          error.toString(),
        ),
      );
    });
  }

  deletePetList(ApiResponse<dynamic> response) {
    notifyListeners();
  }

  Future<void> deletePetByIdApi(var id, BuildContext context) async {
    _myRepo.deletePet(id).then((value) {
      deletePetList(
        ApiResponse.completed(value),
      );
      Utils.flushBarErrorMessage(
        'Deleted Successfully',
        Colors.greenAccent,
        context,
      );
    }).onError((error, stackTrace) {
      deletePetList(
        ApiResponse.error(
          error.toString(),
        ),
      );
      Utils.flushBarErrorMessage(
        error.toString(),
        Colors.red,
        context,
      );
    });
  }

  setEditLoading(bool value) {
    _editLoading = value;
    notifyListeners();
  }

  Future<void> editPetApi(dynamic data, BuildContext context) async {
    setEditLoading(true);

    _myRepo.editPet(data).then((value) {
      setEditLoading(false);

      Utils.flushBarErrorMessage(
        'Edited Successfully',
        Colors.greenAccent,
        context,
      ).whenComplete(() {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushNamed(context, RoutesName.home);
        });
      });
    }).onError((error, stackTrace) {
      setEditLoading(false);

      Utils.flushBarErrorMessage(
        error.toString(),
        Colors.red,
        context,
      );
    });
  }
}
