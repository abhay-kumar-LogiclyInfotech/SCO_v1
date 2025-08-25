import 'dart:convert';



class AppUrls {


  /// ********** App Credentials Start **********///
  /// Replace the below values to change to production or vice versa
  static const String _domainUrl = "https://stg.sco.ae/";
  static const String username = "liferay_access@sco.ae";
  static const String password = "India@1234";




  ///-[displayStagingBanner] Set to `true` to show a red STAGING banner.
  ///-[displayLanguageToggleButton]:
  ///     → `true`: Show language switch (Arabic <-> English)
  ///     → `false`: Lock app to Arabic only and hide change language buttons
  static const bool displayStagingBanner = true;
  static const bool displayLanguageToggleButton = true;
  /// ********** App Credentials End **********///




  static String basicAuthWithUsernamePassword = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
  static String basicAuth = basicAuthWithUsernamePassword;



  // static const String authKey = "bGlmZXJheV9hY2Nlc3NAc2NvLmFlOkluZGlhQDEyMzQ=";
  // static const String basicAuth = 'Basic $authKey';

  static const String _commonBaseUrl = "${_domainUrl}api/";
  static const String _baseUrl = "${_domainUrl}o/mopa-sco-api/";

  // Getting domain url
  static const String domainUrl = _domainUrl;
  // Getting the base URL
  static const String baseUrl = _baseUrl;
  // Getting common base URL
  static const String commonBaseUrl = _commonBaseUrl;


  static String get openAuthToken => "${_baseUrl}sco-oauth/token";

  // Static getter for common data endpoint
  static String get commonData => "${_baseUrl}common-data/list-of-values-data";

  //signup endpoint
  static String get signup => "${_baseUrl}users/register";

  //login endpoint
  static String get login => "${_baseUrl}users/login";

  /// change password with mopa-sco-api
  static String changePassword(String userId) => "${_baseUrl}users/$userId/updatePassword";

  //faq's endpoint
  // static String get faq => "${_commonBaseUrl}jsonws/journal.journalarticle/get-latest-article";
  // static String get faq => "${_baseUrl}common-data/get-latest-article";
  static String get faq => "https://stg.sco.ae/o/mopa-sco-api/common-data/get-latest-article/71109/20126/0";

  //vision and mission endpoint
  // static String get getPageContentByUrl => "${_commonBaseUrl}jsonws/pageview.pagecontent/get-page-content-by-page-url";
  static String get getPageContentByUrl => "${_baseUrl}common-data/get-page-content";

  //contact us endpoint
  // static String get contactUs => "${_commonBaseUrl}jsonws/contactus.contactus/add-contact-us";
  static String get contactUs => "${_baseUrl}common-data/add-contact-us";

  //news and events endpoint
  // static String get newsAndEvents => "${_commonBaseUrl}jsonws/newsandevents.newsandevents/find-all-published-item/group-id/20126/is-published/true/is-event/false";
  static String get newsAndEvents => "https://stg.sco.ae/o/mopa-sco-api/common-data/find-all-published-item/20126/true/false";

  //individual image endpoint
  static String get individualImage => "${_baseUrl}common-data/get-image-url/";

  //Home Slider EndPoint endPoint
  // static String get homeSlider => "${_commonBaseUrl}jsonws/journal.journalarticle/get-articles/group-id/20126/folder-id/79082";

  // All Active scholarships endPoint
  // static String get getAllActiveScholarships => "${_commonBaseUrl}jsonws/configuration.submissionconfiguration/find-all-active-scholarship";
  static String get getAllActiveScholarships => "${_baseUrl}common-data/find-all-active-scholarship";

  // find-draft-by-emirate-id-and-config-key
  static String  findDraftByConfigurationKey(userId,emiratesId,configKey)   => "${_baseUrl}e-services/$userId/find-draft-by-emirate-id-and-config-key/$emiratesId/$configKey";

  // get File content of the employment status files
  // static String get getEmploymentStatusFileContent   => "${_domainUrl}o/mopa-sco-api/e-services/employment-status-file-content";
  static String  getEmploymentStatusFileContent(userId)   => "${_baseUrl}e-services/$userId/employment-status-file-content";

