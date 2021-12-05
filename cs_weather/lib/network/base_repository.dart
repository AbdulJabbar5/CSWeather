import 'package:cs_weather/network/service_provider.dart';

class BaseRepository {
  final networkProvider = ServiceProvider();
  Map<String, String> header = {
    "Content-Type": "application/json",
  };
}