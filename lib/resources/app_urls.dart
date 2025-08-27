import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sco_v1/utils/key_constants.dart';



class AppUrls {


  /// ********** App Credentials Start **********///
  ///-[displayStagingBanner] Set to `true` to show a red STAGING banner.
  ///-[displayLanguageToggleButton]:
  ///     → `true`: Show language switch (Arabic <-> English)
  ///     → `false`: Lock app to Arabic only and hide change language buttons
  static const bool displayStagingBanner = true;
  static const bool displayLanguageToggleButton = true;
  /// ********** App Credentials End **********///





  AppUrls._internal();
  AppUrls instance = AppUrls._internal();

  // Domain URL fetched from environment
  static String get domainUrl => dotenv.env[KeyConstants.domainUrl] ?? '';

  // Base URL derived from the domain URL
  static String get baseUrl => "$domainUrl/o/mopa-sco-api/";



  static String get openAuthToken => "${baseUrl}sco-oauth/token";

  // Static getter for common data endpoint
  static String get commonData => "${baseUrl}common-data/list-of-values-data";

  //signup endpoint
  static String get signup => "${baseUrl}users/register";

  //login endpoint
  static String get login => "${baseUrl}users/login";

  // verify otp
  static String verifyOtp(userId,otp) => '${baseUrl}users/$userId/verifyMobile/$otp';

  // resend otp
  static String resendVerificationOtp(userId) => '${baseUrl}users/$userId/resend-verification-code';

  // accept user terms and conditions
  static String acceptUserTerms(userId) => '${baseUrl}users/$userId/update-user-agree-on-terms';

  // get security questions
  static String getSecurityQuestions(userId) => '${baseUrl}users/$userId/security-questions';

  // update security question
  static String updateSecurityQuestion(userId) => '${baseUrl}e-services/$userId/update-security-question';

  // get security question to forget password using email as param
  static String getForgotPasswordSecurityQuestionUsingEmail(email) => "${baseUrl}users/$email/security-question";

  // get otp for if forgot security question also
  static String getForgotSecurityQuestionVerificationOtp(userId) => '${baseUrl}users/$userId/forgot-sequrity-question-verification-code';

  // get user details especially user roles
  static String getUserDetails(userId) => '${baseUrl}users/$userId/user-details';

  /// change password with mopa-sco-api
  static String changePassword(String userId) => "${baseUrl}users/$userId/updatePassword";

  /// forgot password send on email
  static String sendForgotPasswordOnEmail(String userId) => "${baseUrl}users/$userId/reset-password-send";

  //faq's endpoint
  static String get faq => "${baseUrl}common-data/get-latest-article/71109/20126/0";

  //vision and mission endpoint
  static String get getPageContentByUrl => "${baseUrl}common-data/get-page-content";

  //contact us endpoint
  static String get contactUs => "${baseUrl}common-data/add-contact-us";

  //news and events endpoint
  static String get newsAndEvents => "${baseUrl}common-data/find-all-published-item/20126/true/false";

  //individual image endpoint
  static String get individualImage => "${baseUrl}common-data/get-image-url/";

  // get personal details
  static String  getPersonalDetails(userId) => '${baseUrl}self-service/personalInformation/$userId';

  // update profile details
  static String updateProfileDetails(userId) => '${baseUrl}self-service/personalInformation/$userId';

  // All Active scholarships endPoint
  static String get getAllActiveScholarships => "${baseUrl}common-data/find-all-active-scholarship";

  // find-draft-by-emirate-id-and-config-key
  static String  findDraftByConfigurationKey(userId,emiratesId,configKey)  => "${baseUrl}e-services/$userId/find-draft-by-emirate-id-and-config-key/$emiratesId/$configKey";

  // save draft
  static String saveDraft(userId,applicationNumber) => '${baseUrl}e-services/$userId/draft-application/$applicationNumber';

  // delete draft
  static String deleteDraft(userId,draftId)=>'${baseUrl}e-services/$userId/delete-draft/$draftId';

  // attach or upload file when filling application form
  static String attachFile(userId) => "${baseUrl}e-services/$userId/attach-file";

  // submit application
  static String submitApplication(userId) => "${baseUrl}e-services/$userId/submit-application";

  // get list of applications including draft,applied or submitted Method
  static String getApplicationsList(userId) => '${baseUrl}e-services/$userId/list-application-status';