  // get File content of the Request files
  static String  getRequestFileContent(userId)   => "${_baseUrl}self-service/$userId/service-request-file-content";

  // get File content of the Notes Attachment files
  // static String get getUpdateNoteFileContent   => "${_domainUrl}o/mopa-sco-api/self-service/notes-file-content";
  static String  getUpdateNoteFileContent(userId)   => "${_baseUrl}self-service/$userId/notes-file-content";

  // Update profile image size must be less then 200kb
  static String  updateProfilePicture(userId)  => "${_baseUrl}e-services/$userId/update-user-portrait";


  /// get draft application by application number
  // static String get getDraftApplicationByDraftId => "${_commonBaseUrl}jsonws/application.applicationdetails/fetch-by-application-id/application-no/";
  static String  getDraftApplicationByDraftId(userId,draftId) => "${_baseUrl}e-services/$userId/fetch-by-application-id/$draftId";

  /// get submitted application by application number
  // static String get getSubmittedApplicationDetailsByApplicationNumber => "${_commonBaseUrl}jsonws/application.applicationdetails/find-by-application-number/application-no/";
  static String  getSubmittedApplicationDetailsByApplicationNumber(userId,applicationNumber) => "${_baseUrl}e-services/$userId/find-by-application-number/$applicationNumber";

  /// get profile picture url
  // static String get getProfilePictureUrl => "${_commonBaseUrl}jsonws/userext.userextension/get-user-portrait-url/user-id/";
  // static String get getProfilePictureUrl => "${_commonBaseUrl}jsonws/userext.userextension/get-user-portrait-url/user-id/";

  /// get notification count
  // static String get getNotificationsCount => "${_commonBaseUrl}jsonws/mopanotification.mopanotification/get-notification-new-count-for-user/user-name/";
  static String  getNotificationsCount(userId) => "${_baseUrl}e-services/$userId/user-notification-count";

  /// get all notifications
  // static String get getAllNotifications => "${_commonBaseUrl}jsonws/mopanotification.mopanotification/get-all-notification-for-user/user-id/";
  static String  getAllNotifications(userId) => "${_baseUrl}e-services/$userId/user-notification";

  ///  Decrease notifications count or mark notification as read
  // static String get decreaseNotificationCount => "${_domainUrl}api/jsonws/mopanotification.mopanotification/maked-as-view";
  static String  decreaseNotificationCount(userId) => "${_baseUrl}e-services/$userId/marked-as-view";




//// ******************************************************** Urls for web view Start **********************************************************
  static const String _staticWebPagesDomainUrl = "https://sco.ae/";
  static String get briefAboutSco => "${_staticWebPagesDomainUrl}ar/web/sco/about-sco/a-brief-about-the-office";

/// Scholarship inside uae
  static String get scholarshipInsideUae => "${_staticWebPagesDomainUrl}ar/web/sco/scholarships-inside-uae";
/// scholarship outside uae
  static String get scholarshipOutsideUae => "${_staticWebPagesDomainUrl}ar/web/sco/scholarships-outside-uae";


  static const String _scholarshipInUae = "${_staticWebPagesDomainUrl}ar/web/sco/scholarship-whithin-the-uae/";
  /// bachelor links
  static const String _bachelorInUae = "${_scholarshipInUae}bachelor-s-degree-scholarship/";
  static String get bachelorsTermsAndConditions => "${_bachelorInUae}bachelor-s-degree-scholarship-admission-terms-and-conditions";
  static String get bachelorsUniversityAndSpecializationList => "${_bachelorInUae}sco-accredited-universities-and-specializations-list";
  static String get bachelorsDegreePrivileges => "${_bachelorInUae}bachelor-s-degree-scholarship-privileges";
  static String get bachelorsDegreeStudentObligations => "${_bachelorInUae}student-obligations-for-the-bachelor-s-degree-scholarship";
  static String get bachelorsDegreeImportantGuidelines => "${_bachelorInUae}important-guidelines-for-high-school-students";
  static String get bachelorsDegreeApplyingProcedure => "${_bachelorInUae}bachelor-s-degree-applying-procedures";



