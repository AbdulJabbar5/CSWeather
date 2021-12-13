import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:cs_weather/utilities/toast_message.dart';
import 'package:cs_weather/utilities/string_constants.dart';

// https methods
enum APIMethod {
  GET,
  POST
}

// common provider for all apis
class ServiceProvider {

  // base URL
  String _apiBaseURL = BASE_URL;

  // initialization
  ServiceProvider();

  // api request
  Future callWebService(
      { String? path,
        Encoding? encoding,
        APIMethod? method,
        Map<String, dynamic>? body,
        Map<String, String>? headers}) async {

    var connectivityResult = await (Connectivity().checkConnectivity());

    // check internet connection
    if (connectivityResult == ConnectivityResult.none) {
      AppMessage.toast('No Internet Connection!', toastType: ToastType.SUCCESS);
      return null;
    }

    var responseData;
    final url = Uri.encodeFull(_apiBaseURL + path!);

    print(url.toString());

    switch (method) {
      case APIMethod.GET:
        {
          responseData = await http.get(
            url,
            headers: headers,
          );
        }
        break;

      case APIMethod.POST:
        {
          responseData = await http.post(url,
              headers: {
                "Content-Type": "application/json",
              },
              body: json.encode(body));
        }
        break;
    }

    // api status
    if (responseData.statusCode == 200) {
      return (responseData);
    } else {
      AppMessage.toast(
          'Response Code: ${responseData.statusCode}- Service Unavailable!', toastType: ToastType.FAILED);
      return null;
    }
  }
}