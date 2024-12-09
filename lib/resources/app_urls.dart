class AppUrls {
  // Use 'const' for a constant base URL
  static const String _domainUrl = "https://stg.sco.ae/";
  static const String _commonBaseUrl = "${_domainUrl}api/";
  static const String _baseUrl = "${_domainUrl}o/mopa-sco-api/";


  // Getting domain url
  static const String domainUrl = _domainUrl;
  //getting the base URL
  static const String baseUrl = _baseUrl;
  // getting common base URL
  static const String commonBaseUrl = _commonBaseUrl;


  // Static getter for common data endpoint
  static String get commonData => "${_baseUrl}common-data/list-of-values-data";

  //signup endpoint
  static String get signup => "${_baseUrl}users/register";

  //login endpoint
  static String get login => "${_baseUrl}users/login";

  /// change password with mopa-sco-api
  static String get changePassword => "${_baseUrl}users/updatePassword";

  //faq's endpoint
  static String get faq => "${_commonBaseUrl}jsonws/journal.journalarticle/get-latest-article";

  //vision and mission endpoint
  static String get getPageContentByUrl => "${_commonBaseUrl}jsonws/pageview.pagecontent/get-page-content-by-page-url";

  //contact us endpoint
  static String get contactUs => "${_commonBaseUrl}jsonws/contactus.contactus/add-contact-us";

  //news and events endpoint
  static String get newsAndEvents => "${_commonBaseUrl}jsonws/newsandevents.newsandevents/find-all-published-item/group-id/20126/is-published/true/is-event/false";

  //individual image endpoint
  static String get individualImage => "${_baseUrl}common-data/get-image-url/";


  //A Brief About Sco endPoint
  static String get aBriefAboutSco => "${_commonBaseUrl}jsonws/pageview.pagecontent/get-page-content-by-page-url";


  //Home Slider EndPoint endPoint
  static String get homeSlider => "${_commonBaseUrl}jsonws/journal.journalarticle/get-articles/group-id/20126/folder-id/79082";

  // All Active scholarships endPoint
  static String get getAllActiveScholarships => "${_commonBaseUrl}jsonws/configuration.submissionconfiguration/find-all-active-scholarship";

  // find-draft-by-emirate-id-and-config-key
  static String get findDraftByConfigurationKey   => "${_domainUrl}api/jsonws/application.applicationdetails/find-draft-by-emirate-id-and-config-key";

  // get File content of the employment status files
  static String get getEmploymentStatusFileContent   => "${_domainUrl}o/mopa-sco-api/e-services/employment-status-file-content";

  // get File content of the Request files
  static String get getRequestFileContent   => "${_domainUrl}o/mopa-sco-api/self-service/service-request-file-content";

  // get File content of the Notes Attachment files
  static String get getUpdateNoteFileContent   => "${_domainUrl}o/mopa-sco-api/self-service/notes-file-content";

  // Update profile image size must be less then 200kb
  static String get updateProfilePicture   => "${_domainUrl}api/jsonws/userext.userextension/update-user-portrait";


  ///  DECREASE NOTIFICATIONS COUNT
static String get decreaseNotificationCount => "${_domainUrl}api/jsonws/mopanotification.mopanotification/maked-as-view";


/// Scholarship inside uae
  static String get scholarshipInsideUae => "${_domainUrl}ar/web/sco/scholarships-inside-uae";
/// scholarship outside uae
  static String get scholarshipOutsideUae => "${_domainUrl}ar/web/sco/scholarships-outside-uae";

}