  static String get graduateTermsAndConditions => "${_staticWebPagesDomainUrl}web/sco/scholarship-within-uae/graduate-studies-scholarship-admission-terms-and-conditions";
  static String get graduateUniversityAndSpecializationList => "${_scholarshipInUae}graduate-studies-scholarship/sco-accredited-universities-and-specializations-list";
  static String get graduateDegreePrivileges => "${_scholarshipInUae}graduate-studies-scholarship/graduate-studies-scholarship-privileges";
  static String get graduateDegreeStudentObligations => "${_scholarshipInUae}graduate-studies-scholarship/student-obligations-for-the-graduate-studies-scholarship";
  static String get graduateDegreeApplyingProcedure => "${_scholarshipInUae}graduate-studies-scholarship/graduate-studies-scholarship-applying-procedures";


  static const String _meteorological = "${_scholarshipInUae}meteorological-scholarship/";
  static String get meteorologicalTermsAndConditions => "${_meteorological}meteorological-scholarship-admission-terms-and-conditions";
  static String get meteorologicalUniversityAndSpecializationList => "${_meteorological}sco-accredited-universities-and-specializations-list";
  static String get meteorologicalDegreePrivileges => "${_meteorological}meteorological-scholarship-privileges";
  static String get meteorologicalDegreeStudentObligations => "${_meteorological}student-obligations-for-the-meteorological-scholarship";
  static String get meteorologicalDegreeApplyingProcedure => "${_meteorological}meteorological-scholarship-applying-procedures";


  static const String _scholarshipOutsideUae = "${_staticWebPagesDomainUrl}ar/web/sco/scholarship-outside-the-uae/";
  static const String _distinguishedOutsideUae = "${_scholarshipOutsideUae}distinguished-doctors-scholarship/";
  static String get distinguishedTermsAndConditions => "${_distinguishedOutsideUae}distinguished-doctors-scholarship-admission-terms-and-conditions";
  static String get distinguishedDegreePrivileges => "${_distinguishedOutsideUae}distinguished-doctors-scholarship-privileges";
  static String get distinguishedDegreeStudentObligations => "${_distinguishedOutsideUae}student-obligations-for-the-distinguished-doctors-scholarship";
  static String get distinguishedDegreeApplyingProcedure => "${_distinguishedOutsideUae}distinguished-doctors-scholarship-applying-procedures";
  static String get distinguishedDegreeMedicalLicensingExam => "${_distinguishedOutsideUae}medical-licensing-exams";

  static const String _bachelorOutsideUae = "${_scholarshipOutsideUae}bachelors-degree-scholarship/";
  static String get bachelorOutsideUaeTermsAndConditions => "${_bachelorOutsideUae}bachelor-s-degree-scholarship-admission-terms-and-conditions";
  static String get bachelorOutsideUaeScoAccredited => "${_bachelorOutsideUae}sco-accredited-universities-and-specializations-list";
  static String get bachelorOutsideUaeDegreePrivileges => "${_bachelorOutsideUae}bachelor-s-degree-scholarship-privileges";
  static String get bachelorOutsideUaeDegreeStudentObligations => "${_bachelorOutsideUae}student-obligations-for-the-bachelors-degree-scholarship";
  static String get bachelorOutsideUaeDegreeImportantGuidelines => "${_bachelorOutsideUae}important-guidelines-for-high-school-students";
  static String get bachelorOutsideUaeDegreeApplyingProcedure => "${_bachelorOutsideUae}bachelors-degree-applying-procedures";


  static const String _graduateOutsideUae = "${_scholarshipOutsideUae}graduate-studies-scholarship/";
  static String get graduateOutsideUaeTermsAndConditions => "${_graduateOutsideUae}graduate-studies-scholarship-admission-terms-and-conditions";
  static String get graduateOutsideUaeUniversityAndSpecializationList => "${_graduateOutsideUae}sco-accredited-universities-and-specializations-list";
  static String get graduateOutsideUaeDegreePrivileges => "${_graduateOutsideUae}graduate-studies-scholarship-privileges";
  static String get graduateOutsideUaeDegreeStudentObligations => "${_graduateOutsideUae}student-obligations-for-the-graduate-studies-scholarship";
  static String get graduateOutsideUaeDegreeApplyingProcedure => "${_graduateOutsideUae}graduate-studies-scholarship-applying-procedures";
//// ******************************************************** Urls for web view Start **********************************************************

}
