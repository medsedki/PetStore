import 'dart:async';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/Pet.dart';
import '../res/app_url.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<List<Pet>> fetchPetsList(String status) async {
    try {
      final response = await _apiServices.getApiResponse(
        AppUrl.PetUrl,
        AppUrl.petsListEndPoint,
        status,
      );
      var res = response as List<dynamic>;
      return res.map((v) => Pet.fromJson(v)).toList();
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> editPet(dynamic data) async {
    try {
      final response = await _apiServices.editApiResponse(
        AppUrl.petEndPoint,
        data,
      );
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> deletePet(var id) async {
    try {
      final response = await _apiServices.deleteApiResponse(
        AppUrl.deletePetEndPoint,
        id,
      );
      return response;
    } catch (e) {
      throw e;
    }
  }
}
