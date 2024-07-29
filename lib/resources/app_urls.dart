class AppUrls {
  // Use 'const' for a constant base URL
  static const String _baseUrl = "https://stg.sco.ae/o/mopa-sco-api/";

  //getting the base URL
  static const String baseUrl = _baseUrl;

  // Static getter for common data endpoint
  static String get commonData => "${_baseUrl}common-data/list-of-values-data";

  //signup endpoint
  static String get signup => "${_baseUrl}users/register";

  //login endpoint
  static String get login => "${_baseUrl}users/login";

  //faq's endpoint
  static String get faq => "https://stg.sco.ae/api/jsonws/journal.journalarticle/get-latest-article";

  //vision and mission endpoint
  static String get visionAndMission => "https://stg.sco.ae/api/jsonws/pageview.pagecontent/get-page-content-by-page-url";






}

