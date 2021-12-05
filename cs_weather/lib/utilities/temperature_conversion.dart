// various units of temperature
enum TemperatureUnit {
  KELVIN,
  CELSIUS,
  FAHERNHEIT
}

// generic call to handle all temperatures
class Temperature{

  final double _kelvin;

  Temperature(this._kelvin) : assert(_kelvin != null);

  double get kelvin => _kelvin;
  double get celsius => _kelvin - 273.15;
  double get fahrenheit => _kelvin * (9/5) - 459.67;

  double as(TemperatureUnit unit){
    switch(unit){
      case TemperatureUnit.KELVIN:
        return this.kelvin;
        break;
      case TemperatureUnit.CELSIUS:
        return this.celsius;
        break;
      case TemperatureUnit.FAHERNHEIT:
        return this.fahrenheit;
        break;
    }
    return this.fahrenheit;
  }
}

// int to double conversion
intToDouble(dynamic val) {
  if (val.runtimeType == double) {
    return val;
  } else if (val.runtimeType == int) {
    return val.toDouble();
  } else {
    throw new Exception("value is not of type 'int' or 'double' got type '" +
        val.runtimeType.toString() +
        "'");
  }
}
