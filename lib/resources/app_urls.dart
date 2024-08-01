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

  static const String _commonBaseUrl = "https://stg.sco.ae/api/";

  //faq's endpoint
  static String get faq =>
      "${_commonBaseUrl}jsonws/journal.journalarticle/get-latest-article";

  //vision and mission endpoint
  static String get visionAndMission =>
      "${_commonBaseUrl}jsonws/pageview.pagecontent/get-page-content-by-page-url";

  //contact us endpoint
  static String get contactUs =>
      "${_commonBaseUrl}jsonws/contactus.contactus/add-contact-us";

  //news and events endpoint
  static String get newsAndEvents =>
      "${_commonBaseUrl}jsonws/newsandevents.newsandevents/find-all-published-item/group-id/20126/is-published/true/is-event/false";
}