  // get my scholarship
  static String getMyScholarship(userId) => '${baseUrl}self-service/myscholarship/$userId';

  // get my employment status
  static String getEmploymentStatus(userId) => '${baseUrl}e-services/$userId/my-employment-status';

  // create employmentStatus
  static String createEmploymentStatus(userId) => '${baseUrl}e-services/$userId/create-employment-status';

  // my finance status
  static String myFinanceStatus(userId) => '${baseUrl}e-services/$userId/my-finance-status';

  // get all requests
  static String getAllRequests(userId) => '${baseUrl}self-service/service-request/$userId/get-service-requests';

  // create request
  static String createRequest(userId) => '${baseUrl}self-service/service-request/$userId/add-service-request';

  // get my advisor
  static String getMyAdvisor(userId) => '${baseUrl}e-services/my-advisor/$userId';

  // get profile picture
  static String getProfilePicture(userId) => "${baseUrl}e-services/$userId/user-portrait";

  // get all notes
  static String getAllNotes(userId) => '${baseUrl}self-service/advisee/get-note-by-advisee/$userId';

  // get specific note details
  static String getSpecificNoteDetails(userId,noteId) => '${baseUrl}self-service/advisee/get-note-details/$userId/$noteId';

   // update specific note details
  static String addCommentToNote(userId,noteId) => '${baseUrl}self-service/advisee/$userId/update-note/$noteId';

   // update specific note details
  static String uploadAttachmentToNote(userId,noteId) => '${baseUrl}self-service/notes/$userId/upload-attachment/$noteId';

  // update request
  static String updateRequest(userId) => '${baseUrl}self-service/service-request/$userId/add-comment-exiting-request';

  // update employment status
  static String updateEmploymentStatus(userId) => '${baseUrl}e-services/$userId/update-employment-status';

  // get File content of the employment status files
  static String  getEmploymentStatusFileContent(userId)   => "${baseUrl}e-services/$userId/employment-status-file-content";

  // get File content of the Request files
  static String  getRequestFileContent(userId)   => "${baseUrl}self-service/$userId/service-request-file-content";

  // get File content of the Notes Attachment files
  static String  getUpdateNoteFileContent(userId)   => "${baseUrl}self-service/$userId/notes-file-content";

  // Update profile image size must be less then 200kb
  static String  updateProfilePicture(userId)  => "${baseUrl}e-services/$userId/update-user-portrait";

  /// get draft application by application number
  static String  getDraftApplicationByDraftId(userId,draftId) => "${baseUrl}e-services/$userId/fetch-by-application-id/$draftId";

  /// get submitted application by application number
  static String  getSubmittedApplicationDetailsByApplicationNumber(userId,applicationNumber) => "${baseUrl}e-services/$userId/find-by-application-number/$applicationNumber";

  /// get notification count
  static String  getNotificationsCount(userId) => "${baseUrl}e-services/$userId/user-notification-count";

  /// get all notifications
  static String  getAllNotifications(userId) => "${baseUrl}e-services/$userId/user-notification";

  ///  Decrease notifications count or mark notification as read
  static String  decreaseNotificationCount(userId) => "${baseUrl}e-services/$userId/marked-as-view";

  /// get people soft application
  static String getPeopleSoftApplication(userId,applicationNumber) => '${baseUrl}e-services/$userId/fetch-ps-application/$applicationNumber';

  /// get list of attachments
  static String getListOfAttachments(userId) => '${baseUrl}e-services/$userId/get-list-attachments';

  // update attachment
  static String updateAttachment(userId) => "${baseUrl}e-services/$userId/update-file";

  // upload attachment
  static String uploadAttachment(userId) => "${baseUrl}e-services/$userId/upload-file";

 // update employment history of people soft application
 static String updateEmploymentHistory(userId,applicationNumber) => '${baseUrl}e-services/$userId/update-ps-application/workexp/$applicationNumber';

  // update Education of people soft application
  static String updateEducation(userId,applicationNumber) => '${baseUrl}e-services/$userId/update-ps-application/education/$applicationNumber';

  // update required examinations of people soft application
  static String updateRequiredExaminations(userId,applicationNumber) => '${baseUrl}e-services/$userId/update-ps-application/update-test-score/$applicationNumber';

  // update university priority list of people soft application
  static String updateUniversityPriority(userId,applicationNumber) => '${baseUrl}e-services/$userId/update-ps-application/update-wish-list/$applicationNumber';


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
