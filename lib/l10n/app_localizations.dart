import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @idEmailOrMobile.
  ///
  /// In en, this message translates to:
  /// **'ID Number, Email or Mobile Number'**
  String get idEmailOrMobile;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @signInWithUaePass.
  ///
  /// In en, this message translates to:
  /// **'Sign in with UAE PASS'**
  String get signInWithUaePass;

  /// No description provided for @signUpWithUaePass.
  ///
  /// In en, this message translates to:
  /// **'Sign up with UAE PASS'**
  String get signUpWithUaePass;

  /// No description provided for @completeRegistration.
  ///
  /// In en, this message translates to:
  /// **'Please complete your registration process through SCO website.'**
  String get completeRegistration;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get readMore;

  /// No description provided for @scholarships.
  ///
  /// In en, this message translates to:
  /// **'Scholarships'**
  String get scholarships;

  /// No description provided for @scholarshipsInTheUAE.
  ///
  /// In en, this message translates to:
  /// **'Scholarships in the United Arab Emirates'**
  String get scholarshipsInTheUAE;

  /// No description provided for @scholarshipOffice.
  ///
  /// In en, this message translates to:
  /// **'Scholarship Office'**
  String get scholarshipOffice;

  /// No description provided for @aboutTheOrganization.
  ///
  /// In en, this message translates to:
  /// **'About the Organization'**
  String get aboutTheOrganization;

  /// No description provided for @certificates.
  ///
  /// In en, this message translates to:
  /// **'Certificates'**
  String get certificates;

  /// No description provided for @faqs.
  ///
  /// In en, this message translates to:
  /// **'FAQ\'s'**
  String get faqs;

  /// No description provided for @visionAndMission.
  ///
  /// In en, this message translates to:
  /// **'Vision & Mission'**
  String get visionAndMission;

  /// No description provided for @newsAndEvents.
  ///
  /// In en, this message translates to:
  /// **'News & Events'**
  String get newsAndEvents;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @contactNumber.
  ///
  /// In en, this message translates to:
  /// **'Contact Number'**
  String get contactNumber;

  /// No description provided for @emailId.
  ///
  /// In en, this message translates to:
  /// **'Email ID'**
  String get emailId;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @generalInformation.
  ///
  /// In en, this message translates to:
  /// **'General Information'**
  String get generalInformation;

  /// No description provided for @scholarship.
  ///
  /// In en, this message translates to:
  /// **'Scholarship'**
  String get scholarship;

  /// No description provided for @state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @information.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get information;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'SIGN UP'**
  String get signUp;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have account?'**
  String get dontHaveAccount;

  /// No description provided for @resetNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset New Password'**
  String get resetNewPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have account?'**
  String get alreadyHaveAccount;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'SIGN IN'**
  String get signIn;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @secondName.
  ///
  /// In en, this message translates to:
  /// **'Second Name'**
  String get secondName;

  /// No description provided for @thirdFourthName.
  ///
  /// In en, this message translates to:
  /// **'Third/Fourth Name'**
  String get thirdFourthName;

  /// No description provided for @familyName.
  ///
  /// In en, this message translates to:
  /// **'Family Name'**
  String get familyName;

  /// No description provided for @dob.
  ///
  /// In en, this message translates to:
  /// **'Date Of Birth'**
  String get dob;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @transgender.
  ///
  /// In en, this message translates to:
  /// **'Transgender'**
  String get transgender;

  /// No description provided for @confirmEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Confirm Email Address'**
  String get confirmEmailAddress;

  /// No description provided for @studentMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Student Mobile Number'**
  String get studentMobileNumber;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get userName;

  /// No description provided for @userType.
  ///
  /// In en, this message translates to:
  /// **'User Type'**
  String get userType;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @aBriefAboutSCO.
  ///
  /// In en, this message translates to:
  /// **'A Brief About SCO'**
  String get aBriefAboutSCO;

  /// No description provided for @visionMission.
  ///
  /// In en, this message translates to:
  /// **'Vision, Mission, Value and Goal'**
  String get visionMission;

  /// No description provided for @scoPrograms.
  ///
  /// In en, this message translates to:
  /// **'SCO Programs'**
  String get scoPrograms;

  /// No description provided for @news.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get news;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordTitle;

  /// No description provided for @pleaseEnterYourEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter your Email Address!'**
  String get pleaseEnterYourEmailAddress;

  /// No description provided for @fieldCantBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Field can\'t be empty'**
  String get fieldCantBeEmpty;

  /// No description provided for @invalidName.
  ///
  /// In en, this message translates to:
  /// **'Invalid name.\nOnly English and Arabic characters allowed.\nNo special characters, digits, or extra spaces.'**
  String get invalidName;

  /// No description provided for @emailCantBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Email can\'t be empty'**
  String get emailCantBeEmpty;

  /// No description provided for @invalidEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address.'**
  String get invalidEmailAddress;

  /// No description provided for @passwordCantBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Password can\'t be empty'**
  String get passwordCantBeEmpty;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long'**
  String get passwordTooShort;

  /// No description provided for @passwordUppercase.
  ///
  /// In en, this message translates to:
  /// **'Password must include at least one uppercase letter'**
  String get passwordUppercase;

  /// No description provided for @passwordLowercase.
  ///
  /// In en, this message translates to:
  /// **'Password must include at least one lowercase letter'**
  String get passwordLowercase;

  /// No description provided for @passwordDigit.
  ///
  /// In en, this message translates to:
  /// **'Password must include at least one digit'**
  String get passwordDigit;

  /// No description provided for @passwordSpecialCharacter.
  ///
  /// In en, this message translates to:
  /// **'Password must include at least one special character'**
  String get passwordSpecialCharacter;

  /// No description provided for @emirateIdCantBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Emirate ID can\'t be empty'**
  String get emirateIdCantBeEmpty;

  /// No description provided for @invalidEmirateId.
  ///
  /// In en, this message translates to:
  /// **'Invalid Emirate ID'**
  String get invalidEmirateId;

  /// No description provided for @phoneNumberCantBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Phone number can\'t be empty'**
  String get phoneNumberCantBeEmpty;

  /// No description provided for @invalidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number. It must contain only digits\nand can optionally start with a + sign.'**
  String get invalidPhoneNumber;

  /// No description provided for @enterFirstName.
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get enterFirstName;

  /// No description provided for @enterSecondName.
  ///
  /// In en, this message translates to:
  /// **'Enter your second name'**
  String get enterSecondName;

  /// No description provided for @enterThirdFourthName.
  ///
  /// In en, this message translates to:
  /// **'Enter your third/fourth name'**
  String get enterThirdFourthName;

  /// No description provided for @enterFamilyName.
  ///
  /// In en, this message translates to:
  /// **'Enter your family name or last name'**
  String get enterFamilyName;

  /// No description provided for @enterDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Enter your date of birth'**
  String get enterDateOfBirth;

  /// No description provided for @enterValidDay.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid day'**
  String get enterValidDay;

  /// No description provided for @enterValidMonth.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid month'**
  String get enterValidMonth;

  /// No description provided for @enterValidYear.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid year'**
  String get enterValidYear;

  /// No description provided for @enterGender.
  ///
  /// In en, this message translates to:
  /// **'Enter your gender'**
  String get enterGender;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get enterValidEmail;

  /// No description provided for @emailsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Emails do not match'**
  String get emailsDoNotMatch;

  /// No description provided for @enterCountry.
  ///
  /// In en, this message translates to:
  /// **'Enter your country'**
  String get enterCountry;

  /// No description provided for @enterValidEmiratesId.
  ///
  /// In en, this message translates to:
  /// **'Enter valid Emirates ID'**
  String get enterValidEmiratesId;

  /// No description provided for @enterValidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get enterValidPhoneNumber;

  /// No description provided for @enterValidPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid password (at least 8 characters)'**
  String get enterValidPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @answerCantBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Answer cannot be empty'**
  String get answerCantBeEmpty;

  /// No description provided for @invalidSecurityAnswer.
  ///
  /// In en, this message translates to:
  /// **'Invalid security answer'**
  String get invalidSecurityAnswer;

  /// No description provided for @securityQuestionSetup.
  ///
  /// In en, this message translates to:
  /// **'Security Question Setup'**
  String get securityQuestionSetup;

  /// No description provided for @securityQuestion.
  ///
  /// In en, this message translates to:
  /// **'Security Question'**
  String get securityQuestion;

  /// No description provided for @securityAnswer.
  ///
  /// In en, this message translates to:
  /// **'Security Answer'**
  String get securityAnswer;

  /// No description provided for @writeAnswer.
  ///
  /// In en, this message translates to:
  /// **'Write an answer'**
  String get writeAnswer;

  /// No description provided for @selectSecurityQuestion.
  ///
  /// In en, this message translates to:
  /// **'Select Security Question'**
  String get selectSecurityQuestion;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @writeSecurityAnswer.
  ///
  /// In en, this message translates to:
  /// **'Write Security Answer'**
  String get writeSecurityAnswer;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// No description provided for @otp_verification.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otp_verification;

  /// No description provided for @otp_verification_message.
  ///
  /// In en, this message translates to:
  /// **'We sent a verification code to your email.\nEnter the OTP code here!'**
  String get otp_verification_message;

  /// No description provided for @time_limit.
  ///
  /// In en, this message translates to:
  /// **'Time Limit 5 Minutes'**
  String get time_limit;

  /// No description provided for @resend_code.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resend_code;

  /// No description provided for @error_complete_profile.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please complete your profile through www.sco.ae'**
  String get error_complete_profile;

  /// No description provided for @acceptance_of_terms_through_use_heading.
  ///
  /// In en, this message translates to:
  /// **'Acceptance of Terms Through Use'**
  String get acceptance_of_terms_through_use_heading;

  /// No description provided for @acceptance_of_terms_through_use_points_p1.
  ///
  /// In en, this message translates to:
  /// **'The use of this site is considered acceptance of the terms and conditions contained therein.'**
  String get acceptance_of_terms_through_use_points_p1;

  /// No description provided for @acceptance_of_terms_through_use_points_p2.
  ///
  /// In en, this message translates to:
  /// **'The Office of Study Missions reserves the right to amend the conditions of use mentioned at any time.'**
  String get acceptance_of_terms_through_use_points_p2;

  /// No description provided for @acceptance_of_terms_through_use_points_p3.
  ///
  /// In en, this message translates to:
  /// **'Any amendments to these conditions will be announced on the site.'**
  String get acceptance_of_terms_through_use_points_p3;

  /// No description provided for @acceptance_of_terms_through_use_points_p4.
  ///
  /// In en, this message translates to:
  /// **'The responsibility for knowing the modifications rests with the user.'**
  String get acceptance_of_terms_through_use_points_p4;

  /// No description provided for @acceptance_of_terms_through_use_points_p5.
  ///
  /// In en, this message translates to:
  /// **'Continued use of the site after amendments is considered implicit acceptance of these changes.'**
  String get acceptance_of_terms_through_use_points_p5;

  /// No description provided for @copyright_heading.
  ///
  /// In en, this message translates to:
  /// **'Copyright'**
  String get copyright_heading;

  /// No description provided for @copyright_points_p1.
  ///
  /// In en, this message translates to:
  /// **'All copyrights on the website of the Office of Study Missions are subject to legal protection.'**
  String get copyright_points_p1;

  /// No description provided for @copyright_points_p2.
  ///
  /// In en, this message translates to:
  /// **'These rights are owned or licensed by the Office of Study Missions.'**
  String get copyright_points_p2;

  /// No description provided for @intellectual_property_rights_heading.
  ///
  /// In en, this message translates to:
  /// **'Intellectual Property Rights'**
  String get intellectual_property_rights_heading;

  /// No description provided for @intellectual_property_rights_points_p1.
  ///
  /// In en, this message translates to:
  /// **'All site contents are protected under intellectual property legislation, including copyrights, trademarks, service marks, and other rights.'**
  String get intellectual_property_rights_points_p1;

  /// No description provided for @intellectual_property_rights_points_p2.
  ///
  /// In en, this message translates to:
  /// **'The user agrees not to broadcast, display, execute, publish, amend, edit, or create derivative works from the site’s content without explicit permission.'**
  String get intellectual_property_rights_points_p2;

  /// No description provided for @intellectual_property_rights_points_p3.
  ///
  /// In en, this message translates to:
  /// **'The user may print or download a single copy of the site’s contents for personal, non-commercial use.'**
  String get intellectual_property_rights_points_p3;

  /// No description provided for @intellectual_property_rights_points_p4.
  ///
  /// In en, this message translates to:
  /// **'Retrieval of contents to create a database or directory without written permission is prohibited.'**
  String get intellectual_property_rights_points_p4;

  /// No description provided for @intellectual_property_rights_points_p5.
  ///
  /// In en, this message translates to:
  /// **'Use of site contents for any purpose not expressly permitted is also prohibited.'**
  String get intellectual_property_rights_points_p5;

  /// No description provided for @severability_of_provisions_heading.
  ///
  /// In en, this message translates to:
  /// **'Independence of Texts'**
  String get severability_of_provisions_heading;

  /// No description provided for @severability_of_provisions_points_p1.
  ///
  /// In en, this message translates to:
  /// **'If any condition is nullified for any reason, the nullity will apply only to that provision.'**
  String get severability_of_provisions_points_p1;

  /// No description provided for @severability_of_provisions_points_p2.
  ///
  /// In en, this message translates to:
  /// **'Other conditions on the site will remain in effect.'**
  String get severability_of_provisions_points_p2;

  /// No description provided for @severability_of_provisions_points_p3.
  ///
  /// In en, this message translates to:
  /// **'In case of conflict, special texts will override general texts.'**
  String get severability_of_provisions_points_p3;

  /// No description provided for @applicable_law_heading.
  ///
  /// In en, this message translates to:
  /// **'Applicable Law'**
  String get applicable_law_heading;

  /// No description provided for @applicable_law_points_p1.
  ///
  /// In en, this message translates to:
  /// **'The conditions are governed by the laws of the United Arab Emirates.'**
  String get applicable_law_points_p1;

  /// No description provided for @applicable_law_points_p2.
  ///
  /// In en, this message translates to:
  /// **'In case of a breach, the Office of Study Missions reserves the right to seek legal recourse.'**
  String get applicable_law_points_p2;

  /// No description provided for @applicable_law_points_p3.
  ///
  /// In en, this message translates to:
  /// **'Abu Dhabi courts have jurisdiction over any disputes.'**
  String get applicable_law_points_p3;

  /// No description provided for @governing_law_and_jurisdiction_heading.
  ///
  /// In en, this message translates to:
  /// **'Governing Law and Jurisdiction'**
  String get governing_law_and_jurisdiction_heading;

  /// No description provided for @governing_law_and_jurisdiction_points_p1.
  ///
  /// In en, this message translates to:
  /// **'The legislation of the United Arab Emirates applies to the use of the site and any disputes.'**
  String get governing_law_and_jurisdiction_points_p1;

  /// No description provided for @governing_law_and_jurisdiction_points_p2.
  ///
  /// In en, this message translates to:
  /// **'The courts of Abu Dhabi are responsible for resolving disputes related to the site.'**
  String get governing_law_and_jurisdiction_points_p2;

  /// No description provided for @disclaimer_heading.
  ///
  /// In en, this message translates to:
  /// **'Disclaimer'**
  String get disclaimer_heading;

  /// No description provided for @disclaimer_description.
  ///
  /// In en, this message translates to:
  /// **'The user acknowledges that the Scholarship Office does not bear any liability arising from direct or indirect damage, in accordance with the rules of contractual or tort liability, whether the damage is caused by the use of the site or the inability to use it.'**
  String get disclaimer_description;

  /// No description provided for @privacy_policy_heading.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy_heading;

  /// No description provided for @privacy_policy_heading_consent_to_use_of_information.
  ///
  /// In en, this message translates to:
  /// **'Consent to Use of Information'**
  String get privacy_policy_heading_consent_to_use_of_information;

  /// No description provided for @privacy_policy_description_consent_to_use_of_information.
  ///
  /// In en, this message translates to:
  /// **'By using the Scholarship Office\'s website, each user (browser) agrees to this Privacy Policy upon accessing the site and consents to the Scholarship Office collecting, using, or processing the information available to it.'**
  String get privacy_policy_description_consent_to_use_of_information;

  /// No description provided for @privacy_policy_heading_information_collection_and_disclosure_policies.
  ///
  /// In en, this message translates to:
  /// **'Information Collection and Disclosure Policies'**
  String
  get privacy_policy_heading_information_collection_and_disclosure_policies;

  /// No description provided for @privacy_policy_description_information_collection_and_disclosure_policies.
  ///
  /// In en, this message translates to:
  /// **'The Scholarship Office collects personal information such as name, address, and email when provided voluntarily by the user. The office may also collect additional information such as address, date of birth, and other personal details when users create an account or request services online. Additionally, the Scholarship Office\'s web service programs automatically collect statistical information about user visits, such as pages visited and browsers used, without linking this information to individual users (see information on \'cookies\' – the pages visited by the user).'**
  String
  get privacy_policy_description_information_collection_and_disclosure_policies;

  /// No description provided for @privacy_policy_heading_information_usage_and_disclosure_policies.
  ///
  /// In en, this message translates to:
  /// **'Information Usage and Disclosure Policies'**
  String get privacy_policy_heading_information_usage_and_disclosure_policies;

  /// No description provided for @privacy_policy_description_information_usage_and_disclosure_policies.
  ///
  /// In en, this message translates to:
  /// **'The Scholarship Office may use or disclose user information and other personal data collected from the office and its affiliates for functions such as user account services, report preparation, and other user activities.'**
  String
  get privacy_policy_description_information_usage_and_disclosure_policies;

  /// No description provided for @privacy_policy_heading_cookies.
  ///
  /// In en, this message translates to:
  /// **'Cookies'**
  String get privacy_policy_heading_cookies;

  /// No description provided for @privacy_policy_description_cookies.
  ///
  /// In en, this message translates to:
  /// **'A small data string written by the Scholarship Office\'s provider on the user\'s hard drive. This technology allows the office to enhance the website for more efficient use.'**
  String get privacy_policy_description_cookies;

  /// No description provided for @privacy_policy_heading_links.
  ///
  /// In en, this message translates to:
  /// **'Links'**
  String get privacy_policy_heading_links;

  /// No description provided for @privacy_policy_description_links.
  ///
  /// In en, this message translates to:
  /// **'This website contains links to other sites, and the Scholarship Office is not responsible for those links. Users are advised to review the privacy policies of those sites.'**
  String get privacy_policy_description_links;

  /// No description provided for @privacy_policy_heading_surveys.
  ///
  /// In en, this message translates to:
  /// **'Surveys'**
  String get privacy_policy_heading_surveys;

  /// No description provided for @privacy_policy_description_surveys.
  ///
  /// In en, this message translates to:
  /// **'The Scholarship Office may occasionally obtain information from users through surveys conducted by the office. Participation in these surveys is voluntary, and users can choose whether or not to disclose this information. Requested information may include contact details used for notifying results and may be used for monitoring or improving the site’s usage.'**
  String get privacy_policy_description_surveys;

  /// No description provided for @privacy_policy_heading_security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get privacy_policy_heading_security;

  /// No description provided for @privacy_policy_description_security.
  ///
  /// In en, this message translates to:
  /// **'The Scholarship Office takes necessary precautions to protect user information collected from the website. This information is protected whether online or offline, using encryption for sensitive online information and ensuring confidentiality in all cases.'**
  String get privacy_policy_description_security;

  /// No description provided for @privacy_policy_heading_notification_of_changes.
  ///
  /// In en, this message translates to:
  /// **'Notification of Changes'**
  String get privacy_policy_heading_notification_of_changes;

  /// No description provided for @privacy_policy_description_notification_of_changes.
  ///
  /// In en, this message translates to:
  /// **'If we decide to change our Privacy Policy, we will post those changes on our main page, ensuring users are always aware of the information we collect, how we use it, and under what circumstances.'**
  String get privacy_policy_description_notification_of_changes;

  /// No description provided for @privacy_policy_heading_updates_to_privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Updates to Privacy Policy'**
  String get privacy_policy_heading_updates_to_privacy_policy;

  /// No description provided for @privacy_policy_description_updates_to_privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'If the Scholarship Office updates the Privacy Policy, the updates will be made available on the main page of the Scholarship Office website for users to review.'**
  String get privacy_policy_description_updates_to_privacy_policy;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logout_success.
  ///
  /// In en, this message translates to:
  /// **'Logout success'**
  String get logout_success;

  /// No description provided for @answer_security_question.
  ///
  /// In en, this message translates to:
  /// **'Answer Security Question'**
  String get answer_security_question;

  /// No description provided for @forgot_security_question.
  ///
  /// In en, this message translates to:
  /// **'Forgot Security Question'**
  String get forgot_security_question;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password;

  /// No description provided for @generate_new_password.
  ///
  /// In en, this message translates to:
  /// **'Generate New Password'**
  String get generate_new_password;

  /// No description provided for @enter_correct_security_answer.
  ///
  /// In en, this message translates to:
  /// **'Enter Correct Security Answer'**
  String get enter_correct_security_answer;

  /// No description provided for @select_security_question.
  ///
  /// In en, this message translates to:
  /// **'Select Security Question'**
  String get select_security_question;

  /// No description provided for @write_security_answer.
  ///
  /// In en, this message translates to:
  /// **'Write Security Answer'**
  String get write_security_answer;

  /// No description provided for @security_question.
  ///
  /// In en, this message translates to:
  /// **'Security Question'**
  String get security_question;

  /// No description provided for @write_answer.
  ///
  /// In en, this message translates to:
  /// **'Write Answer'**
  String get write_answer;

  /// No description provided for @confirmation_title.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get confirmation_title;

  /// No description provided for @correct.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get correct;

  /// No description provided for @correct_message.
  ///
  /// In en, this message translates to:
  /// **'Password reset completed successfully. Please check your registered email for the new password.'**
  String get correct_message;

  /// No description provided for @wrong.
  ///
  /// In en, this message translates to:
  /// **'Wrong'**
  String get wrong;

  /// No description provided for @wrong_message.
  ///
  /// In en, this message translates to:
  /// **'Password reset unsuccessful. Please try again.'**
  String get wrong_message;

  /// No description provided for @click_here_to_login.
  ///
  /// In en, this message translates to:
  /// **'CLICK HERE TO LOGIN'**
  String get click_here_to_login;

  /// No description provided for @enterCaptcha.
  ///
  /// In en, this message translates to:
  /// **'Enter captcha'**
  String get enterCaptcha;

  /// No description provided for @pleaseEnterCaptcha.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Captcha'**
  String get pleaseEnterCaptcha;

  /// No description provided for @incorrectCaptcha.
  ///
  /// In en, this message translates to:
  /// **'Incorrect Captcha'**
  String get incorrectCaptcha;

  /// No description provided for @answerSecurityQuestion.
  ///
  /// In en, this message translates to:
  /// **'Answer Security Question'**
  String get answerSecurityQuestion;

  /// No description provided for @pleaseEnterCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter the 7 digit code sent to you on your email or mobile to verify your account.'**
  String get pleaseEnterCode;

  /// No description provided for @acceptTermsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Accept Terms and Conditions'**
  String get acceptTermsAndConditions;

  /// No description provided for @acceptAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Accept & Continue'**
  String get acceptAndContinue;

  /// No description provided for @acceptTermsError.
  ///
  /// In en, this message translates to:
  /// **'Accept Terms and Conditions First'**
  String get acceptTermsError;

  /// No description provided for @vision_mission_values.
  ///
  /// In en, this message translates to:
  /// **'Vision, Mission, Values'**
  String get vision_mission_values;

  /// No description provided for @error_fetching_data.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while fetching data.'**
  String get error_fetching_data;

  /// No description provided for @something_went_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong with your account. Please try again later or contact the administrator.'**
  String get something_went_wrong;

  /// No description provided for @password_sent_successfully.
  ///
  /// In en, this message translates to:
  /// **'Password sent successfully'**
  String get password_sent_successfully;

  /// No description provided for @otp_sent_successfully.
  ///
  /// In en, this message translates to:
  /// **'OTP sent successfully'**
  String get otp_sent_successfully;

  /// No description provided for @error_occurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while processing your request.'**
  String get error_occurred;

  /// No description provided for @nameCantBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Name can\'t be empty'**
  String get nameCantBeEmpty;

  /// No description provided for @mobileCantBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Mobile number can\'t be empty'**
  String get mobileCantBeEmpty;

  /// No description provided for @inquiryTypeCantBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Inquiry type can\'t be empty'**
  String get inquiryTypeCantBeEmpty;

  /// No description provided for @subjectCantBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Subject can\'t be empty'**
  String get subjectCantBeEmpty;

  /// No description provided for @messageCantBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Message can\'t be empty'**
  String get messageCantBeEmpty;

  /// No description provided for @captchaCantBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Captcha can\'t be empty'**
  String get captchaCantBeEmpty;

  /// No description provided for @captchaDoesNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Captcha does not match'**
  String get captchaDoesNotMatch;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @mobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get mobile;

  /// No description provided for @selectInquiryType.
  ///
  /// In en, this message translates to:
  /// **'Select Inquiry Type'**
  String get selectInquiryType;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'SEND'**
  String get send;

  /// No description provided for @writeToUs.
  ///
  /// In en, this message translates to:
  /// **'Write To Us'**
  String get writeToUs;

  /// No description provided for @poBox.
  ///
  /// In en, this message translates to:
  /// **'PO Box '**
  String get poBox;

  /// No description provided for @phoneNo.
  ///
  /// In en, this message translates to:
  /// **'Phone No: '**
  String get phoneNo;

  /// No description provided for @website.
  ///
  /// In en, this message translates to:
  /// **'Website: '**
  String get website;

  /// No description provided for @unitedArabEmirates.
  ///
  /// In en, this message translates to:
  /// **'United Arab Emirates - Abu Dhabi'**
  String get unitedArabEmirates;

  /// No description provided for @poBoxTapMessage.
  ///
  /// In en, this message translates to:
  /// **'PO Box tapped: '**
  String get poBoxTapMessage;

  /// No description provided for @phoneNo1.
  ///
  /// In en, this message translates to:
  /// **'Phone No 1'**
  String get phoneNo1;

  /// No description provided for @phoneNo2.
  ///
  /// In en, this message translates to:
  /// **'Phone No 2'**
  String get phoneNo2;

  /// No description provided for @webUrl.
  ///
  /// In en, this message translates to:
  /// **'https://www.sco.ae'**
  String get webUrl;

  /// No description provided for @phoneCallPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Phone call permission denied'**
  String get phoneCallPermissionDenied;

  /// No description provided for @invalidArabicName.
  ///
  /// In en, this message translates to:
  /// **'Invalid Arabic name. Please use only Arabic letters.'**
  String get invalidArabicName;

  /// No description provided for @invalidEnglishName.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid English name'**
  String get invalidEnglishName;

  /// No description provided for @apply_for_scholarship.
  ///
  /// In en, this message translates to:
  /// **'Apply for Scholarship'**
  String get apply_for_scholarship;

  /// No description provided for @my_scholarship.
  ///
  /// In en, this message translates to:
  /// **'My Scholarship'**
  String get my_scholarship;

  /// No description provided for @request.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get request;

  /// No description provided for @academic_advisor.
  ///
  /// In en, this message translates to:
  /// **'Academic Advisor'**
  String get academic_advisor;

  /// No description provided for @work_status.
  ///
  /// In en, this message translates to:
  /// **'Work Status'**
  String get work_status;

  /// No description provided for @finance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get finance;

  /// No description provided for @guidance_notes.
  ///
  /// In en, this message translates to:
  /// **'Guidance Notes'**
  String get guidance_notes;

  /// No description provided for @guidance_notes_unavailable.
  ///
  /// In en, this message translates to:
  /// **'No guidance notes available'**
  String get guidance_notes_unavailable;

  /// No description provided for @step.
  ///
  /// In en, this message translates to:
  /// **'Step'**
  String get step;

  /// No description provided for @englishNameAsPassport.
  ///
  /// In en, this message translates to:
  /// **'English name as per Passport'**
  String get englishNameAsPassport;

  /// No description provided for @arabicNameAsPassport.
  ///
  /// In en, this message translates to:
  /// **'Arabic name as per Passport'**
  String get arabicNameAsPassport;

  /// No description provided for @studentDetails.
  ///
  /// In en, this message translates to:
  /// **'Student Details'**
  String get studentDetails;

  /// No description provided for @familyInformation.
  ///
  /// In en, this message translates to:
  /// **'Family Information'**
  String get familyInformation;

  /// No description provided for @educationDetails.
  ///
  /// In en, this message translates to:
  /// **'Education Details'**
  String get educationDetails;

  /// No description provided for @employmentHistory.
  ///
  /// In en, this message translates to:
  /// **'Employment History'**
  String get employmentHistory;

  /// No description provided for @universityWishList.
  ///
  /// In en, this message translates to:
  /// **'Majors and Universities'**
  String get universityWishList;

  /// No description provided for @requiredExamination.
  ///
  /// In en, this message translates to:
  /// **'Required Examination'**
  String get requiredExamination;

  /// No description provided for @attachments.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get attachments;

  /// No description provided for @studentInformation.
  ///
  /// In en, this message translates to:
  /// **'Student Information'**
  String get studentInformation;

  /// No description provided for @nameAsPassport.
  ///
  /// In en, this message translates to:
  /// **'Name As Passport'**
  String get nameAsPassport;

  /// No description provided for @studentNameEnglish.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get studentNameEnglish;

  /// No description provided for @studentNameEnglishRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get studentNameEnglishRequired;

  /// No description provided for @studentNameEnglishWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter name'**
  String get studentNameEnglishWatermark;

  /// No description provided for @studentNameEnglishValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid name'**
  String get studentNameEnglishValidate;

  /// No description provided for @fatherNameEnglish.
  ///
  /// In en, this message translates to:
  /// **'Father\'s name'**
  String get fatherNameEnglish;

  /// No description provided for @fatherNameEnglishRequired.
  ///
  /// In en, this message translates to:
  /// **'Father\'s name is required'**
  String get fatherNameEnglishRequired;

  /// No description provided for @fatherNameEnglishWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter father\'s name'**
  String get fatherNameEnglishWatermark;

  /// No description provided for @fatherNameEnglishValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid father\'s name'**
  String get fatherNameEnglishValidate;

  /// No description provided for @grandfatherNameEnglish.
  ///
  /// In en, this message translates to:
  /// **'Grandfather\'s name'**
  String get grandfatherNameEnglish;

  /// No description provided for @grandfatherNameEnglishRequired.
  ///
  /// In en, this message translates to:
  /// **'Grandfather\'s name is required'**
  String get grandfatherNameEnglishRequired;

  /// No description provided for @grandfatherNameEnglishWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter grandfather\'s name'**
  String get grandfatherNameEnglishWatermark;

  /// No description provided for @grandfatherNameEnglishValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid grandfather\'s name'**
  String get grandfatherNameEnglishValidate;

  /// No description provided for @familyNameEnglish.
  ///
  /// In en, this message translates to:
  /// **'Family name'**
  String get familyNameEnglish;

  /// No description provided for @familyNameEnglishRequired.
  ///
  /// In en, this message translates to:
  /// **'Family name is required'**
  String get familyNameEnglishRequired;

  /// No description provided for @familyNameEnglishWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter family name'**
  String get familyNameEnglishWatermark;

  /// No description provided for @familyNameEnglishValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid family name'**
  String get familyNameEnglishValidate;

  /// No description provided for @studentNameArabic.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get studentNameArabic;

  /// No description provided for @studentNameArabicRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get studentNameArabicRequired;

  /// No description provided for @studentNameArabicWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter name'**
  String get studentNameArabicWatermark;

  /// No description provided for @studentNameArabicValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid name'**
  String get studentNameArabicValidate;

  /// No description provided for @fatherNameArabic.
  ///
  /// In en, this message translates to:
  /// **'Father\'s name'**
  String get fatherNameArabic;

  /// No description provided for @fatherNameArabicRequired.
  ///
  /// In en, this message translates to:
  /// **'Father\'s name is required'**
  String get fatherNameArabicRequired;

  /// No description provided for @fatherNameArabicWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter father\'s name'**
  String get fatherNameArabicWatermark;

  /// No description provided for @fatherNameArabicValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid father\'s name'**
  String get fatherNameArabicValidate;

  /// No description provided for @grandfatherNameArabic.
  ///
  /// In en, this message translates to:
  /// **'Grandfather\'s name'**
  String get grandfatherNameArabic;

  /// No description provided for @grandfatherNameArabicRequired.
  ///
  /// In en, this message translates to:
  /// **'Grandfather\'s name is required'**
  String get grandfatherNameArabicRequired;

  /// No description provided for @grandfatherNameArabicWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter grandfather\'s name'**
  String get grandfatherNameArabicWatermark;

  /// No description provided for @grandfatherNameArabicValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid grandfather\'s name'**
  String get grandfatherNameArabicValidate;

  /// No description provided for @familyNameArabic.
  ///
  /// In en, this message translates to:
  /// **'Family name'**
  String get familyNameArabic;

  /// No description provided for @familyNameArabicRequired.
  ///
  /// In en, this message translates to:
  /// **'Family name is required'**
  String get familyNameArabicRequired;

  /// No description provided for @familyNameArabicWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter family name'**
  String get familyNameArabicWatermark;

  /// No description provided for @familyNameArabicValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid family name'**
  String get familyNameArabicValidate;

  /// No description provided for @personalDetails.
  ///
  /// In en, this message translates to:
  /// **'Personal Details'**
  String get personalDetails;

  /// No description provided for @emiratesId.
  ///
  /// In en, this message translates to:
  /// **'Emirates Id'**
  String get emiratesId;

  /// No description provided for @emiratesIdRequired.
  ///
  /// In en, this message translates to:
  /// **'Emirates Id is required'**
  String get emiratesIdRequired;

  /// No description provided for @emiratesIdWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select emirates id'**
  String get emiratesIdWatermark;

  /// No description provided for @emiratesIdValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid emirates id'**
  String get emiratesIdValidate;

  /// No description provided for @brithDate.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get brithDate;

  /// No description provided for @brithDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Date of birth is required'**
  String get brithDateRequired;

  /// No description provided for @brithDateWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select date of birth'**
  String get brithDateWatermark;

  /// No description provided for @brithDateValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid date of birth'**
  String get brithDateValidate;

  /// No description provided for @birthPlace.
  ///
  /// In en, this message translates to:
  /// **'Place of birth'**
  String get birthPlace;

  /// No description provided for @birthPlaceRequired.
  ///
  /// In en, this message translates to:
  /// **'Place of birth is required'**
  String get birthPlaceRequired;

  /// No description provided for @birthPlaceWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter place of birth'**
  String get birthPlaceWatermark;

  /// No description provided for @birthPlaceValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid place of birth'**
  String get birthPlaceValidate;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @genderRequired.
  ///
  /// In en, this message translates to:
  /// **'Gender is required'**
  String get genderRequired;

  /// No description provided for @genderWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select gender'**
  String get genderWatermark;

  /// No description provided for @genderValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid gender'**
  String get genderValidate;

  /// No description provided for @maritalStatus.
  ///
  /// In en, this message translates to:
  /// **'Marital status'**
  String get maritalStatus;

  /// No description provided for @maritalStatusRequired.
  ///
  /// In en, this message translates to:
  /// **'Marital status is required'**
  String get maritalStatusRequired;

  /// No description provided for @maritalStatusWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select marital status'**
  String get maritalStatusWatermark;

  /// No description provided for @maritalStatusValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid marital status'**
  String get maritalStatusValidate;

  /// No description provided for @mobileNumberStudent.
  ///
  /// In en, this message translates to:
  /// **'Student mobile number'**
  String get mobileNumberStudent;

  /// No description provided for @mobileNumberStudentRequired.
  ///
  /// In en, this message translates to:
  /// **'Student mobile number is required'**
  String get mobileNumberStudentRequired;

  /// No description provided for @mobileNumberStudentWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter student mobile number'**
  String get mobileNumberStudentWatermark;

  /// No description provided for @mobileNumberStudentValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid student mobile number'**
  String get mobileNumberStudentValidate;

  /// No description provided for @emailAddressRequired.
  ///
  /// In en, this message translates to:
  /// **'Student email address is required'**
  String get emailAddressRequired;

  /// No description provided for @emailAddressWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter student email address'**
  String get emailAddressWatermark;

  /// No description provided for @emailAddressValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid student email address'**
  String get emailAddressValidate;

  /// No description provided for @passportInformation.
  ///
  /// In en, this message translates to:
  /// **'Passport Information'**
  String get passportInformation;

  /// No description provided for @passportNumber.
  ///
  /// In en, this message translates to:
  /// **'Passport number'**
  String get passportNumber;

  /// No description provided for @passportNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Passport number is required'**
  String get passportNumberRequired;

  /// No description provided for @passportNumberWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter passport number'**
  String get passportNumberWatermark;

  /// No description provided for @passportNumberValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid passport number'**
  String get passportNumberValidate;

  /// No description provided for @passportIssueDate.
  ///
  /// In en, this message translates to:
  /// **'Issue date'**
  String get passportIssueDate;

  /// No description provided for @passportIssueDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Issue date is required'**
  String get passportIssueDateRequired;

  /// No description provided for @passportIssueDateWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select issue date'**
  String get passportIssueDateWatermark;

  /// No description provided for @passportIssueDateValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid issue date'**
  String get passportIssueDateValidate;

  /// No description provided for @passportExpireDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry date'**
  String get passportExpireDate;

  /// No description provided for @passportExpireDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Expiry date is required'**
  String get passportExpireDateRequired;

  /// No description provided for @passportExpireDateWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select expiry date'**
  String get passportExpireDateWatermark;

  /// No description provided for @passportExpireDateValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid expiry date'**
  String get passportExpireDateValidate;

  /// No description provided for @passportPlaceofIssue.
  ///
  /// In en, this message translates to:
  /// **'Place of issue'**
  String get passportPlaceofIssue;

  /// No description provided for @passportPlaceofIssueRequired.
  ///
  /// In en, this message translates to:
  /// **'Place of issue is required'**
  String get passportPlaceofIssueRequired;

  /// No description provided for @passportPlaceofIssueWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter place of issue'**
  String get passportPlaceofIssueWatermark;

  /// No description provided for @passportPlaceofIssueValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid place of issue'**
  String get passportPlaceofIssueValidate;

  /// No description provided for @unifiedNumber.
  ///
  /// In en, this message translates to:
  /// **'Passport unified no'**
  String get unifiedNumber;

  /// No description provided for @unifiedNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Passport unified no is required'**
  String get unifiedNumberRequired;

  /// No description provided for @unifiedNumberWatermark.
  ///
  /// In en, this message translates to:
  /// **'Unified no on last page of passport'**
  String get unifiedNumberWatermark;

  /// No description provided for @unifiedNumberValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid passport unified no'**
  String get unifiedNumberValidate;

  /// No description provided for @addressDetails.
  ///
  /// In en, this message translates to:
  /// **'Address Details'**
  String get addressDetails;

  /// No description provided for @addressType.
  ///
  /// In en, this message translates to:
  /// **'Address type'**
  String get addressType;

  /// No description provided for @addressTypeRequired.
  ///
  /// In en, this message translates to:
  /// **'Address type is required'**
  String get addressTypeRequired;

  /// No description provided for @addressTypeWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select address type'**
  String get addressTypeWatermark;

  /// No description provided for @addressTypeValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid address type'**
  String get addressTypeValidate;

  /// No description provided for @addressLine1.
  ///
  /// In en, this message translates to:
  /// **'Address line 1'**
  String get addressLine1;

  /// No description provided for @addressLine1Required.
  ///
  /// In en, this message translates to:
  /// **'Address line 1 is required'**
  String get addressLine1Required;

  /// No description provided for @addressLine1Watermark.
  ///
  /// In en, this message translates to:
  /// **'Enter address line 1'**
  String get addressLine1Watermark;

  /// No description provided for @addressLine1Validate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid address line 1'**
  String get addressLine1Validate;

  /// No description provided for @addressLine2.
  ///
  /// In en, this message translates to:
  /// **'Address line 2'**
  String get addressLine2;

  /// No description provided for @addressLine2Required.
  ///
  /// In en, this message translates to:
  /// **'Address line 2 is required'**
  String get addressLine2Required;

  /// No description provided for @addressLine2Watermark.
  ///
  /// In en, this message translates to:
  /// **'Enter address line 2'**
  String get addressLine2Watermark;

  /// No description provided for @addressLine2Validate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid address line 2'**
  String get addressLine2Validate;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @countryRequired.
  ///
  /// In en, this message translates to:
  /// **'Country is required'**
  String get countryRequired;

  /// No description provided for @countryWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select country'**
  String get countryWatermark;

  /// No description provided for @countryValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid country'**
  String get countryValidate;

  /// No description provided for @emirates.
  ///
  /// In en, this message translates to:
  /// **'Emirates/States'**
  String get emirates;

  /// No description provided for @emiratesRequired.
  ///
  /// In en, this message translates to:
  /// **'Emirates/States is required'**
  String get emiratesRequired;

  /// No description provided for @emiratesWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select emirates/states'**
  String get emiratesWatermark;

  /// No description provided for @emiratesValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid emirates/states'**
  String get emiratesValidate;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @cityRequired.
  ///
  /// In en, this message translates to:
  /// **'City is required'**
  String get cityRequired;

  /// No description provided for @cityWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter city'**
  String get cityWatermark;

  /// No description provided for @cityValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid city'**
  String get cityValidate;

  /// No description provided for @pobox.
  ///
  /// In en, this message translates to:
  /// **'PO Box'**
  String get pobox;

  /// No description provided for @poboxRequired.
  ///
  /// In en, this message translates to:
  /// **'PO Box is required'**
  String get poboxRequired;

  /// No description provided for @poboxWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter PO Box'**
  String get poboxWatermark;

  /// No description provided for @poboxValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid PO Box'**
  String get poboxValidate;

  /// No description provided for @familyNumber.
  ///
  /// In en, this message translates to:
  /// **'Family book number'**
  String get familyNumber;

  /// No description provided for @familyNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Family book number is required'**
  String get familyNumberRequired;

  /// No description provided for @familyNumberWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter family book number'**
  String get familyNumberWatermark;

  /// No description provided for @familyNumberValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid family book number'**
  String get familyNumberValidate;

  /// No description provided for @numberOfTown.
  ///
  /// In en, this message translates to:
  /// **'Town\'s/Village\'s no'**
  String get numberOfTown;

  /// No description provided for @numberOfTownRequired.
  ///
  /// In en, this message translates to:
  /// **'Town\'s/Village\'s no is required'**
  String get numberOfTownRequired;

  /// No description provided for @numberOfTownWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter town\'s/village\'s no'**
  String get numberOfTownWatermark;

  /// No description provided for @numberOfTownValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid town\'s/village\'s no'**
  String get numberOfTownValidate;

  /// No description provided for @mobileNumberParent.
  ///
  /// In en, this message translates to:
  /// **'Parent/Guardian mobile number'**
  String get mobileNumberParent;

  /// No description provided for @mobileNumberParentRequired.
  ///
  /// In en, this message translates to:
  /// **'Parent/Guardian mobile number is required'**
  String get mobileNumberParentRequired;

  /// No description provided for @mobileNumberParentWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter parent/Guardian mobile number'**
  String get mobileNumberParentWatermark;

  /// No description provided for @mobileNumberParentValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid parent/Guardian mobile number'**
  String get mobileNumberParentValidate;

  /// No description provided for @homeNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get homeNumber;

  /// No description provided for @homeNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get homeNumberRequired;

  /// No description provided for @homeNumberWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get homeNumberWatermark;

  /// No description provided for @homeNumberValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid phone number'**
  String get homeNumberValidate;

  /// No description provided for @otherNumber.
  ///
  /// In en, this message translates to:
  /// **'Other phone number'**
  String get otherNumber;

  /// No description provided for @otherNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Other phone number is required'**
  String get otherNumberRequired;

  /// No description provided for @otherNumberWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter other phone number'**
  String get otherNumberWatermark;

  /// No description provided for @otherNumberValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid other phone number'**
  String get otherNumberValidate;

  /// No description provided for @parentName.
  ///
  /// In en, this message translates to:
  /// **'Parent/Guardian name'**
  String get parentName;

  /// No description provided for @parentNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Parent/Guardian name is required'**
  String get parentNameRequired;

  /// No description provided for @parentNameWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter parent/Guardian name'**
  String get parentNameWatermark;

  /// No description provided for @parentNameValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid parent/Guardian name'**
  String get parentNameValidate;

  /// No description provided for @relationType.
  ///
  /// In en, this message translates to:
  /// **'Relation type'**
  String get relationType;

  /// No description provided for @relationTypeRequired.
  ///
  /// In en, this message translates to:
  /// **'Relation type is required'**
  String get relationTypeRequired;

  /// No description provided for @relationTypeWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select relation type'**
  String get relationTypeWatermark;

  /// No description provided for @relationTypeValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid relation type'**
  String get relationTypeValidate;

  /// No description provided for @relativesInfo.
  ///
  /// In en, this message translates to:
  /// **'Relatives Information'**
  String get relativesInfo;

  /// No description provided for @relativesStudyingScholarship.
  ///
  /// In en, this message translates to:
  /// **'Do you have relatives studying in scholarship'**
  String get relativesStudyingScholarship;

  /// No description provided for @relativesStudyingScholarshipRequired.
  ///
  /// In en, this message translates to:
  /// **'Do you have relatives studying in scholarship is required'**
  String get relativesStudyingScholarshipRequired;

  /// No description provided for @relativesStudyingScholarshipWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select do you have relatives studying in scholarship'**
  String get relativesStudyingScholarshipWatermark;

  /// No description provided for @relativesStudyingScholarshipValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid do you have relatives studying in scholarship'**
  String get relativesStudyingScholarshipValidate;

  /// No description provided for @relativeName.
  ///
  /// In en, this message translates to:
  /// **'Relative Name'**
  String get relativeName;

  /// No description provided for @relativeNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Relative name is required'**
  String get relativeNameRequired;

  /// No description provided for @relativeNameWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter relative name'**
  String get relativeNameWatermark;

  /// No description provided for @relativeNameValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid relative name'**
  String get relativeNameValidate;

  /// No description provided for @university.
  ///
  /// In en, this message translates to:
  /// **'University'**
  String get university;

  /// No description provided for @universityRequired.
  ///
  /// In en, this message translates to:
  /// **'University is required'**
  String get universityRequired;

  /// No description provided for @universityWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select university'**
  String get universityWatermark;

  /// No description provided for @universityValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid university'**
  String get universityValidate;

  /// No description provided for @scholarshipTypeWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select scholarship type'**
  String get scholarshipTypeWatermark;

  /// No description provided for @scholarshipTypeValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid scholarship type'**
  String get scholarshipTypeValidate;

  /// No description provided for @internal.
  ///
  /// In en, this message translates to:
  /// **'Within UAE'**
  String get internal;

  /// No description provided for @external.
  ///
  /// In en, this message translates to:
  /// **'Abroad'**
  String get external;

  /// No description provided for @highSchoolDetails.
  ///
  /// In en, this message translates to:
  /// **'High School Details'**
  String get highSchoolDetails;

  /// No description provided for @highSchoolLevel.
  ///
  /// In en, this message translates to:
  /// **'High School Level'**
  String get highSchoolLevel;

  /// No description provided for @hsLevel.
  ///
  /// In en, this message translates to:
  /// **'High School Level'**
  String get hsLevel;

  /// No description provided for @hsLevelRequired.
  ///
  /// In en, this message translates to:
  /// **'High School Level is required'**
  String get hsLevelRequired;

  /// No description provided for @hsLevelWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select high school level'**
  String get hsLevelWatermark;

  /// No description provided for @hsLevelValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid high school level'**
  String get hsLevelValidate;

  /// No description provided for @hsName.
  ///
  /// In en, this message translates to:
  /// **'School name'**
  String get hsName;

  /// No description provided for @hsNameRequired.
  ///
  /// In en, this message translates to:
  /// **'School name is required'**
  String get hsNameRequired;

  /// No description provided for @hsNameWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter school name'**
  String get hsNameWatermark;

  /// No description provided for @hsNameValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid school name'**
  String get hsNameValidate;

  /// No description provided for @hsYearOfPassing.
  ///
  /// In en, this message translates to:
  /// **'Year of passing'**
  String get hsYearOfPassing;

  /// No description provided for @hsYearOfPassingRequired.
  ///
  /// In en, this message translates to:
  /// **'Year of passing is required'**
  String get hsYearOfPassingRequired;

  /// No description provided for @hsYearOfPassingWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select year of passing'**
  String get hsYearOfPassingWatermark;

  /// No description provided for @hsYearOfPassingValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid year of passing'**
  String get hsYearOfPassingValidate;

  /// No description provided for @hsType.
  ///
  /// In en, this message translates to:
  /// **'School type'**
  String get hsType;

  /// No description provided for @hsTypeRequired.
  ///
  /// In en, this message translates to:
  /// **'School type is required'**
  String get hsTypeRequired;

  /// No description provided for @hsTypeWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select school type'**
  String get hsTypeWatermark;

  /// No description provided for @hsTypeValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid school type'**
  String get hsTypeValidate;

  /// No description provided for @curriculumTypes.
  ///
  /// In en, this message translates to:
  /// **'Curriculum type'**
  String get curriculumTypes;

  /// No description provided for @curriculumTypesRequired.
  ///
  /// In en, this message translates to:
  /// **'Curriculum type is required'**
  String get curriculumTypesRequired;

  /// No description provided for @curriculumTypesWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select curriculum type'**
  String get curriculumTypesWatermark;

  /// No description provided for @curriculumTypesValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid curriculum type'**
  String get curriculumTypesValidate;

  /// No description provided for @subjectTypes.
  ///
  /// In en, this message translates to:
  /// **'Subject type'**
  String get subjectTypes;

  /// No description provided for @subjectTypesRequired.
  ///
  /// In en, this message translates to:
  /// **'Subject type is required'**
  String get subjectTypesRequired;

  /// No description provided for @subjectTypesWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select subject type'**
  String get subjectTypesWatermark;

  /// No description provided for @subjectTypesValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid subject type'**
  String get subjectTypesValidate;

  /// No description provided for @grade.
  ///
  /// In en, this message translates to:
  /// **'Grade/Percentage'**
  String get grade;

  /// No description provided for @gradeRequired.
  ///
  /// In en, this message translates to:
  /// **'Grade/Percentage is required'**
  String get gradeRequired;

  /// No description provided for @gradeWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter grade/percentage'**
  String get gradeWatermark;

  /// No description provided for @gradeValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid grade/percentage'**
  String get gradeValidate;

  /// No description provided for @scale.
  ///
  /// In en, this message translates to:
  /// **'Scale'**
  String get scale;

  /// No description provided for @scaleRequired.
  ///
  /// In en, this message translates to:
  /// **'Scale is required'**
  String get scaleRequired;

  /// No description provided for @scaleWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter scale'**
  String get scaleWatermark;

  /// No description provided for @scaleValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid scale'**
  String get scaleValidate;

  /// No description provided for @militaryServicePanel.
  ///
  /// In en, this message translates to:
  /// **'Military Services'**
  String get militaryServicePanel;

  /// No description provided for @militaryService.
  ///
  /// In en, this message translates to:
  /// **'Did you serve in military?'**
  String get militaryService;

  /// No description provided for @militaryServiceRequired.
  ///
  /// In en, this message translates to:
  /// **'Did you serve in military is required'**
  String get militaryServiceRequired;

  /// No description provided for @militaryServiceWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select did you serve in military'**
  String get militaryServiceWatermark;

  /// No description provided for @militaryServiceValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid did you serve in military'**
  String get militaryServiceValidate;

  /// No description provided for @militaryServiceStartDate.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get militaryServiceStartDate;

  /// No description provided for @militaryServiceStartDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Start date is required'**
  String get militaryServiceStartDateRequired;

  /// No description provided for @militaryServiceStartDateWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select start date'**
  String get militaryServiceStartDateWatermark;

  /// No description provided for @militaryServiceStartDateValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid start date'**
  String get militaryServiceStartDateValidate;

  /// No description provided for @militaryServiceEndDate.
  ///
  /// In en, this message translates to:
  /// **'End date'**
  String get militaryServiceEndDate;

  /// No description provided for @militaryServiceEndDateRequired.
  ///
  /// In en, this message translates to:
  /// **'End date is required'**
  String get militaryServiceEndDateRequired;

  /// No description provided for @militaryServiceEndDateWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select end date'**
  String get militaryServiceEndDateWatermark;

  /// No description provided for @militaryServiceEndDateValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid end date'**
  String get militaryServiceEndDateValidate;

  /// No description provided for @graduationDetails.
  ///
  /// In en, this message translates to:
  /// **'Graduation Details'**
  String get graduationDetails;

  /// No description provided for @hsGraduationLevel.
  ///
  /// In en, this message translates to:
  /// **'Graduation Level'**
  String get hsGraduationLevel;

  /// No description provided for @hsGraduationLevelRequired.
  ///
  /// In en, this message translates to:
  /// **'Graduation Level is required'**
  String get hsGraduationLevelRequired;

  /// No description provided for @hsGraduationLevelWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select graduation level'**
  String get hsGraduationLevelWatermark;

  /// No description provided for @hsGraduationLevelValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid graduation level'**
  String get hsGraduationLevelValidate;

  /// No description provided for @hsUniversity.
  ///
  /// In en, this message translates to:
  /// **'University'**
  String get hsUniversity;

  /// No description provided for @hsUniversityRequired.
  ///
  /// In en, this message translates to:
  /// **'University is required'**
  String get hsUniversityRequired;

  /// No description provided for @hsUniversityWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select university'**
  String get hsUniversityWatermark;

  /// No description provided for @hsUniversityValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid university'**
  String get hsUniversityValidate;

  /// No description provided for @hsOtherUniversity.
  ///
  /// In en, this message translates to:
  /// **'Other University'**
  String get hsOtherUniversity;

  /// No description provided for @hsOtherUniversityRequired.
  ///
  /// In en, this message translates to:
  /// **'Other University is required'**
  String get hsOtherUniversityRequired;

  /// No description provided for @hsOtherUniversityWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter other university'**
  String get hsOtherUniversityWatermark;

  /// No description provided for @hsOtherUniversityValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid other university'**
  String get hsOtherUniversityValidate;

  /// No description provided for @hsMajor.
  ///
  /// In en, this message translates to:
  /// **'Major'**
  String get hsMajor;

  /// No description provided for @hsMajorRequired.
  ///
  /// In en, this message translates to:
  /// **'Major is required'**
  String get hsMajorRequired;

  /// No description provided for @hsMajorWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter major'**
  String get hsMajorWatermark;

  /// No description provided for @hsMajorWatermark1.
  ///
  /// In en, this message translates to:
  /// **'Select major'**
  String get hsMajorWatermark1;

  /// No description provided for @hsMajorValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid major'**
  String get hsMajorValidate;

  /// No description provided for @cgpa.
  ///
  /// In en, this message translates to:
  /// **'CGPA'**
  String get cgpa;

  /// No description provided for @cgpaRequired.
  ///
  /// In en, this message translates to:
  /// **'CGPA is required'**
  String get cgpaRequired;

  /// No description provided for @cgpaWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter CGPA'**
  String get cgpaWatermark;

  /// No description provided for @cgpaValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid CGPA'**
  String get cgpaValidate;

  /// No description provided for @hsDateOfGraduation.
  ///
  /// In en, this message translates to:
  /// **'Year of Graduation'**
  String get hsDateOfGraduation;

  /// No description provided for @hsDateOfGraduationRequired.
  ///
  /// In en, this message translates to:
  /// **'Year of Graduation is required'**
  String get hsDateOfGraduationRequired;

  /// No description provided for @hsDateOfGraduationWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select year of Graduation'**
  String get hsDateOfGraduationWatermark;

  /// No description provided for @hsDateOfGraduationValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid year of Graduation'**
  String get hsDateOfGraduationValidate;

  /// No description provided for @hsSponsorship.
  ///
  /// In en, this message translates to:
  /// **'Sponsorship'**
  String get hsSponsorship;

  /// No description provided for @hsSponsorshipRequired.
  ///
  /// In en, this message translates to:
  /// **'Sponsorship is required'**
  String get hsSponsorshipRequired;

  /// No description provided for @hsSponsorshipWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter sponsorship'**
  String get hsSponsorshipWatermark;

  /// No description provided for @hsSponsorshipValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid sponsorship'**
  String get hsSponsorshipValidate;

  /// No description provided for @caseStudy.
  ///
  /// In en, this message translates to:
  /// **'Case Study'**
  String get caseStudy;

  /// No description provided for @caseStudyTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get caseStudyTitle;

  /// No description provided for @caseStudyTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Title is required'**
  String get caseStudyTitleRequired;

  /// No description provided for @caseStudyTitleWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter title'**
  String get caseStudyTitleWatermark;

  /// No description provided for @caseStudyTitleValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid title'**
  String get caseStudyTitleValidate;

  /// No description provided for @caseStudyStartYear.
  ///
  /// In en, this message translates to:
  /// **'Start year'**
  String get caseStudyStartYear;

  /// No description provided for @caseStudyStartYearRequired.
  ///
  /// In en, this message translates to:
  /// **'Start year is required'**
  String get caseStudyStartYearRequired;

  /// No description provided for @caseStudyStartYearWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select start year'**
  String get caseStudyStartYearWatermark;

  /// No description provided for @caseStudyStartYearValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid start year'**
  String get caseStudyStartYearValidate;

  /// No description provided for @caseStudyDescription.
  ///
  /// In en, this message translates to:
  /// **'Case study details'**
  String get caseStudyDescription;

  /// No description provided for @caseStudyDescriptionRequired.
  ///
  /// In en, this message translates to:
  /// **'Case study details is required'**
  String get caseStudyDescriptionRequired;

  /// No description provided for @caseStudyDescriptionWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter case study details'**
  String get caseStudyDescriptionWatermark;

  /// No description provided for @caseStudyDescriptionValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid case study details'**
  String get caseStudyDescriptionValidate;

  /// No description provided for @previouslyEmployed.
  ///
  /// In en, this message translates to:
  /// **'Previously employed'**
  String get previouslyEmployed;

  /// No description provided for @previouslyEmployedRequired.
  ///
  /// In en, this message translates to:
  /// **'Previously employed is required'**
  String get previouslyEmployedRequired;

  /// No description provided for @previouslyEmployedWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select previously employed'**
  String get previouslyEmployedWatermark;

  /// No description provided for @previouslyEmployedValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid previously employed'**
  String get previouslyEmployedValidate;

  /// No description provided for @employmentDetails.
  ///
  /// In en, this message translates to:
  /// **'Employment Details'**
  String get employmentDetails;

  /// No description provided for @emphistEmployerName.
  ///
  /// In en, this message translates to:
  /// **'Employer name'**
  String get emphistEmployerName;

  /// No description provided for @emphistEmployerNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Employer name is required'**
  String get emphistEmployerNameRequired;

  /// No description provided for @emphistEmployerNameWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter employer name'**
  String get emphistEmployerNameWatermark;

  /// No description provided for @emphistEmployerNameValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid employer name'**
  String get emphistEmployerNameValidate;

  /// No description provided for @emphistTitleName.
  ///
  /// In en, this message translates to:
  /// **'Designation'**
  String get emphistTitleName;

  /// No description provided for @emphistTitleNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Designation is required'**
  String get emphistTitleNameRequired;

  /// No description provided for @emphistTitleNameWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter designation'**
  String get emphistTitleNameWatermark;

  /// No description provided for @emphistTitleNameValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid designation'**
  String get emphistTitleNameValidate;

  /// No description provided for @emphistOccupationName.
  ///
  /// In en, this message translates to:
  /// **'Occupation'**
  String get emphistOccupationName;

  /// No description provided for @emphistOccupationNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Occupation is required'**
  String get emphistOccupationNameRequired;

  /// No description provided for @emphistOccupationNameWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter occupation'**
  String get emphistOccupationNameWatermark;

  /// No description provided for @emphistOccupationNameValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid occupation'**
  String get emphistOccupationNameValidate;

  /// No description provided for @emphistPlace.
  ///
  /// In en, this message translates to:
  /// **'Work place'**
  String get emphistPlace;

  /// No description provided for @emphistPlaceRequired.
  ///
  /// In en, this message translates to:
  /// **'Work place is required'**
  String get emphistPlaceRequired;

  /// No description provided for @emphistPlaceWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter work place'**
  String get emphistPlaceWatermark;

  /// No description provided for @emphistPlaceValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid work place'**
  String get emphistPlaceValidate;

  /// No description provided for @emphistReportingManager.
  ///
  /// In en, this message translates to:
  /// **'Reporting manager'**
  String get emphistReportingManager;

  /// No description provided for @emphistReportingManagerRequired.
  ///
  /// In en, this message translates to:
  /// **'Reporting manager is required'**
  String get emphistReportingManagerRequired;

  /// No description provided for @emphistReportingManagerWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter reporting manager'**
  String get emphistReportingManagerWatermark;

  /// No description provided for @emphistReportingManagerValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid reporting manager'**
  String get emphistReportingManagerValidate;

  /// No description provided for @emphistMgrContactNo.
  ///
  /// In en, this message translates to:
  /// **'Contact number'**
  String get emphistMgrContactNo;

  /// No description provided for @emphistMgrContactNoRequired.
  ///
  /// In en, this message translates to:
  /// **'Contact number is required'**
  String get emphistMgrContactNoRequired;

  /// No description provided for @emphistMgrContactNoWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter contact number'**
  String get emphistMgrContactNoWatermark;

  /// No description provided for @emphistMgrContactNoValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid contact number'**
  String get emphistMgrContactNoValidate;

  /// No description provided for @majorsYouWishToStudy.
  ///
  /// In en, this message translates to:
  /// **'The majors you wish to study at the university sorted according to priority'**
  String get majorsYouWishToStudy;

  /// No description provided for @studyWithinUAE.
  ///
  /// In en, this message translates to:
  /// **'Within UAE'**
  String get studyWithinUAE;

  /// No description provided for @studyWithinUAERequired.
  ///
  /// In en, this message translates to:
  /// **'Within UAE is required'**
  String get studyWithinUAERequired;

  /// No description provided for @studyWithinUAEWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter within UAE'**
  String get studyWithinUAEWatermark;

  /// No description provided for @studyWithinUAEValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid within UAE'**
  String get studyWithinUAEValidate;

  /// No description provided for @sr.
  ///
  /// In en, this message translates to:
  /// **'Sr. No'**
  String get sr;

  /// No description provided for @majors.
  ///
  /// In en, this message translates to:
  /// **'Majors'**
  String get majors;

  /// No description provided for @majorsRequired.
  ///
  /// In en, this message translates to:
  /// **'Majors is required'**
  String get majorsRequired;

  /// No description provided for @majorsWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select majors'**
  String get majorsWatermark;

  /// No description provided for @majorsValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid majors'**
  String get majorsValidate;

  /// No description provided for @universityNameIfOther.
  ///
  /// In en, this message translates to:
  /// **'Other University'**
  String get universityNameIfOther;

  /// No description provided for @universityNameIfOtherRequired.
  ///
  /// In en, this message translates to:
  /// **'Other University is required'**
  String get universityNameIfOtherRequired;

  /// No description provided for @universityNameIfOtherWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter other university'**
  String get universityNameIfOtherWatermark;

  /// No description provided for @universityNameIfOtherValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid other university'**
  String get universityNameIfOtherValidate;

  /// No description provided for @universityStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get universityStatus;

  /// No description provided for @universityStatusRequired.
  ///
  /// In en, this message translates to:
  /// **'Status is required'**
  String get universityStatusRequired;

  /// No description provided for @universityStatusWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select status'**
  String get universityStatusWatermark;

  /// No description provided for @universityStatusValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid status'**
  String get universityStatusValidate;

  /// No description provided for @examinationForUniversities.
  ///
  /// In en, this message translates to:
  /// **'Examination for universities - (IELTS, TOEFL, EMSAT, SAT, AP, etc)'**
  String get examinationForUniversities;

  /// No description provided for @examination.
  ///
  /// In en, this message translates to:
  /// **'Examination'**
  String get examination;

  /// No description provided for @examinationRequired.
  ///
  /// In en, this message translates to:
  /// **'Examination is required'**
  String get examinationRequired;

  /// No description provided for @examinationWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select examination'**
  String get examinationWatermark;

  /// No description provided for @examinationValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid examination'**
  String get examinationValidate;

  /// No description provided for @examinationType.
  ///
  /// In en, this message translates to:
  /// **'Examination type'**
  String get examinationType;

  /// No description provided for @examinationTypeRequired.
  ///
  /// In en, this message translates to:
  /// **'Examination type is required'**
  String get examinationTypeRequired;

  /// No description provided for @examinationTypeWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select examination type'**
  String get examinationTypeWatermark;

  /// No description provided for @examinationTypeValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid examination type'**
  String get examinationTypeValidate;

  /// No description provided for @examinationGrade.
  ///
  /// In en, this message translates to:
  /// **'Grade/Percentage'**
  String get examinationGrade;

  /// No description provided for @examinationGradeRequired.
  ///
  /// In en, this message translates to:
  /// **'Grade/Percentage is required'**
  String get examinationGradeRequired;

  /// No description provided for @examinationGradeWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter grade/percentage'**
  String get examinationGradeWatermark;

  /// No description provided for @examinationGradeValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid grade/percentage'**
  String get examinationGradeValidate;

  /// No description provided for @examinationDdsGrade.
  ///
  /// In en, this message translates to:
  /// **'Grade'**
  String get examinationDdsGrade;

  /// No description provided for @examinationDdsGradeRequired.
  ///
  /// In en, this message translates to:
  /// **'Grade'**
  String get examinationDdsGradeRequired;

  /// No description provided for @examinationDdsGradeWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter grade'**
  String get examinationDdsGradeWatermark;

  /// No description provided for @examinationDdsGradeValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid grade'**
  String get examinationDdsGradeValidate;

  /// No description provided for @dateExam.
  ///
  /// In en, this message translates to:
  /// **'Date of examination'**
  String get dateExam;

  /// No description provided for @dateExamRequired.
  ///
  /// In en, this message translates to:
  /// **'Date of examination is required'**
  String get dateExamRequired;

  /// No description provided for @dateExamWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select date of examination'**
  String get dateExamWatermark;

  /// No description provided for @dateExamValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid date of examination'**
  String get dateExamValidate;

  /// No description provided for @addMore.
  ///
  /// In en, this message translates to:
  /// **'Add more'**
  String get addMore;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @saveDraft.
  ///
  /// In en, this message translates to:
  /// **'Save Draft'**
  String get saveDraft;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @emphistFrom.
  ///
  /// In en, this message translates to:
  /// **'Employment Starts'**
  String get emphistFrom;

  /// No description provided for @emphistTo.
  ///
  /// In en, this message translates to:
  /// **'Employment Ends'**
  String get emphistTo;

  /// No description provided for @registrationForm.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get registrationForm;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// No description provided for @print.
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get print;

  /// No description provided for @invalidMilitaryDateSelection.
  ///
  /// In en, this message translates to:
  /// **'Invalid Start date/End date combination. Must be 16 month gap.'**
  String get invalidMilitaryDateSelection;

  /// No description provided for @contactInformation.
  ///
  /// In en, this message translates to:
  /// **'Phone Details'**
  String get contactInformation;

  /// No description provided for @registrationFirstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get registrationFirstName;

  /// No description provided for @registrationFirstNameWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter first name'**
  String get registrationFirstNameWatermark;

  /// No description provided for @registrationFirstNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter first name'**
  String get registrationFirstNameRequired;

  /// No description provided for @registrationFirstNameValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid first name'**
  String get registrationFirstNameValidate;

  /// No description provided for @registrationLastName.
  ///
  /// In en, this message translates to:
  /// **'Family name'**
  String get registrationLastName;

  /// No description provided for @registrationLastNameWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter family name'**
  String get registrationLastNameWatermark;

  /// No description provided for @registrationLastNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter family name'**
  String get registrationLastNameRequired;

  /// No description provided for @registrationLastNameValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid family name'**
  String get registrationLastNameValidate;

  /// No description provided for @registrationMiddleName.
  ///
  /// In en, this message translates to:
  /// **'Second name'**
  String get registrationMiddleName;

  /// No description provided for @registrationMiddleNameWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter second name'**
  String get registrationMiddleNameWatermark;

  /// No description provided for @registrationMiddleNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter second name'**
  String get registrationMiddleNameRequired;

  /// No description provided for @registrationMiddleNameValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid second name'**
  String get registrationMiddleNameValidate;

  /// No description provided for @registrationThirdName.
  ///
  /// In en, this message translates to:
  /// **'Third/Fourth name'**
  String get registrationThirdName;

  /// No description provided for @registrationThirdNameWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter third/fourth name'**
  String get registrationThirdNameWatermark;

  /// No description provided for @registrationThirdNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter third/fourth name'**
  String get registrationThirdNameRequired;

  /// No description provided for @registrationThirdNameValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid third/fourth name'**
  String get registrationThirdNameValidate;

  /// No description provided for @registrationEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get registrationEmailAddress;

  /// No description provided for @registrationEmailAddressRequired.
  ///
  /// In en, this message translates to:
  /// **'Email address is required'**
  String get registrationEmailAddressRequired;

  /// No description provided for @registrationEmailAddressWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter email address'**
  String get registrationEmailAddressWatermark;

  /// No description provided for @registrationEmailAddressValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid email address'**
  String get registrationEmailAddressValidate;

  /// No description provided for @registrationMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get registrationMobileNumber;

  /// No description provided for @registrationMobileNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Mobile number is required'**
  String get registrationMobileNumberRequired;

  /// No description provided for @registrationMobileNumberWatermark.
  ///
  /// In en, this message translates to:
  /// **'971###-####'**
  String get registrationMobileNumberWatermark;

  /// No description provided for @mobileHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number such as 971###-####'**
  String get mobileHint;

  /// No description provided for @registrationMobileNumberValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid mobile number'**
  String get registrationMobileNumberValidate;

  /// No description provided for @registrationConfEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Confirm email address'**
  String get registrationConfEmailAddress;

  /// No description provided for @registrationConfEmailAddressRequired.
  ///
  /// In en, this message translates to:
  /// **'Confirm email address is required'**
  String get registrationConfEmailAddressRequired;

  /// No description provided for @registrationConfEmailAddressWatermark.
  ///
  /// In en, this message translates to:
  /// **'Confirm enter email address'**
  String get registrationConfEmailAddressWatermark;

  /// No description provided for @registrationConfEmailAddressValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid confirm email address'**
  String get registrationConfEmailAddressValidate;

  /// No description provided for @registrationPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get registrationPassword;

  /// No description provided for @registrationPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get registrationPasswordRequired;

  /// No description provided for @registrationPasswordWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get registrationPasswordWatermark;

  /// No description provided for @registrationPasswordValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid password'**
  String get registrationPasswordValidate;

  /// No description provided for @registrationConfPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get registrationConfPassword;

  /// No description provided for @registrationConfPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Confirm password is required'**
  String get registrationConfPasswordRequired;

  /// No description provided for @registrationConfPasswordWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter confirm password'**
  String get registrationConfPasswordWatermark;

  /// No description provided for @registrationConfPasswordValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid confirm password'**
  String get registrationConfPasswordValidate;

  /// No description provided for @registrationMatchPassword.
  ///
  /// In en, this message translates to:
  /// **'Password and Confirm password are not matched.'**
  String get registrationMatchPassword;

  /// No description provided for @registrationMatchEmail.
  ///
  /// In en, this message translates to:
  /// **'Email and Confirm email are not matched.'**
  String get registrationMatchEmail;

  /// No description provided for @emiratesIdExists.
  ///
  /// In en, this message translates to:
  /// **'User account with this emirates id is already exists.'**
  String get emiratesIdExists;

  /// No description provided for @emailAddressExists.
  ///
  /// In en, this message translates to:
  /// **'User account with this email address already exists.'**
  String get emailAddressExists;

  /// No description provided for @phonenumberExists.
  ///
  /// In en, this message translates to:
  /// **'User account with this mobile number already exists.'**
  String get phonenumberExists;

  /// No description provided for @registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to register user, Please try again later.'**
  String get registrationFailed;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **''**
  String get error;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **''**
  String get info;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'LOGIN'**
  String get login;

  /// No description provided for @submissionPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get submissionPhoneNumber;

  /// No description provided for @submissionPhoneType.
  ///
  /// In en, this message translates to:
  /// **'Phone Type'**
  String get submissionPhoneType;

  /// No description provided for @submissionPhoneTypeRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone Type is required'**
  String get submissionPhoneTypeRequired;

  /// No description provided for @submissionCountryCode.
  ///
  /// In en, this message translates to:
  /// **'Country Code'**
  String get submissionCountryCode;

  /// No description provided for @submissionCountryCodeRequired.
  ///
  /// In en, this message translates to:
  /// **'Country Code is required'**
  String get submissionCountryCodeRequired;

  /// No description provided for @submissionPreferred.
  ///
  /// In en, this message translates to:
  /// **'Preferred'**
  String get submissionPreferred;

  /// No description provided for @submissionConfirmationMsg.
  ///
  /// In en, this message translates to:
  /// **'Are you sure? You want to submit this Application'**
  String get submissionConfirmationMsg;

  /// No description provided for @submissionConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get submissionConfirmation;

  /// No description provided for @submissionYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get submissionYes;

  /// No description provided for @submissionNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get submissionNo;

  /// No description provided for @submissionSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your application is submitted successfully, Your application is :'**
  String get submissionSuccessMessage;

  /// No description provided for @submissionErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Unable to submit the application, Please try again later.'**
  String get submissionErrorMessage;

  /// No description provided for @chooseFile.
  ///
  /// In en, this message translates to:
  /// **'Choose File'**
  String get chooseFile;

  /// No description provided for @applicationSubmission.
  ///
  /// In en, this message translates to:
  /// **'Application Submission'**
  String get applicationSubmission;

  /// No description provided for @phonenumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone no is required.'**
  String get phonenumberRequired;

  /// No description provided for @loginUsername.
  ///
  /// In en, this message translates to:
  /// **'Emirates Id or Email or Mobile'**
  String get loginUsername;

  /// No description provided for @loginUsernameWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter emirates id or email or Mobile'**
  String get loginUsernameWatermark;

  /// No description provided for @loginUsernameRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter emirates id or email or Mobile'**
  String get loginUsernameRequired;

  /// No description provided for @loginUserNotExists.
  ///
  /// In en, this message translates to:
  /// **'The email or phone number or emirates id you’ve entered doesn’t match any account.'**
  String get loginUserNotExists;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed, Invalid login details.'**
  String get loginFailed;

  /// No description provided for @highschoolSubjects.
  ///
  /// In en, this message translates to:
  /// **'Subject Details'**
  String get highschoolSubjects;

  /// No description provided for @highschoolSubjects2.
  ///
  /// In en, this message translates to:
  /// **''**
  String get highschoolSubjects2;

  /// No description provided for @nationality.
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get nationality;

  /// No description provided for @nationalityRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select the nationality'**
  String get nationalityRequired;

  /// No description provided for @nationalityWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select nationality'**
  String get nationalityWatermark;

  /// No description provided for @nationalId.
  ///
  /// In en, this message translates to:
  /// **'National Id'**
  String get nationalId;

  /// No description provided for @nationalIdRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter national id'**
  String get nationalIdRequired;

  /// No description provided for @nationalIdWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter national id'**
  String get nationalIdWatermark;

  /// No description provided for @userRegister.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get userRegister;

  /// No description provided for @passwordTooltip.
  ///
  /// In en, this message translates to:
  /// **'The password must consist of at least eight characters, and must contain as a minimum a number, a lowercase letter, an uppercase letter, and a special character such as (\$#&@)'**
  String get passwordTooltip;

  /// No description provided for @userAccountVerified.
  ///
  /// In en, this message translates to:
  /// **'You have successfully verified your account.'**
  String get userAccountVerified;

  /// No description provided for @proceedForLogin.
  ///
  /// In en, this message translates to:
  /// **'Please proceed for login as using below link'**
  String get proceedForLogin;

  /// No description provided for @clickHereToLogin.
  ///
  /// In en, this message translates to:
  /// **'click here for login'**
  String get clickHereToLogin;

  /// No description provided for @askForVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter the 7 digit code sent to you on your email or mobile to verify your account.'**
  String get askForVerificationCode;

  /// No description provided for @pageNotFound.
  ///
  /// In en, this message translates to:
  /// **'The page you trying to access is unavailable.'**
  String get pageNotFound;

  /// No description provided for @invalidCode.
  ///
  /// In en, this message translates to:
  /// **'The verification code you entered is invalid, Please enter correct the code.'**
  String get invalidCode;

  /// No description provided for @codeExpired.
  ///
  /// In en, this message translates to:
  /// **'The verification code you entered is expired, Please generate new code.'**
  String get codeExpired;

  /// No description provided for @codeStillValid.
  ///
  /// In en, this message translates to:
  /// **'New verification code is generate and sent to you, Please check the verification code on email or mobile.'**
  String get codeStillValid;

  /// No description provided for @unableToVerify.
  ///
  /// In en, this message translates to:
  /// **'Unable to verify user, Please try again after some time.'**
  String get unableToVerify;

  /// No description provided for @alreadyVerified.
  ///
  /// In en, this message translates to:
  /// **'Your account is already verified, Please login to access the system.'**
  String get alreadyVerified;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get verificationCode;

  /// No description provided for @resendVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Resend verification code'**
  String get resendVerificationCode;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @verificationCodeRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter verification code'**
  String get verificationCodeRequired;

  /// No description provided for @verificationCodeWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter verification code'**
  String get verificationCodeWatermark;

  /// No description provided for @numberValidator.
  ///
  /// In en, this message translates to:
  /// **'Only numbers are allowed'**
  String get numberValidator;

  /// No description provided for @onlyLoggedInUser.
  ///
  /// In en, this message translates to:
  /// **'The page you trying to access is only available for logged in user.'**
  String get onlyLoggedInUser;

  /// No description provided for @submissionConfigTitle.
  ///
  /// In en, this message translates to:
  /// **'Submission Configuration'**
  String get submissionConfigTitle;

  /// No description provided for @submissionformInvalidAccess.
  ///
  /// In en, this message translates to:
  /// **'The page you are trying to access is invalid.'**
  String get submissionformInvalidAccess;

  /// No description provided for @submissionformApplicaClosed.
  ///
  /// In en, this message translates to:
  /// **'Applications for the academic year is currently closed, and the registration date for the next batch will be announced on the website'**
  String get submissionformApplicaClosed;

  /// No description provided for @submissionformApplicaClosed2.
  ///
  /// In en, this message translates to:
  /// **'Start from'**
  String get submissionformApplicaClosed2;

  /// No description provided for @submissionformApplicaClosed3.
  ///
  /// In en, this message translates to:
  /// **'to'**
  String get submissionformApplicaClosed3;

  /// No description provided for @submissionConfigurationKey.
  ///
  /// In en, this message translates to:
  /// **'Configuration Key'**
  String get submissionConfigurationKey;

  /// No description provided for @submissionConfigurationKeyRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter configuration key'**
  String get submissionConfigurationKeyRequired;

  /// No description provided for @submissionConfigurationKeyWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter Configuration Key'**
  String get submissionConfigurationKeyWatermark;

  /// No description provided for @submissionConfigurationKeyValidator.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid Configuration Key'**
  String get submissionConfigurationKeyValidator;

  /// No description provided for @submissionSelect.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get submissionSelect;

  /// No description provided for @submissionAcadmicCareer.
  ///
  /// In en, this message translates to:
  /// **'Academic career'**
  String get submissionAcadmicCareer;

  /// No description provided for @submissionAcadmicCareerRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select Academic career'**
  String get submissionAcadmicCareerRequired;

  /// No description provided for @submissionAdmitTerm.
  ///
  /// In en, this message translates to:
  /// **'Admit term'**
  String get submissionAdmitTerm;

  /// No description provided for @submissionAdmitTermRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select admit term'**
  String get submissionAdmitTermRequired;

  /// No description provided for @submissionAdmitType.
  ///
  /// In en, this message translates to:
  /// **'Admit type'**
  String get submissionAdmitType;

  /// No description provided for @submissionAdmitTypeRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select admit type'**
  String get submissionAdmitTypeRequired;

  /// No description provided for @submissionAdmspplicationCenter.
  ///
  /// In en, this message translates to:
  /// **'Application center'**
  String get submissionAdmspplicationCenter;

  /// No description provided for @submissionAdmspplicationCenterRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select application center'**
  String get submissionAdmspplicationCenterRequired;

  /// No description provided for @submissionInstitution.
  ///
  /// In en, this message translates to:
  /// **'Institution'**
  String get submissionInstitution;

  /// No description provided for @submissionInstitutionRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select institution'**
  String get submissionInstitutionRequired;

  /// No description provided for @submissionAcademinProgram.
  ///
  /// In en, this message translates to:
  /// **'Academic program'**
  String get submissionAcademinProgram;

  /// No description provided for @submissionAcademinProgramRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select academic program'**
  String get submissionAcademinProgramRequired;

  /// No description provided for @submissionProgramStatus.
  ///
  /// In en, this message translates to:
  /// **'Program status'**
  String get submissionProgramStatus;

  /// No description provided for @submissionProgramStatusRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select program status'**
  String get submissionProgramStatusRequired;

  /// No description provided for @submissionProgramAction.
  ///
  /// In en, this message translates to:
  /// **'Program action'**
  String get submissionProgramAction;

  /// No description provided for @submissionProgramActionRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select program action'**
  String get submissionProgramActionRequired;

  /// No description provided for @submissionAcadloadappr.
  ///
  /// In en, this message translates to:
  /// **'Academic load'**
  String get submissionAcadloadappr;

  /// No description provided for @submissionAcadloadapprRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select Academic load'**
  String get submissionAcadloadapprRequired;

  /// No description provided for @submissionStartDate.
  ///
  /// In en, this message translates to:
  /// **'Submission Start Date'**
  String get submissionStartDate;

  /// No description provided for @submissionStartDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select start date'**
  String get submissionStartDateRequired;

  /// No description provided for @submissionStartDateWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select start date'**
  String get submissionStartDateWatermark;

  /// No description provided for @submissionStartDateValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid start date'**
  String get submissionStartDateValidate;

  /// No description provided for @submissionEndDate.
  ///
  /// In en, this message translates to:
  /// **'Submission End Date'**
  String get submissionEndDate;

  /// No description provided for @submissionEndDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select end date'**
  String get submissionEndDateRequired;

  /// No description provided for @submissionEndDateWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select end date'**
  String get submissionEndDateWatermark;

  /// No description provided for @submissionEndDateValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid end date'**
  String get submissionEndDateValidate;

  /// No description provided for @submissionCampus.
  ///
  /// In en, this message translates to:
  /// **'Campus'**
  String get submissionCampus;

  /// No description provided for @submissionCampusRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select campus.'**
  String get submissionCampusRequired;

  /// No description provided for @submissionConfigSuccess.
  ///
  /// In en, this message translates to:
  /// **'Configuration successfully saved.'**
  String get submissionConfigSuccess;

  /// No description provided for @submissionConfigFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save the configuration. Please check the data and submit again'**
  String get submissionConfigFailed;

  /// No description provided for @submissionPlan.
  ///
  /// In en, this message translates to:
  /// **'Academic Plan'**
  String get submissionPlan;

  /// No description provided for @submissionPlanRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select academic plan.'**
  String get submissionPlanRequired;

  /// No description provided for @pdFullname.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get pdFullname;

  /// No description provided for @profilePhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get profilePhoneNumber;

  /// No description provided for @formCitizenshipStatus.
  ///
  /// In en, this message translates to:
  /// **'Citizenship Status'**
  String get formCitizenshipStatus;

  /// No description provided for @formCitizenshipStatusRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select citizenship status'**
  String get formCitizenshipStatusRequired;

  /// No description provided for @mopaLoginUsernameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter email id or phone number or emirate id'**
  String get mopaLoginUsernameRequired;

  /// No description provided for @countryCode.
  ///
  /// In en, this message translates to:
  /// **'Country Code'**
  String get countryCode;

  /// No description provided for @applicationNumber.
  ///
  /// In en, this message translates to:
  /// **'Application Number'**
  String get applicationNumber;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @myScholarship.
  ///
  /// In en, this message translates to:
  /// **'My Scholarship'**
  String get myScholarship;

  /// No description provided for @myApplications.
  ///
  /// In en, this message translates to:
  /// **'My Application'**
  String get myApplications;

  /// No description provided for @myAccount.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get myAccount;

  /// No description provided for @profilePicsMaxSize.
  ///
  /// In en, this message translates to:
  /// **'Files larger than 5MB cannot be attached'**
  String get profilePicsMaxSize;

  /// No description provided for @myFinance.
  ///
  /// In en, this message translates to:
  /// **'My Finance'**
  String get myFinance;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @myRequests.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get myRequests;

  /// No description provided for @unsupportedProfileImage.
  ///
  /// In en, this message translates to:
  /// **'Unsupported files, only jpeg,jpg are allowed'**
  String get unsupportedProfileImage;

  /// No description provided for @unsupportedFileOnlyPdf.
  ///
  /// In en, this message translates to:
  /// **'Unsupported files, only pdf are allowed'**
  String get unsupportedFileOnlyPdf;

  /// No description provided for @unsupportedFiles.
  ///
  /// In en, this message translates to:
  /// **'Unsupported files, only jpeg,jpg,png and pdf are allowed'**
  String get unsupportedFiles;

  /// No description provided for @updateProfile.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get updateProfile;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @personaldetailSuccess.
  ///
  /// In en, this message translates to:
  /// **'User personal details updated successfully.'**
  String get personaldetailSuccess;

  /// No description provided for @personaldetailFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to updated user personal details.'**
  String get personaldetailFailed;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @duplicateAddresstypeMessage.
  ///
  /// In en, this message translates to:
  /// **'This address type already selected, Please Select another address type'**
  String get duplicateAddresstypeMessage;

  /// No description provided for @hsnameOther.
  ///
  /// In en, this message translates to:
  /// **'Other high school name'**
  String get hsnameOther;

  /// No description provided for @hsnameOtherRequired.
  ///
  /// In en, this message translates to:
  /// **'Other high school name is required'**
  String get hsnameOtherRequired;

  /// No description provided for @hsnameOtherWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter other high school name'**
  String get hsnameOtherWatermark;

  /// No description provided for @hsnameOtherValidate.
  ///
  /// In en, this message translates to:
  /// **'Enter valid other high school name'**
  String get hsnameOtherValidate;

  /// No description provided for @duplicateHsnameOtherMessage.
  ///
  /// In en, this message translates to:
  /// **'This school level is already selected, Please select any other school level'**
  String get duplicateHsnameOtherMessage;

  /// No description provided for @duplicateHsSubjectMessage.
  ///
  /// In en, this message translates to:
  /// **'This subject is already selected, Please select any other subject'**
  String get duplicateHsSubjectMessage;

  /// No description provided for @duplicateGraducationMessages.
  ///
  /// In en, this message translates to:
  /// **'This graduation level is already selected, Please select any other level'**
  String get duplicateGraducationMessages;

  /// No description provided for @duplicateExaminationMessage.
  ///
  /// In en, this message translates to:
  /// **'Combination of examination name and examination type already entered, Please select any other combination.'**
  String get duplicateExaminationMessage;

  /// No description provided for @curriculumAverage.
  ///
  /// In en, this message translates to:
  /// **'Curriculum average'**
  String get curriculumAverage;

  /// No description provided for @curriculumAverageRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter the curriculum average'**
  String get curriculumAverageRequired;

  /// No description provided for @curriculumAverageWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter the curriculum average'**
  String get curriculumAverageWatermark;

  /// No description provided for @curriculumAverageValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter the valid curriculum average. Combination of alphabets and numbers'**
  String get curriculumAverageValidate;

  /// No description provided for @curriculumScale.
  ///
  /// In en, this message translates to:
  /// **'Curriculum scale'**
  String get curriculumScale;

  /// No description provided for @curriculumScaleRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter curriculum scale'**
  String get curriculumScaleRequired;

  /// No description provided for @curriculumScaleWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter curriculum scale'**
  String get curriculumScaleWatermark;

  /// No description provided for @curriculumScaleValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter the valid curriculum scale. Combination of alphabets and numbers'**
  String get curriculumScaleValidate;

  /// No description provided for @subjecttypeDuplicate.
  ///
  /// In en, this message translates to:
  /// **'This subject type already added please select any other subject type.'**
  String get subjecttypeDuplicate;

  /// No description provided for @otherMajor.
  ///
  /// In en, this message translates to:
  /// **'Other major'**
  String get otherMajor;

  /// No description provided for @otherMajorRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter other major'**
  String get otherMajorRequired;

  /// No description provided for @otherMajorWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter other major'**
  String get otherMajorWatermark;

  /// No description provided for @otherMajorValidate.
  ///
  /// In en, this message translates to:
  /// **'Enter valid other major data'**
  String get otherMajorValidate;

  /// No description provided for @highestQualification.
  ///
  /// In en, this message translates to:
  /// **'Highest Qualification'**
  String get highestQualification;

  /// No description provided for @highestQualificationRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select highest qualification'**
  String get highestQualificationRequired;

  /// No description provided for @employmentStartDate.
  ///
  /// In en, this message translates to:
  /// **'Employment start date'**
  String get employmentStartDate;

  /// No description provided for @employmentStartDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select employment start date'**
  String get employmentStartDateRequired;

  /// No description provided for @employmentStartDateWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select start date'**
  String get employmentStartDateWatermark;

  /// No description provided for @employmentEndDate.
  ///
  /// In en, this message translates to:
  /// **'Employment end date'**
  String get employmentEndDate;

  /// No description provided for @employmentEndDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select employment end date'**
  String get employmentEndDateRequired;

  /// No description provided for @employmentEndDateWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select end date'**
  String get employmentEndDateWatermark;

  /// No description provided for @cohortTag.
  ///
  /// In en, this message translates to:
  /// **'Batch'**
  String get cohortTag;

  /// No description provided for @cohortTagRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select batch'**
  String get cohortTagRequired;

  /// No description provided for @scholarshipType.
  ///
  /// In en, this message translates to:
  /// **'Scholarship type'**
  String get scholarshipType;

  /// No description provided for @scholarshipTypeRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select scholarship type'**
  String get scholarshipTypeRequired;

  /// No description provided for @addresstypeDuplicate.
  ///
  /// In en, this message translates to:
  /// **'Duplicate address type found, only one address per address type is expected.'**
  String get addresstypeDuplicate;

  /// No description provided for @existingSubmissionFound.
  ///
  /// In en, this message translates to:
  /// **'We found your previous submitted record. Do you want to fill application with it?'**
  String get existingSubmissionFound;

  /// No description provided for @draftApplicationFound.
  ///
  /// In en, this message translates to:
  /// **'We found the draft version for your application, Do you want to proceed further with it?'**
  String get draftApplicationFound;

  /// No description provided for @draftSaveConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Draft saved successfully'**
  String get draftSaveConfirmation;

  /// No description provided for @draftSaveError.
  ///
  /// In en, this message translates to:
  /// **'Error in saving data as draft, Please try again later.'**
  String get draftSaveError;

  /// No description provided for @addRow.
  ///
  /// In en, this message translates to:
  /// **'Add Row'**
  String get addRow;

  /// No description provided for @deleteRow.
  ///
  /// In en, this message translates to:
  /// **'Delete Row'**
  String get deleteRow;

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get comments;

  /// No description provided for @commentsWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter comments'**
  String get commentsWatermark;

  /// No description provided for @unsavedatawarning.
  ///
  /// In en, this message translates to:
  /// **'Page have unsaved data. Do you still want to navigate?'**
  String get unsavedatawarning;

  /// No description provided for @hsGraducationStartDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get hsGraducationStartDate;

  /// No description provided for @hsGraducationStartDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select start date'**
  String get hsGraducationStartDateRequired;

  /// No description provided for @hsGraducationStartDateValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid start date'**
  String get hsGraducationStartDateValidate;

  /// No description provided for @hsGraducationStartDateWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter start date'**
  String get hsGraducationStartDateWatermark;

  /// No description provided for @hsGraducationEndDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get hsGraducationEndDate;

  /// No description provided for @hsGraducationEndDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select end date'**
  String get hsGraducationEndDateRequired;

  /// No description provided for @hsGraducationEndDateValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid end date'**
  String get hsGraducationEndDateValidate;

  /// No description provided for @hsGraducationEndDateWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter end date'**
  String get hsGraducationEndDateWatermark;

  /// No description provided for @currentlyStudying.
  ///
  /// In en, this message translates to:
  /// **'Currently Studying'**
  String get currentlyStudying;

  /// No description provided for @currentlyStudyingRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select currently studying'**
  String get currentlyStudyingRequired;

  /// No description provided for @lastTerm.
  ///
  /// In en, this message translates to:
  /// **'Last term'**
  String get lastTerm;

  /// No description provided for @lastTermRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select last term'**
  String get lastTermRequired;

  /// No description provided for @testscoreValidate.
  ///
  /// In en, this message translates to:
  /// **'Test score must be between'**
  String get testscoreValidate;

  /// No description provided for @testdateValidate.
  ///
  /// In en, this message translates to:
  /// **'Test date can not be before 2 years.'**
  String get testdateValidate;

  /// No description provided for @duplicateWishUniversity.
  ///
  /// In en, this message translates to:
  /// **'Selected university is already selected, Please select other university.'**
  String get duplicateWishUniversity;

  /// No description provided for @noDraftAvailable.
  ///
  /// In en, this message translates to:
  /// **'There is no draft available'**
  String get noDraftAvailable;

  /// No description provided for @savedApplication.
  ///
  /// In en, this message translates to:
  /// **'Previously saved scholarship application'**
  String get savedApplication;

  /// No description provided for @submitDraftScholarship.
  ///
  /// In en, this message translates to:
  /// **'Edit Draft'**
  String get submitDraftScholarship;

  /// No description provided for @deleteDraftApplication.
  ///
  /// In en, this message translates to:
  /// **'Delete Draft'**
  String get deleteDraftApplication;

  /// No description provided for @scholarshipDetails.
  ///
  /// In en, this message translates to:
  /// **'Scholarship Details'**
  String get scholarshipDetails;

  /// No description provided for @nameOfScholarship.
  ///
  /// In en, this message translates to:
  /// **'Scholarship Name'**
  String get nameOfScholarship;

  /// No description provided for @scholarshipStartDate.
  ///
  /// In en, this message translates to:
  /// **'Scholarship Start Date'**
  String get scholarshipStartDate;

  /// No description provided for @scholarshipEndDate.
  ///
  /// In en, this message translates to:
  /// **'Scholarship End Date'**
  String get scholarshipEndDate;

  /// No description provided for @scholarshipApprovedDate.
  ///
  /// In en, this message translates to:
  /// **'Approved Date'**
  String get scholarshipApprovedDate;

  /// No description provided for @programDuration.
  ///
  /// In en, this message translates to:
  /// **'Program Duration'**
  String get programDuration;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @duplicatePhoneType.
  ///
  /// In en, this message translates to:
  /// **'Selected phone type is already entered, Please select other phone type.'**
  String get duplicatePhoneType;

  /// No description provided for @draftApplication.
  ///
  /// In en, this message translates to:
  /// **'Draft Application'**
  String get draftApplication;

  /// No description provided for @submissionAgree.
  ///
  /// In en, this message translates to:
  /// **'I agree, All information is correct and filled properly'**
  String get submissionAgree;

  /// No description provided for @submissionAgreeRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select the agree'**
  String get submissionAgreeRequired;

  /// No description provided for @addRowPhone.
  ///
  /// In en, this message translates to:
  /// **'Add Phone'**
  String get addRowPhone;

  /// No description provided for @addRowAddress.
  ///
  /// In en, this message translates to:
  /// **'Add Address'**
  String get addRowAddress;

  /// No description provided for @addRowHighschool.
  ///
  /// In en, this message translates to:
  /// **'Add High School'**
  String get addRowHighschool;

  /// No description provided for @addRowGraduation.
  ///
  /// In en, this message translates to:
  /// **'Add Degree'**
  String get addRowGraduation;

  /// No description provided for @addRowMajor.
  ///
  /// In en, this message translates to:
  /// **'Add Major'**
  String get addRowMajor;

  /// No description provided for @addRowUniversity.
  ///
  /// In en, this message translates to:
  /// **'Add University'**
  String get addRowUniversity;

  /// No description provided for @addRowExamination.
  ///
  /// In en, this message translates to:
  /// **'Add Examination'**
  String get addRowExamination;

  /// No description provided for @deleteRowPhone.
  ///
  /// In en, this message translates to:
  /// **'Delete Phone'**
  String get deleteRowPhone;

  /// No description provided for @deleteRowAddress.
  ///
  /// In en, this message translates to:
  /// **'Delete address'**
  String get deleteRowAddress;

  /// No description provided for @deleteRowHighschool.
  ///
  /// In en, this message translates to:
  /// **'Delete High School'**
  String get deleteRowHighschool;

  /// No description provided for @deleteRowGraduation.
  ///
  /// In en, this message translates to:
  /// **'Delete Graduation'**
  String get deleteRowGraduation;

  /// No description provided for @deleteRowMajor.
  ///
  /// In en, this message translates to:
  /// **'Delete Major'**
  String get deleteRowMajor;

  /// No description provided for @deleteRowUniversity.
  ///
  /// In en, this message translates to:
  /// **'Delete University'**
  String get deleteRowUniversity;

  /// No description provided for @deleteRowExamination.
  ///
  /// In en, this message translates to:
  /// **'Delete Examination'**
  String get deleteRowExamination;

  /// No description provided for @emirateidExpiryDate.
  ///
  /// In en, this message translates to:
  /// **'Emirates Id Expiry Date'**
  String get emirateidExpiryDate;

  /// No description provided for @emirateidExpiryDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select emirates id expiry date'**
  String get emirateidExpiryDateRequired;

  /// No description provided for @emirateidExpiryDateWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter emirates id expiry date'**
  String get emirateidExpiryDateWatermark;

  /// No description provided for @duplicateMajorFound.
  ///
  /// In en, this message translates to:
  /// **'Selected major already added to wish list, Please add any other major'**
  String get duplicateMajorFound;

  /// No description provided for @loginHints.
  ///
  /// In en, this message translates to:
  /// **'Enter emirate id like 78419852341234... Phone number like 971####### or email id'**
  String get loginHints;

  /// No description provided for @internalBachelor.
  ///
  /// In en, this message translates to:
  /// **'Bachelor scholarship in UAE'**
  String get internalBachelor;

  /// No description provided for @internalPostgraduate.
  ///
  /// In en, this message translates to:
  /// **'Post graduation scholarship in UAE'**
  String get internalPostgraduate;

  /// No description provided for @internalMeterological.
  ///
  /// In en, this message translates to:
  /// **'Meterological scholarship in UAE'**
  String get internalMeterological;

  /// No description provided for @externalBachelor.
  ///
  /// In en, this message translates to:
  /// **'Bachelor scholarship outside UAE'**
  String get externalBachelor;

  /// No description provided for @universityAndMajor.
  ///
  /// In en, this message translates to:
  /// **'Universities and Majors'**
  String get universityAndMajor;

  /// No description provided for @externalPostgraduate.
  ///
  /// In en, this message translates to:
  /// **'Post graduation scholarship outside UAE'**
  String get externalPostgraduate;

  /// No description provided for @externalDoctors.
  ///
  /// In en, this message translates to:
  /// **'Distinguished Doctor'**
  String get externalDoctors;

  /// No description provided for @allowedFileTypePdf.
  ///
  /// In en, this message translates to:
  /// **'Select only pdf file'**
  String get allowedFileTypePdf;

  /// No description provided for @allowedFileTypeImage.
  ///
  /// In en, this message translates to:
  /// **'Select only image file with following jpeg,jpg extension'**
  String get allowedFileTypeImage;

  /// No description provided for @allowedFileTypeBoth.
  ///
  /// In en, this message translates to:
  /// **'Allowed file extensions are jpeg,jpg,png,pdf'**
  String get allowedFileTypeBoth;

  /// No description provided for @invalidGrade.
  ///
  /// In en, this message translates to:
  /// **'Please enter grade as A+, A, A-, or number between 1 to 100'**
  String get invalidGrade;

  /// No description provided for @draft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get draft;

  /// No description provided for @scholarshipInternal.
  ///
  /// In en, this message translates to:
  /// **'Internal Scholarship'**
  String get scholarshipInternal;

  /// No description provided for @scholarshipExternal.
  ///
  /// In en, this message translates to:
  /// **'External Scholarship'**
  String get scholarshipExternal;

  /// No description provided for @draftApplicationTitle.
  ///
  /// In en, this message translates to:
  /// **'Draft Application'**
  String get draftApplicationTitle;

  /// No description provided for @addRowRelativeInfo.
  ///
  /// In en, this message translates to:
  /// **'Add relative info'**
  String get addRowRelativeInfo;

  /// No description provided for @deleteRowRelativeInfo.
  ///
  /// In en, this message translates to:
  /// **'Delete relative info'**
  String get deleteRowRelativeInfo;

  /// No description provided for @majorWishlist.
  ///
  /// In en, this message translates to:
  /// **'Major Wish list'**
  String get majorWishlist;

  /// No description provided for @universityWishlist.
  ///
  /// In en, this message translates to:
  /// **'University Wish List'**
  String get universityWishlist;

  /// No description provided for @militaryReason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get militaryReason;

  /// No description provided for @militaryReasonRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter military reason'**
  String get militaryReasonRequired;

  /// No description provided for @militaryReasonWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter military reason'**
  String get militaryReasonWatermark;

  /// No description provided for @militaryReasonValidate.
  ///
  /// In en, this message translates to:
  /// **'Enter valid military reason'**
  String get militaryReasonValidate;

  /// No description provided for @hsYearOfGraduation.
  ///
  /// In en, this message translates to:
  /// **'Year of passing'**
  String get hsYearOfGraduation;

  /// No description provided for @hsYearOfGraduationRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select year of passing'**
  String get hsYearOfGraduationRequired;

  /// No description provided for @hsYearOfGraduationWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select year of passing'**
  String get hsYearOfGraduationWatermark;

  /// No description provided for @hsYearOfGraduationValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid year of passing'**
  String get hsYearOfGraduationValidate;

  /// No description provided for @postpond.
  ///
  /// In en, this message translates to:
  /// **'Postponed'**
  String get postpond;

  /// No description provided for @relief.
  ///
  /// In en, this message translates to:
  /// **'Relief or Exemption'**
  String get relief;

  /// No description provided for @otherSubject.
  ///
  /// In en, this message translates to:
  /// **'Other Subject'**
  String get otherSubject;

  /// No description provided for @otherSubjectRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select other subject type'**
  String get otherSubjectRequired;

  /// No description provided for @otherSubjectNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter other subject name'**
  String get otherSubjectNameRequired;

  /// No description provided for @otherSubjectNameValidate.
  ///
  /// In en, this message translates to:
  /// **'Enter valid other subject name, Max length is 25 char'**
  String get otherSubjectNameValidate;

  /// No description provided for @otherSubjectName.
  ///
  /// In en, this message translates to:
  /// **'Other subject name'**
  String get otherSubjectName;

  /// No description provided for @addOtherSubject.
  ///
  /// In en, this message translates to:
  /// **'Add other subject'**
  String get addOtherSubject;

  /// No description provided for @removeOtherSubject.
  ///
  /// In en, this message translates to:
  /// **'Delete other subject'**
  String get removeOtherSubject;

  /// No description provided for @familyEmirates.
  ///
  /// In en, this message translates to:
  /// **'Emirates'**
  String get familyEmirates;

  /// No description provided for @familyEmiratesRequired.
  ///
  /// In en, this message translates to:
  /// **'Emirates is required'**
  String get familyEmiratesRequired;

  /// No description provided for @familyEmiratesWatermark.
  ///
  /// In en, this message translates to:
  /// **'Select emirates'**
  String get familyEmiratesWatermark;

  /// No description provided for @familyEmiratesValidate.
  ///
  /// In en, this message translates to:
  /// **'Please select valid emirates'**
  String get familyEmiratesValidate;

  /// No description provided for @onlyChar.
  ///
  /// In en, this message translates to:
  /// **'Entered data is not valid, Please enter data without space, number or special character.'**
  String get onlyChar;

  /// No description provided for @charWithSpace.
  ///
  /// In en, this message translates to:
  /// **'Entered data is not valid, Please enter data without number or special character.'**
  String get charWithSpace;

  /// No description provided for @academicCareer.
  ///
  /// In en, this message translates to:
  /// **'Academic career'**
  String get academicCareer;

  /// No description provided for @onlyArabicOrEnglishChar.
  ///
  /// In en, this message translates to:
  /// **'Enter only English or Arabic character without number or special char. Space is not allowed at end.'**
  String get onlyArabicOrEnglishChar;

  /// No description provided for @englishOrArabicWithNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter only English or Arabic character with number. Space is not allowed at end.'**
  String get englishOrArabicWithNumber;

  /// No description provided for @onlyArabicChar.
  ///
  /// In en, this message translates to:
  /// **'Only Arabic character allowed and space is allowed. No digit, No special character and space is not allowed at end'**
  String get onlyArabicChar;

  /// No description provided for @onlyEnglishChar.
  ///
  /// In en, this message translates to:
  /// **'Only English character allowed and space is allowed. No digit, No special character and space is not allowed at end'**
  String get onlyEnglishChar;

  /// No description provided for @numberWithDecimal.
  ///
  /// In en, this message translates to:
  /// **'Only number with one decimal point is allowed. Space is not allowed at end'**
  String get numberWithDecimal;

  /// No description provided for @numberOnly.
  ///
  /// In en, this message translates to:
  /// **'Only number is allowed. No special character, no alphabets, no decimal point. Space is not allowed at end'**
  String get numberOnly;

  /// No description provided for @phoneNumberOnly.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid phone number, Phone number must not start with 0.'**
  String get phoneNumberOnly;

  /// No description provided for @englishNumberNoDecimal.
  ///
  /// In en, this message translates to:
  /// **'English character and number only allowed. No special character or decimal point. Space is not allowed at end'**
  String get englishNumberNoDecimal;

  /// No description provided for @arabicNumberNoDecimal.
  ///
  /// In en, this message translates to:
  /// **'Arabic character and number only allowed. No special character or decimal point. Space is not allowed at end'**
  String get arabicNumberNoDecimal;

  /// No description provided for @englishArabicNumberNoDecimal.
  ///
  /// In en, this message translates to:
  /// **'English/Arabic character and number only allowed. No special character or decimal point. Space is not allowed at end'**
  String get englishArabicNumberNoDecimal;

  /// No description provided for @top10Student.
  ///
  /// In en, this message translates to:
  /// **'Top 10 Student scholarship'**
  String get top10Student;

  /// No description provided for @internationalUndergraduateInternal.
  ///
  /// In en, this message translates to:
  /// **'Undergraduate International Scholarship Internal'**
  String get internationalUndergraduateInternal;

  /// No description provided for @internationalPostgraduateInternal.
  ///
  /// In en, this message translates to:
  /// **'Postgraduation International Scholarship Internal'**
  String get internationalPostgraduateInternal;

  /// No description provided for @internationalUndergraduateExternal.
  ///
  /// In en, this message translates to:
  /// **'Undergraduate International scholarship External'**
  String get internationalUndergraduateExternal;

  /// No description provided for @internationalPostgraduateExternal.
  ///
  /// In en, this message translates to:
  /// **'Postgraduation International Scholarship External'**
  String get internationalPostgraduateExternal;

  /// No description provided for @mopaEmployeeUndergraduate.
  ///
  /// In en, this message translates to:
  /// **'Under graduation Scholarship for MOPA Employees'**
  String get mopaEmployeeUndergraduate;

  /// No description provided for @mopaEmployeePostgraduate.
  ///
  /// In en, this message translates to:
  /// **'Postgraduation Scholarship for MOPA Employees'**
  String get mopaEmployeePostgraduate;

  /// No description provided for @mopaSubEmployeeUndergraduate.
  ///
  /// In en, this message translates to:
  /// **'User Graduation Scholarship for MOPA Subsidiary Organization Employees'**
  String get mopaSubEmployeeUndergraduate;

  /// No description provided for @mopaSubEmployeePostgraduate.
  ///
  /// In en, this message translates to:
  /// **'Post Graduation Scholarship for MOPA Subsidiary Organization Employee'**
  String get mopaSubEmployeePostgraduate;

  /// No description provided for @schoolScholarship.
  ///
  /// In en, this message translates to:
  /// **'Scholarship for school student'**
  String get schoolScholarship;

  /// No description provided for @ddsUniversity.
  ///
  /// In en, this message translates to:
  /// **'Hospital/University'**
  String get ddsUniversity;

  /// No description provided for @ddsUniversityRequired.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Hospital name'**
  String get ddsUniversityRequired;

  /// No description provided for @ddsUniversityWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter Hospital name'**
  String get ddsUniversityWatermark;

  /// No description provided for @ddsMajor.
  ///
  /// In en, this message translates to:
  /// **'Medical Specialists'**
  String get ddsMajor;

  /// No description provided for @ddsMajorRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter Medical Specialists'**
  String get ddsMajorRequired;

  /// No description provided for @ddsMajorWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter Medical Specialists'**
  String get ddsMajorWatermark;

  /// No description provided for @ddsMajorValidate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid Medical Specialists'**
  String get ddsMajorValidate;

  /// No description provided for @ddsExamination.
  ///
  /// In en, this message translates to:
  /// **'Medical Licensing Exams'**
  String get ddsExamination;

  /// No description provided for @ddsExaminationRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select Medical Licensing Exams'**
  String get ddsExaminationRequired;

  /// No description provided for @ddsWorkspace.
  ///
  /// In en, this message translates to:
  /// **'Hospital'**
  String get ddsWorkspace;

  /// No description provided for @fileComment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get fileComment;

  /// No description provided for @requestAttachfile.
  ///
  /// In en, this message translates to:
  /// **'Upload file'**
  String get requestAttachfile;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @fileName.
  ///
  /// In en, this message translates to:
  /// **'File name'**
  String get fileName;

  /// No description provided for @uploadAttachments.
  ///
  /// In en, this message translates to:
  /// **'Upload attachments'**
  String get uploadAttachments;

  /// No description provided for @uploadAttachmentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Attachments successfully uploaded'**
  String get uploadAttachmentSuccess;

  /// No description provided for @uploadAttachmentFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to upload attachments'**
  String get uploadAttachmentFailed;

  /// No description provided for @uploadInvalidFile.
  ///
  /// In en, this message translates to:
  /// **'Attach file is invalid, Please upload it again.'**
  String get uploadInvalidFile;

  /// No description provided for @studentId.
  ///
  /// In en, this message translates to:
  /// **'Student Id'**
  String get studentId;

  /// No description provided for @applicationType.
  ///
  /// In en, this message translates to:
  /// **'Application Type'**
  String get applicationType;

  /// No description provided for @addAttachment.
  ///
  /// In en, this message translates to:
  /// **'Add file'**
  String get addAttachment;

  /// No description provided for @emailDetails.
  ///
  /// In en, this message translates to:
  /// **'Email Details'**
  String get emailDetails;

  /// No description provided for @emailType.
  ///
  /// In en, this message translates to:
  /// **'Email Type'**
  String get emailType;

  /// No description provided for @emailTypeRequired.
  ///
  /// In en, this message translates to:
  /// **'Email Type is required'**
  String get emailTypeRequired;

  /// No description provided for @fileUploadSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'File uploaded successfully'**
  String get fileUploadSuccessfully;

  /// No description provided for @fileUploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to upload files'**
  String get fileUploadFailed;

  /// No description provided for @employmentStatusSuccess.
  ///
  /// In en, this message translates to:
  /// **'Employment status updated successfully'**
  String get employmentStatusSuccess;

  /// No description provided for @employmentStatusFailed.
  ///
  /// In en, this message translates to:
  /// **'Employment status updated failed'**
  String get employmentStatusFailed;

  /// No description provided for @employmentStatusDetails.
  ///
  /// In en, this message translates to:
  /// **'Employment Status Details'**
  String get employmentStatusDetails;

  /// No description provided for @employmentStatus.
  ///
  /// In en, this message translates to:
  /// **'Employment Status'**
  String get employmentStatus;

  /// No description provided for @employmentStatusRequired.
  ///
  /// In en, this message translates to:
  /// **'Employment Status'**
  String get employmentStatusRequired;

  /// No description provided for @addEmail.
  ///
  /// In en, this message translates to:
  /// **'Add email'**
  String get addEmail;

  /// No description provided for @noRecordFound.
  ///
  /// In en, this message translates to:
  /// **'No record found'**
  String get noRecordFound;

  /// No description provided for @examinationForDds.
  ///
  /// In en, this message translates to:
  /// **'Medical licensing examination'**
  String get examinationForDds;

  /// No description provided for @languageRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select default interface language'**
  String get languageRequired;

  /// No description provided for @clickHere.
  ///
  /// In en, this message translates to:
  /// **'Click Here'**
  String get clickHere;

  /// No description provided for @alreadyApplied.
  ///
  /// In en, this message translates to:
  /// **'You have already submitted application for this year.'**
  String get alreadyApplied;

  /// No description provided for @uploadPicture.
  ///
  /// In en, this message translates to:
  /// **'Upload Picture'**
  String get uploadPicture;

  /// No description provided for @countryAndUniversity.
  ///
  /// In en, this message translates to:
  /// **'Country - University'**
  String get countryAndUniversity;

  /// No description provided for @subscriberRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select the subscriber to send message'**
  String get subscriberRequired;

  /// No description provided for @inviteExpired.
  ///
  /// In en, this message translates to:
  /// **'We are sorry to inform you scholarships invites sent to you is expired.'**
  String get inviteExpired;

  /// No description provided for @submissionformInvitePresent.
  ///
  /// In en, this message translates to:
  /// **'You are invited for special scholarship, Please check your email/My Applications and apply for scholarship.'**
  String get submissionformInvitePresent;

  /// No description provided for @javaxPortletTitleApplicationSubmissionWarMopascoeservices.
  ///
  /// In en, this message translates to:
  /// **'Application Submission'**
  String get javaxPortletTitleApplicationSubmissionWarMopascoeservices;

  /// No description provided for @deleteDraftConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete Draft?'**
  String get deleteDraftConfirmation;

  /// No description provided for @emailNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Registered email address is not matching with invitation. Please try updating the registered email address.'**
  String get emailNotMatch;

  /// No description provided for @applicationUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Application Updated Successfully'**
  String get applicationUpdateSuccess;

  /// No description provided for @applicationUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to Updated Application'**
  String get applicationUpdateFailed;

  /// No description provided for @applicationUpdateConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure, You want to submit this request?'**
  String get applicationUpdateConfirm;

  /// No description provided for @failedToUpdateExistingRecord.
  ///
  /// In en, this message translates to:
  /// **'Unable to update the existing data, Please contact system admin'**
  String get failedToUpdateExistingRecord;

  /// No description provided for @failedToUpdateNewRecord.
  ///
  /// In en, this message translates to:
  /// **'Unable to add new, Please contact system admin'**
  String get failedToUpdateNewRecord;

  /// No description provided for @uaeMother.
  ///
  /// In en, this message translates to:
  /// **'Is Mother UAE National?'**
  String get uaeMother;

  /// No description provided for @examinationTitle2.
  ///
  /// In en, this message translates to:
  /// **'(IELTS/TOEFL/EMSAT/SAT/AP/etc)'**
  String get examinationTitle2;

  /// No description provided for @filenameSizeError.
  ///
  /// In en, this message translates to:
  /// **'Filename should not greater than 50 char, Please rename file and try again later.'**
  String get filenameSizeError;

  /// No description provided for @ddsOtherUniversityRequired.
  ///
  /// In en, this message translates to:
  /// **'Medical Specialists is required'**
  String get ddsOtherUniversityRequired;

  /// No description provided for @ddsOtherMajorRequired.
  ///
  /// In en, this message translates to:
  /// **'Hospital/University is required'**
  String get ddsOtherMajorRequired;

  /// No description provided for @studentGuidelineTitle.
  ///
  /// In en, this message translates to:
  /// **'إقرار وتعهّد الطالب المتقدّم للبعثة'**
  String get studentGuidelineTitle;

  /// No description provided for @stepSubmit.
  ///
  /// In en, this message translates to:
  /// **'ابدأ'**
  String get stepSubmit;

  /// No description provided for @titleStep.
  ///
  /// In en, this message translates to:
  /// **'Student undertaking'**
  String get titleStep;

  /// No description provided for @studentUndertakingRequired.
  ///
  /// In en, this message translates to:
  /// **'You cannot proceed with the application without the acknowledgement and undertaking.'**
  String get studentUndertakingRequired;

  /// No description provided for @studentUndertaking.
  ///
  /// In en, this message translates to:
  /// **'Student Undertaking'**
  String get studentUndertaking;

  /// No description provided for @documentUploaded.
  ///
  /// In en, this message translates to:
  /// **'Document Uploaded'**
  String get documentUploaded;

  /// No description provided for @requestAttachFile1.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get requestAttachFile1;

  /// No description provided for @scholarshipTypeInternal.
  ///
  /// In en, this message translates to:
  /// **'Scholarship In UAE'**
  String get scholarshipTypeInternal;

  /// No description provided for @scholarshipTypeExternal.
  ///
  /// In en, this message translates to:
  /// **'Scholarship Abroad'**
  String get scholarshipTypeExternal;

  /// No description provided for @scholarshipTypeInternalBachelor.
  ///
  /// In en, this message translates to:
  /// **'Bachelor\'s degree scholarship'**
  String get scholarshipTypeInternalBachelor;

  /// No description provided for @scholarshipTypeInternalMaster.
  ///
  /// In en, this message translates to:
  /// **'Graduate Studies Scholarship'**
  String get scholarshipTypeInternalMaster;

  /// No description provided for @scholarshipTypeInternalMeteorological.
  ///
  /// In en, this message translates to:
  /// **'Meteorological'**
  String get scholarshipTypeInternalMeteorological;

  /// No description provided for @scholarshipTypeExternalBachelor.
  ///
  /// In en, this message translates to:
  /// **'Bachelor\'s degree scholarship'**
  String get scholarshipTypeExternalBachelor;

  /// No description provided for @scholarshipTypeExternalMaster.
  ///
  /// In en, this message translates to:
  /// **'Graduate Studies Scholarship'**
  String get scholarshipTypeExternalMaster;

  /// No description provided for @scholarshipTypeExternalDds.
  ///
  /// In en, this message translates to:
  /// **'Distinguished Doctors Scholarship'**
  String get scholarshipTypeExternalDds;

  /// No description provided for @scholarshipApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get scholarshipApply;

  /// No description provided for @scholarshipTypeTitle.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get scholarshipTypeTitle;

  /// No description provided for @scholarshipSubTypeTitle.
  ///
  /// In en, this message translates to:
  /// **'Academic Career'**
  String get scholarshipSubTypeTitle;

  /// No description provided for @schoolCountry.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get schoolCountry;

  /// No description provided for @majorsWish1.
  ///
  /// In en, this message translates to:
  /// **'First Desire Major'**
  String get majorsWish1;

  /// No description provided for @majorsWish2.
  ///
  /// In en, this message translates to:
  /// **'Second Desire Major'**
  String get majorsWish2;

  /// No description provided for @majorsWish3.
  ///
  /// In en, this message translates to:
  /// **'Third Desire Major'**
  String get majorsWish3;

  /// No description provided for @managerEmail.
  ///
  /// In en, this message translates to:
  /// **'Manager Email'**
  String get managerEmail;

  /// No description provided for @ddsGraduationTitle.
  ///
  /// In en, this message translates to:
  /// **'Current academic year or university qualification'**
  String get ddsGraduationTitle;

  /// No description provided for @ddsGraduationTitle2.
  ///
  /// In en, this message translates to:
  /// **'Current academic year or university qualification'**
  String get ddsGraduationTitle2;

  /// No description provided for @ddsGradQuestion.
  ///
  /// In en, this message translates to:
  /// **'Are you currently receiving a scholarship or grant from another party?'**
  String get ddsGradQuestion;

  /// No description provided for @ddsGradQuestionRequired.
  ///
  /// In en, this message translates to:
  /// **'Please answer the above question.'**
  String get ddsGradQuestionRequired;

  /// No description provided for @ddsMajor1.
  ///
  /// In en, this message translates to:
  /// **'Program and specialization required'**
  String get ddsMajor1;

  /// No description provided for @ddsMajor1Required.
  ///
  /// In en, this message translates to:
  /// **'Please select the program'**
  String get ddsMajor1Required;

  /// No description provided for @ddsAcadProgram.
  ///
  /// In en, this message translates to:
  /// **'Program'**
  String get ddsAcadProgram;

  /// No description provided for @ddsUniversityWishlist.
  ///
  /// In en, this message translates to:
  /// **'University application and admission (for graduate doctors only)'**
  String get ddsUniversityWishlist;

  /// No description provided for @ddsExams.
  ///
  /// In en, this message translates to:
  /// **'To medical licensing exams (only for medical students or graduate doctors who have passed the first or second part of the licensing exam)'**
  String get ddsExams;

  /// No description provided for @ddsWishlist.
  ///
  /// In en, this message translates to:
  /// **'Doctor Wishlist'**
  String get ddsWishlist;

  /// No description provided for @studentGuidelineInternational.
  ///
  /// In en, this message translates to:
  /// **'\nأقرّ وأتعهّد أنا المتقدّم بطلب (بعثة/ منحة) دراسية إلى \"مكتب البعثات الدراسية\" بالعلم والالتزام بال آتي:\n\n1-صحّة ودقّة البيانات المقدّمة في هذا الطلب.\n\n2-تعبئة الحقول الإلزامية كافة، والحقول غير الإلزامية في حال توفّر البيانات والدرجات.\n\n3-إرفاق المستندات المطلوبة كافة على أن تكون سارية المفعول.\n\n4-سيتم رفض الطلب تلقائيًا في حال نقص (المستندات، البيانات، الدرجات)، وعدم دقّة الدرجات المُدخلة.\n\n5-اعتبار الطلب مُكتملًا بعد استلامي رسالة بنجاح تقديم الطلب وحصولي علي رقم الطلب.\n\n6-الإدلاء بالمعلومات المتعلّقة بالبعثات والمنح الدراسية كافة التي حصلت عليها من جهات أخرى.'**
  String get studentGuidelineInternational;

  /// No description provided for @studentGuidelineHchl.
  ///
  /// In en, this message translates to:
  /// **'\n\nأقرّ وأتعهّد أنا المتقدّم بطلب الالتحاق ببرنامج التحضير الجامعي لطلبة الصف العاشر والحادي عشر بالعلم والالتزام بالآتي:\n\n\n1-\tصحّة ودقّة البيانات وتعبئة الحقول الإلزامية كافة، والحقول غير الإلزامية في حال توفّر البيانات والدرجات، وارفاق مستندات سارية المفعول.\n\n2-\tسيتم رفض الطلب تلقائيًا في حال نقص (المستندات، البيانات، الدرجات)، وعدم دقّة الدرجات المُدخلة.\n\n<span style=\"color:red\">3-   سيتم رفض الطلب تلقائيا في حال التقديم لبرنامج آخر يختلف عن برنامج التحضير الجامعي المخصص لطلبة الصف العاشر والحادي عشر.</span>\n\n4-\tاعتبار الطلب مُكتملًا بعد استلامي رسالة بنجاح تقديم الطلب وحصولي علي رقم الطلب.\n\n5-\tعدم النظر في أيّ طلب حُفظ كمسوّدة بعد فترة التقديم.\n\n6-\tالإدلاء بالمعلومات المتعلّقة بالبعثات والمنح الدراسية وبرامج التحضير كافة التي حصلت عليها من جهات أخرى.\n\n7-\tعدم ضمان الموافقة عليهي الجاميه'**
  String get studentGuidelineHchl;

  /// No description provided for @studentGuideline.
  ///
  /// In en, this message translates to:
  /// **'\nأقرّ وأتعهّد أنا المتقدّم بطلب (بعثة/ منحة) دراسية إلى \"مكتب البعثات الدراسية\" بالعلم والالتزام بالآتي\\: \n\n1-\tصحّة ودقّة البيانات المقدّمة في هذا الطلب.\n\n2-\tتعبئة الحقول الإلزامية كافة، والحقول غير الإلزامية في حال توفّر البيانات والدرجات.\n\n3-\tإرفاق المستندات المطلوبة كافة على أن تكون سارية المفعول.\n\n4-\tسيتم رفض الطلب تلقاءيًا في حال نقص (المستندات، البيانات، الدرجات)، وعدم دقّة الدرجات المُدخلة.\n\n5-\tاعتبار الطلب مُكتملًا بعد استلامي رسالة بنجاح تقديم الطلب وحصولي علي رقم الطلب.\n\n6-\tعدم النظر في أيّ طلب حُفظ كمسوّدة بعد فترة التقديم.\n\n7-\tالإدلاء بالمعلومات المتعلّقة بالبعثات والمنح الدراسية كافة التي حصلت عليها من جهات أخرى.\n\n8-\tعدم ضمان الموافقة على الطلب بعد تقديمه؛ إذ يخضع للشروط والأحكام وتوفّر المقاعد، وتُعطى الأولوية للحاصلين على درجات مُتميّزة وقبول جامعي مُمكنة.\n\n9-\tالورود معتميزًًا للمتقدّمين في الجدول للجزء المطلوب للائلين. \n\n10-\tتاملي الدارة ووجودك بياناتك.'**
  String get studentGuideline;

  /// No description provided for @motherName.
  ///
  /// In en, this message translates to:
  /// **'Mother Name'**
  String get motherName;

  /// No description provided for @motherNameWatermMark.
  ///
  /// In en, this message translates to:
  /// **'Enter Mother Name'**
  String get motherNameWatermMark;

  /// No description provided for @motherNameValidate.
  ///
  /// In en, this message translates to:
  /// **'Mother name is Required'**
  String get motherNameValidate;

  /// No description provided for @pgrdMajorWishlist.
  ///
  /// In en, this message translates to:
  /// **'Major Wishlist'**
  String get pgrdMajorWishlist;

  /// No description provided for @pgrdAdacProgramRequired.
  ///
  /// In en, this message translates to:
  /// **'Academic Program Required'**
  String get pgrdAdacProgramRequired;

  /// No description provided for @pgrdAdacProgram.
  ///
  /// In en, this message translates to:
  /// **'Academic Program'**
  String get pgrdAdacProgram;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// No description provided for @frequentlyAskedQuestions.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get frequentlyAskedQuestions;

  /// No description provided for @emailInformation.
  ///
  /// In en, this message translates to:
  /// **'Email Information'**
  String get emailInformation;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @applicationStatus.
  ///
  /// In en, this message translates to:
  /// **'Application Status'**
  String get applicationStatus;

  /// No description provided for @applicationDetails.
  ///
  /// In en, this message translates to:
  /// **'Application Details'**
  String get applicationDetails;

  /// No description provided for @actions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actions;

  /// No description provided for @pleaseFillAllRequiredFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields'**
  String get pleaseFillAllRequiredFields;

  /// No description provided for @universityPreparationProgram.
  ///
  /// In en, this message translates to:
  /// **'University Preparation Program'**
  String get universityPreparationProgram;

  /// No description provided for @actuarialScience.
  ///
  /// In en, this message translates to:
  /// **'Actuarial Science Mission - Bachelor\'s Degree'**
  String get actuarialScience;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon...'**
  String get comingSoon;

  /// No description provided for @fileNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'File Not Available to Open'**
  String get fileNotAvailable;

  /// No description provided for @fetchingFileSize.
  ///
  /// In en, this message translates to:
  /// **'Fetching File Size...'**
  String get fetchingFileSize;

  /// No description provided for @editAddresses.
  ///
  /// In en, this message translates to:
  /// **'Edit Addresses'**
  String get editAddresses;

  /// No description provided for @submitApplication.
  ///
  /// In en, this message translates to:
  /// **'Submit an Application'**
  String get submitApplication;

  /// No description provided for @requestType.
  ///
  /// In en, this message translates to:
  /// **'Request Type'**
  String get requestType;

  /// No description provided for @major.
  ///
  /// In en, this message translates to:
  /// **'Major'**
  String get major;

  /// No description provided for @createRequest.
  ///
  /// In en, this message translates to:
  /// **'Create Request'**
  String get createRequest;

  /// No description provided for @createRequestUpperCase.
  ///
  /// In en, this message translates to:
  /// **'CREATE REQUEST'**
  String get createRequestUpperCase;

  /// No description provided for @searchHere.
  ///
  /// In en, this message translates to:
  /// **'Search Here...'**
  String get searchHere;

  /// No description provided for @searching.
  ///
  /// In en, this message translates to:
  /// **'Searching...'**
  String get searching;

  /// No description provided for @requestId.
  ///
  /// In en, this message translates to:
  /// **'Request Id'**
  String get requestId;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @requestSubType.
  ///
  /// In en, this message translates to:
  /// **'Request Sub Type'**
  String get requestSubType;

  /// No description provided for @requestDate.
  ///
  /// In en, this message translates to:
  /// **'Request Date'**
  String get requestDate;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @pleaseSelectRequestCategory.
  ///
  /// In en, this message translates to:
  /// **'Please Select Request Category'**
  String get pleaseSelectRequestCategory;

  /// No description provided for @pleaseSelectRequestType.
  ///
  /// In en, this message translates to:
  /// **'Please Select Request Type'**
  String get pleaseSelectRequestType;

  /// No description provided for @pleaseSelectRequestSubType.
  ///
  /// In en, this message translates to:
  /// **'Please Select Request Sub Type'**
  String get pleaseSelectRequestSubType;

  /// No description provided for @requestDetails.
  ///
  /// In en, this message translates to:
  /// **'Request Details'**
  String get requestDetails;

  /// No description provided for @requestStatus.
  ///
  /// In en, this message translates to:
  /// **'Request Status'**
  String get requestStatus;

  /// No description provided for @advisorId.
  ///
  /// In en, this message translates to:
  /// **'Advisor Id'**
  String get advisorId;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @meetingRequestButton.
  ///
  /// In en, this message translates to:
  /// **'MEETING REQUEST'**
  String get meetingRequestButton;

  /// No description provided for @salaryDetails.
  ///
  /// In en, this message translates to:
  /// **'Salary Details'**
  String get salaryDetails;

  /// No description provided for @bankName.
  ///
  /// In en, this message translates to:
  /// **'Bank Name'**
  String get bankName;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @theMonth.
  ///
  /// In en, this message translates to:
  /// **'The Month'**
  String get theMonth;

  /// No description provided for @deductionDetails.
  ///
  /// In en, this message translates to:
  /// **'Deduction Details'**
  String get deductionDetails;

  /// No description provided for @totalDeduction.
  ///
  /// In en, this message translates to:
  /// **'Total Deduction'**
  String get totalDeduction;

  /// No description provided for @totalDeducted.
  ///
  /// In en, this message translates to:
  /// **'Total Deducted'**
  String get totalDeducted;

  /// No description provided for @deductionPending.
  ///
  /// In en, this message translates to:
  /// **'Deduction Pending'**
  String get deductionPending;

  /// No description provided for @currencyCode.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currencyCode;

  /// No description provided for @bonusDetails.
  ///
  /// In en, this message translates to:
  /// **'Bonus Details'**
  String get bonusDetails;

  /// No description provided for @period.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get period;

  /// No description provided for @term.
  ///
  /// In en, this message translates to:
  /// **'Term'**
  String get term;

  /// No description provided for @warningDetails.
  ///
  /// In en, this message translates to:
  /// **'Warning Details'**
  String get warningDetails;

  /// No description provided for @certificateDescription.
  ///
  /// In en, this message translates to:
  /// **'Certificate Description'**
  String get certificateDescription;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @advisorsNotesList.
  ///
  /// In en, this message translates to:
  /// **'Advisors Notes List'**
  String get advisorsNotesList;

  /// No description provided for @noteId.
  ///
  /// In en, this message translates to:
  /// **'Note Id'**
  String get noteId;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @noteDetails.
  ///
  /// In en, this message translates to:
  /// **'Note Details'**
  String get noteDetails;

  /// No description provided for @institution.
  ///
  /// In en, this message translates to:
  /// **'Institution'**
  String get institution;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @subType.
  ///
  /// In en, this message translates to:
  /// **'Sub Type'**
  String get subType;

  /// No description provided for @contactType.
  ///
  /// In en, this message translates to:
  /// **'Contact Type'**
  String get contactType;

  /// No description provided for @noteStatus.
  ///
  /// In en, this message translates to:
  /// **'Note Status'**
  String get noteStatus;

  /// No description provided for @canAdviseeView.
  ///
  /// In en, this message translates to:
  /// **'Can Advisee View'**
  String get canAdviseeView;

  /// No description provided for @createdOn.
  ///
  /// In en, this message translates to:
  /// **'Created On'**
  String get createdOn;

  /// No description provided for @sNo.
  ///
  /// In en, this message translates to:
  /// **'S.No'**
  String get sNo;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @dueDate.
  ///
  /// In en, this message translates to:
  /// **'Due Date'**
  String get dueDate;

  /// No description provided for @updateAdvisorNote.
  ///
  /// In en, this message translates to:
  /// **'Update Advisor Note'**
  String get updateAdvisorNote;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @addComment.
  ///
  /// In en, this message translates to:
  /// **'Add Comment'**
  String get addComment;

  /// No description provided for @createdBy.
  ///
  /// In en, this message translates to:
  /// **'Created By'**
  String get createdBy;

  /// No description provided for @notificationCenter.
  ///
  /// In en, this message translates to:
  /// **'Notification Center'**
  String get notificationCenter;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @notificationDetails.
  ///
  /// In en, this message translates to:
  /// **'Notification Details'**
  String get notificationDetails;

  /// No description provided for @notificationType.
  ///
  /// In en, this message translates to:
  /// **'Notification Type'**
  String get notificationType;

  /// No description provided for @importance.
  ///
  /// In en, this message translates to:
  /// **'Importance'**
  String get importance;

  /// No description provided for @announcement.
  ///
  /// In en, this message translates to:
  /// **'Announcement'**
  String get announcement;

  /// No description provided for @salary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get salary;

  /// No description provided for @deduction.
  ///
  /// In en, this message translates to:
  /// **'Deduction'**
  String get deduction;

  /// No description provided for @bonus.
  ///
  /// In en, this message translates to:
  /// **'Bonus'**
  String get bonus;

  /// No description provided for @requests.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get requests;

  /// No description provided for @totalNumberOfRequests.
  ///
  /// In en, this message translates to:
  /// **'Total Number of Requests'**
  String get totalNumberOfRequests;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @talkToMyAdvisor.
  ///
  /// In en, this message translates to:
  /// **'Talk to My Advisor'**
  String get talkToMyAdvisor;

  /// No description provided for @youCanSeeListOfAdvisors.
  ///
  /// In en, this message translates to:
  /// **'You can see the list of advisors'**
  String get youCanSeeListOfAdvisors;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get service;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @aboutSCO.
  ///
  /// In en, this message translates to:
  /// **'About SCO'**
  String get aboutSCO;

  /// No description provided for @registrationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your account is successfully registered.'**
  String get registrationSuccess;

  /// No description provided for @chooseOption.
  ///
  /// In en, this message translates to:
  /// **'Choose an Option'**
  String get chooseOption;

  /// No description provided for @imageSizeLimit.
  ///
  /// In en, this message translates to:
  /// **'Image size must be within 200kb'**
  String get imageSizeLimit;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No Data Available.'**
  String get noData;

  /// No description provided for @phoneNumberAlreadyEntered.
  ///
  /// In en, this message translates to:
  /// **'Phone Number already Entered'**
  String get phoneNumberAlreadyEntered;

  /// No description provided for @personalDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Details'**
  String get personalDetailsTitle;

  /// No description provided for @employmentStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Employment Status'**
  String get employmentStatusTitle;

  /// No description provided for @youDontHaveDraft.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have previous drafts'**
  String get youDontHaveDraft;

  /// No description provided for @noApplication.
  ///
  /// In en, this message translates to:
  /// **'You have not applied for any application'**
  String get noApplication;

  /// No description provided for @internalScholarshipDesc.
  ///
  /// In en, this message translates to:
  /// **'The Scholarship Office, through the \'Internal Scholarship Program,\' aims to provide an opportunity for outstanding national students to enroll in private universities and higher education institutions within the country, in accordance with the standards adopted by the \'Scholarship System\' at the office.'**
  String get internalScholarshipDesc;

  /// No description provided for @externalScholarshipDesc.
  ///
  /// In en, this message translates to:
  /// **'The President\'s Scholarship for Academically Outstanding Students seeks to provide opportunities for distinguished national students to pursue their undergraduate or postgraduate studies at prestigious international universities.'**
  String get externalScholarshipDesc;

  /// No description provided for @doctorScholarshipDesc.
  ///
  /// In en, this message translates to:
  /// **'سعى مكتب البعثات الدراسية إلى إتاحة الفرصة أمام الأطباء المواطنين المتميزين، لاستكمال دراستهم، وتدريبهم السريري، للحصول على أعلى الدرجات والشهادات في مختلف التخصصات الطبية والصحية. وذلك في إطار الحرص على تنمية وتطوير العنصر البشري في قطاع الرعاية الصحية في دولة الإمارات العربية المتحدة، والذي يعتبر من أهم القطاعات الاقتصادية الخدمية'**
  String get doctorScholarshipDesc;

  /// No description provided for @scholarshipStatusApplied.
  ///
  /// In en, this message translates to:
  /// **'Scholarship Status'**
  String get scholarshipStatusApplied;

  /// No description provided for @scholarshipAppliedApplied.
  ///
  /// In en, this message translates to:
  /// **'Scholarship Applied'**
  String get scholarshipAppliedApplied;

  /// No description provided for @uploadDocuments.
  ///
  /// In en, this message translates to:
  /// **'Upload Documents'**
  String get uploadDocuments;

  /// No description provided for @myDocuments.
  ///
  /// In en, this message translates to:
  /// **'My Documents'**
  String get myDocuments;

  /// No description provided for @clickToUploadDocuments.
  ///
  /// In en, this message translates to:
  /// **'Click Below to Upload Documents'**
  String get clickToUploadDocuments;

  /// No description provided for @servicesUnavailable.
  ///
  /// In en, this message translates to:
  /// **'You currently do not have any scholarship or grant.'**
  String get servicesUnavailable;

  /// No description provided for @bachelors_degree_scholarship_admission_terms.
  ///
  /// In en, this message translates to:
  /// **'Bachelor\'s degree scholarship admission terms and conditions'**
  String get bachelors_degree_scholarship_admission_terms;

  /// No description provided for @sco_accredited_universities_and_specializations_list.
  ///
  /// In en, this message translates to:
  /// **'SCO Accredited Universities and Specializations list'**
  String get sco_accredited_universities_and_specializations_list;

  /// No description provided for @bachelors_degree_scholarship_privileges.
  ///
  /// In en, this message translates to:
  /// **'Bachelor\'s degree scholarship privileges'**
  String get bachelors_degree_scholarship_privileges;

  /// No description provided for @student_obligations_for_the_bachelors_degree_scholarship.
  ///
  /// In en, this message translates to:
  /// **'Student Obligations for the Bachelor\'s Degree scholarship'**
  String get student_obligations_for_the_bachelors_degree_scholarship;

  /// No description provided for @important_guidelines_for_high_school_students.
  ///
  /// In en, this message translates to:
  /// **'Important guidelines for high school students'**
  String get important_guidelines_for_high_school_students;

  /// No description provided for @bachelors_degree_applying_procedures.
  ///
  /// In en, this message translates to:
  /// **'Bachelor\'s degree applying Procedures'**
  String get bachelors_degree_applying_procedures;

  /// No description provided for @useful_websites.
  ///
  /// In en, this message translates to:
  /// **'Useful websites'**
  String get useful_websites;

  /// No description provided for @internal_scholarships_for_local_students.
  ///
  /// In en, this message translates to:
  /// **'The internal scholarships are available for outstanding Emirati students from both public and private schools, offering them the opportunity to study at prestigious local universities, with continuous support and guidance throughout their studies in the country.'**
  String get internal_scholarships_for_local_students;

  /// No description provided for @internal_scholarships_for_postgraduate_studies.
  ///
  /// In en, this message translates to:
  /// **'Internal scholarships are available for students wishing to pursue postgraduate studies at the most distinguished local universities, where a select group of students in the country competes to study.'**
  String get internal_scholarships_for_postgraduate_studies;

  /// No description provided for @meteorological_scholarships_for_high_school_graduates.
  ///
  /// In en, this message translates to:
  /// **'The Scholarship Office, through the scholarship program of the Ministry of Presidential Affairs, offers full scholarships in the field of meteorology for outstanding high school graduates.'**
  String get meteorological_scholarships_for_high_school_graduates;

  /// No description provided for @graduate_studies_scholarship_admission_terms.
  ///
  /// In en, this message translates to:
  /// **'Graduate Studies Scholarship admission terms and conditions'**
  String get graduate_studies_scholarship_admission_terms;

  /// No description provided for @graduate_studies_scholarship_privileges.
  ///
  /// In en, this message translates to:
  /// **'Graduate Studies Scholarship privileges'**
  String get graduate_studies_scholarship_privileges;

  /// No description provided for @student_obligations_for_the_graduate_studies_scholarship.
  ///
  /// In en, this message translates to:
  /// **'Student Obligations for the Graduate Studies Scholarship'**
  String get student_obligations_for_the_graduate_studies_scholarship;

  /// No description provided for @graduate_studies_scholarship_applying_procedures.
  ///
  /// In en, this message translates to:
  /// **'Graduate Studies Scholarship applying Procedures'**
  String get graduate_studies_scholarship_applying_procedures;

  /// No description provided for @meteorological_scholarship_admission_terms.
  ///
  /// In en, this message translates to:
  /// **'Meteorological Scholarship admission terms and conditions'**
  String get meteorological_scholarship_admission_terms;

  /// No description provided for @meteorological_scholarship_privileges.
  ///
  /// In en, this message translates to:
  /// **'Meteorological Scholarship privileges'**
  String get meteorological_scholarship_privileges;

  /// No description provided for @student_obligations_for_the_meteorological_scholarship.
  ///
  /// In en, this message translates to:
  /// **'Student Obligations for the Meteorological Scholarship'**
  String get student_obligations_for_the_meteorological_scholarship;

  /// No description provided for @meteorological_scholarship_applying_procedures.
  ///
  /// In en, this message translates to:
  /// **'Meteorological Scholarship applying Procedures'**
  String get meteorological_scholarship_applying_procedures;

  /// No description provided for @scholarship_for_outstanding_students.
  ///
  /// In en, this message translates to:
  /// **'The scholarship is available for outstanding Emirati students from public and private schools, offering them the opportunity to study at prestigious global universities. The scholarship program provides ongoing support and guidance throughout their studies abroad. Scholarship students attend world-class universities such as Harvard University, Princeton University, Massachusetts Institute of Technology (MIT), Stanford University, University of Oxford, University of Cambridge, University of California Berkeley, Duke University, Cornell University, University of Pennsylvania, Carnegie Mellon University, University of Michigan Ann Arbor, Brown University, and other universities with excellent academic reputations.'**
  String get scholarship_for_outstanding_students;

  /// No description provided for @scholarship_for_postgraduate_studies.
  ///
  /// In en, this message translates to:
  /// **'The scholarship of His Highness the President of the UAE is available for outstanding students wishing to pursue postgraduate studies at the most prestigious global universities, where a select group of students from around the world competes to study.'**
  String get scholarship_for_postgraduate_studies;

  /// No description provided for @scholarship_for_outstanding_medical_students.
  ///
  /// In en, this message translates to:
  /// **'The Scholarships Office aims to provide opportunities for outstanding Emirati doctors to complete their studies and clinical training to obtain the highest degrees and certifications in various medical and health specialties. This initiative is part of the commitment to developing human resources in the healthcare sector of the UAE, which is one of the most important service-based economic sectors. The scholarship also aims to qualify a new generation of leaders from the UAE, capable of facing future challenges, in order to equip the nation with distinguished human resources. These individuals will bear the mission of enhancing and developing the comprehensive development process established by the late Sheikh Zayed bin Sultan Al Nahyan, and continued with wisdom and determination by His Highness Sheikh Khalifa bin Zayed Al Nahyan, the President of the UAE (may God protect him).'**
  String get scholarship_for_outstanding_medical_students;

  /// No description provided for @distinguished_doctors_scholarship_terms_and_conditions.
  ///
  /// In en, this message translates to:
  /// **'Distinguished Doctors Scholarship admission terms and conditions'**
  String get distinguished_doctors_scholarship_terms_and_conditions;

  /// No description provided for @distinguished_doctors_scholarship_privileges.
  ///
  /// In en, this message translates to:
  /// **'Distinguished Doctors Scholarship privileges'**
  String get distinguished_doctors_scholarship_privileges;

  /// No description provided for @student_obligations_for_distinguished_doctors_scholarship.
  ///
  /// In en, this message translates to:
  /// **'Student Obligations for the Distinguished Doctors Scholarship'**
  String get student_obligations_for_distinguished_doctors_scholarship;

  /// No description provided for @distinguished_doctors_scholarship_applying_procedures.
  ///
  /// In en, this message translates to:
  /// **'Distinguished Doctors Scholarship applying Procedures'**
  String get distinguished_doctors_scholarship_applying_procedures;

  /// No description provided for @medical_licensing_exams.
  ///
  /// In en, this message translates to:
  /// **'Medical Licensing exams'**
  String get medical_licensing_exams;

  /// No description provided for @bachelor_degree_scholarship_terms_and_conditions.
  ///
  /// In en, this message translates to:
  /// **'Bachelor\'s degree scholarship admission terms and conditions'**
  String get bachelor_degree_scholarship_terms_and_conditions;

  /// No description provided for @bachelor_degree_scholarship_privileges.
  ///
  /// In en, this message translates to:
  /// **'Bachelor\'s degree scholarship privileges'**
  String get bachelor_degree_scholarship_privileges;

  /// No description provided for @student_obligations_for_bachelor_degree_scholarship.
  ///
  /// In en, this message translates to:
  /// **'Student Obligations for the Bachelor\'s Degree scholarship'**
  String get student_obligations_for_bachelor_degree_scholarship;

  /// No description provided for @bachelor_degree_applying_procedures.
  ///
  /// In en, this message translates to:
  /// **'Bachelor\'s degree applying Procedures'**
  String get bachelor_degree_applying_procedures;

  /// No description provided for @graduate_outside_uae_terms_and_conditions.
  ///
  /// In en, this message translates to:
  /// **'Graduate Studies Scholarship admission terms and conditions'**
  String get graduate_outside_uae_terms_and_conditions;

  /// No description provided for @graduate_outside_uae_scholarship_privileges.
  ///
  /// In en, this message translates to:
  /// **'Graduate Studies Scholarship privileges'**
  String get graduate_outside_uae_scholarship_privileges;

  /// No description provided for @student_obligations_for_graduate_outside_uae_scholarship.
  ///
  /// In en, this message translates to:
  /// **'Student Obligations for the Graduate Studies Scholarship'**
  String get student_obligations_for_graduate_outside_uae_scholarship;

  /// No description provided for @graduate_outside_uae_scholarship_applying_procedures.
  ///
  /// In en, this message translates to:
  /// **'Graduate Studies Scholarship applying Procedures'**
  String get graduate_outside_uae_scholarship_applying_procedures;

  /// No description provided for @noNotificationAvailable.
  ///
  /// In en, this message translates to:
  /// **'No notification available.'**
  String get noNotificationAvailable;

  /// No description provided for @invalidDocument.
  ///
  /// In en, this message translates to:
  /// **'Invalid Document Uploaded. Please Re-Upload.'**
  String get invalidDocument;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @officeLocation.
  ///
  /// In en, this message translates to:
  /// **'Office Location'**
  String get officeLocation;

  /// No description provided for @newPasswordWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get newPasswordWatermark;

  /// No description provided for @confirmPasswordWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter confirm password'**
  String get confirmPasswordWatermark;

  /// No description provided for @updatePassword.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePassword;

  /// No description provided for @submitSecurityQuestion.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get submitSecurityQuestion;

  /// No description provided for @forgotPasswordEmailWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter email address'**
  String get forgotPasswordEmailWatermark;

  /// No description provided for @forgotPasswordCaptchaWatermark.
  ///
  /// In en, this message translates to:
  /// **'Enter captcha'**
  String get forgotPasswordCaptchaWatermark;

  /// No description provided for @forgotPasswordSubmitButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get forgotPasswordSubmitButtonLabel;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSure;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @draftDatesOver.
  ///
  /// In en, this message translates to:
  /// **'Draft submission date is over. Please try later.'**
  String get draftDatesOver;

  /// No description provided for @submitNewApplication.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitNewApplication;

  /// No description provided for @homeSalary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get homeSalary;

  /// No description provided for @seeMore.
  ///
  /// In en, this message translates to:
  /// **'...See more'**
  String get seeMore;

  /// No description provided for @seeLess.
  ///
  /// In en, this message translates to:
  /// **' See less'**
  String get seeLess;

  /// No description provided for @externalDoctorsOutsideUae.
  ///
  /// In en, this message translates to:
  /// **'Doctors graduation outside UAE'**
  String get externalDoctorsOutsideUae;

  /// No description provided for @draftSavedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Draft Saved Successfully'**
  String get draftSavedSuccess;

  /// No description provided for @employmentStatusFieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Employment Status'**
  String get employmentStatusFieldTitle;

  /// No description provided for @enterValidGrade.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Valid Grade'**
  String get enterValidGrade;

  /// No description provided for @pass.
  ///
  /// In en, this message translates to:
  /// **'Pass'**
  String get pass;

  /// No description provided for @fail.
  ///
  /// In en, this message translates to:
  /// **'Fail'**
  String get fail;

  /// No description provided for @medicalProfessionsProgram.
  ///
  /// In en, this message translates to:
  /// **'Medical Professions Program'**
  String get medicalProfessionsProgram;

  /// No description provided for @postGraduationExternalMedicine.
  ///
  /// In en, this message translates to:
  /// **'Post Graduation External Medicine'**
  String get postGraduationExternalMedicine;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
