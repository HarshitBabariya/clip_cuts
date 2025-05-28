
import 'package:clip_cuts/api2/api_service.dart';
import 'package:clip_cuts/api2/response_model.dart';
import 'package:clip_cuts/const/const_api.dart';
import 'package:clip_cuts/views/sign_in/sign_in_model.dart';

class SignInRepo{

  final ApiService _apiService = ApiService();

  Future<ApiResponse<SignInModel>> login({required String email, required String password}) async {
    try {
      var response = await _apiService.post(
        ConstApi.userAuth,
        data: {
          "email": email,
          "password": password,
          "device_id":"12345",
          "device_type":"android",
          "device_token":"dhsbchsbhsadsaded"
        },

        fromJson: (json) => SignInModel.fromJson(json),
      );
      return response;
    } on ApiException catch (e) {
      return ApiResponse.error(e.message, statusCode: e.statusCode);
    }
  }
}
