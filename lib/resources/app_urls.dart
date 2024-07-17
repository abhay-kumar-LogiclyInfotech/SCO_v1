class AppUrls {
  // Use 'const' for a constant base URL
  static const String _baseUrl = "https://stg.sco.ae/o/mopa-sco-api/";

  //getting the base URL
  static const String baseUrl = _baseUrl;

  // Static getter for common data endpoint
  static String get commonData => "${_baseUrl}common-data/list-of-values-data";

  //signup endpoint
  static String get signup => "${_baseUrl}users/register";

}

