import 'package:sco_v1/data/network/dio/DioBaseApiServices.dart';
import 'package:sco_v1/data/network/dio/DioNetworkApiServices.dart';
import 'package:sco_v1/models/account/GetBase64StringModel.dart';
import 'package:sco_v1/models/account/GetEmploymentStatusModel.dart';
import 'package:sco_v1/models/account/GetListApplicationStatusModel.dart';
import 'package:sco_v1/models/account/edit_application_sections_model/GetApplicationSectionsModel.dart';
import 'package:sco_v1/models/account/edit_application_sections_model/GetListOfAttachmentsModel.dart';
import 'package:sco_v1/models/account/edit_application_sections_model/UpdatePeopleSoftApplicationModel.dart';
import 'package:sco_v1/models/account/edit_application_sections_model/UploadUpdateAttachmentModel.dart';
import 'package:sco_v1/models/account/personal_details/GetProfilePictureUrlModel.dart';
import 'package:sco_v1/models/account/personal_details/UpdatePersonalDetailsModel.dart';
import 'package:sco_v1/models/apply_scholarship/DeleteDraftModel.dart';
import 'package:sco_v1/models/apply_scholarship/GetAllActiveScholarshipsModel.dart';
import 'package:sco_v1/models/apply_scholarship/SaveAsDraftModel.dart';
import 'package:sco_v1/models/apply_scholarship/SubmitApplicationModel.dart';
import 'package:sco_v1/models/apply_scholarship/get_app_version_model.dart';
import 'package:sco_v1/models/notifications/GetAllNotificationsModel.dart';
import 'package:sco_v1/models/services/notes_models/AddCommentToNoteModel.dart';
import 'package:sco_v1/models/services/notes_models/GetAllNotesModel.dart';
import 'package:sco_v1/models/services/GetAllRequestsModel.dart';
import 'package:sco_v1/models/services/GetMyAdvisorModel.dart';
import 'package:sco_v1/models/services/MyFinanceStatusModel.dart';
import 'package:sco_v1/models/services/MyScholarshipModel.dart';
import 'package:sco_v1/models/services/UpdateRequestModel.dart';
import 'package:sco_v1/models/services/notes_models/GetSpecificNoteDetailsModel.dart';
import 'package:sco_v1/models/services/notes_models/UploadAttachmentToNoteModel.dart';

import '../../models/account/CreateUpdateEmploymentStatusModel.dart';
import '../../models/account/personal_details/PersonalDetailsModel.dart';
import '../../models/apply_scholarship/AttachFileModel.dart';
import '../../models/apply_scholarship/FindDraftByConfigurationKeyModel.dart';
import '../../models/drawer/vision_and_mission_model.dart';
import '../../models/notifications/DecreaseNotificationCountModel.dart';
import '../../models/notifications/get_notifications_count_model.dart';
import '../../resources/app_urls.dart';
import '../../utils/constants.dart';

class HomeRepository {
  final DioBaseApiServices _dioBaseApiServices = DioNetworkApiServices();


  // *------Apply Scholarship section start------*/

  // get all active scholarships
  Future<List<GetAllActiveScholarshipsModel>> getAllActiveScholarships({
    required dynamic headers,
  }) async {
    try {
      // defining list:
      List<GetAllActiveScholarshipsModel> list = [];

      dynamic response = await _dioBaseApiServices.dioGetApiService(url: AppUrls.getAllActiveScholarships, headers: headers);

      // converting response to list
      list = (response['data'] as List).map((element) {
        return GetAllActiveScholarshipsModel.fromJson(element);
      }).toList();


      // return list of scholarships
      return list;
    } catch (e) {
      rethrow;
    }
  }

  // *------ Save As Draft Method ------*/
  Future<SaveAsDraftModel> saveAsDraft(
      {required String userId,
      required String applicationNumber,
      required dynamic body,
      required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioPostApiService(
      url: AppUrls.saveDraft(userId,applicationNumber),
      body: body,
      headers: headers,
    );
    return SaveAsDraftModel.fromJson(response);
  }

  // *------ Fetch Draft By Configuration Key ------*/
  Future<FindDraftByConfigurationKeyModel> findDraftByConfigurationKey(
      {
        required dynamic userId,
        required dynamic emiratesId,
        required dynamic configKey,}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: AppUrls.findDraftByConfigurationKey(userId,emiratesId,configKey),
      headers: null,
    );
    if(response['data'] != null){
      return FindDraftByConfigurationKeyModel.fromJson(response['data']);
    }
    else{
      return FindDraftByConfigurationKeyModel();
    }
  }

  // *------ Fetch Draft By Draft ID ------*/
  Future<FindDraftByConfigurationKeyModel> findDraftByDraftId(
      {required dynamic userId, required dynamic draftId}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: AppUrls.getDraftApplicationByDraftId(userId,draftId),
      headers: null,
    );
    if(response['data'] != null){
      return FindDraftByConfigurationKeyModel.fromJson(response['data']);
    }else{
      return FindDraftByConfigurationKeyModel();
    }
  }

  // *------ Fetch submitted application details By application number ------*/
  Future<FindDraftByConfigurationKeyModel> getSubmittedApplicationDetailsByApplicationNumber(
          {
            required dynamic userId,
          required dynamic applicationNumber,
          }) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url:  AppUrls.getSubmittedApplicationDetailsByApplicationNumber(userId,applicationNumber),
      headers: null,
    );

    if(response['data'] != null){
      return FindDraftByConfigurationKeyModel.fromJson(response['data']);
    }
    else{
      return FindDraftByConfigurationKeyModel();
    }
  }

  // *------ Delete Draft Method ------*/
  Future<DeleteDraftModel> deleteDraft(
      {required String userId,
      required String draftId,
      required Map<String,String> headers}) async {
    dynamic response = await _dioBaseApiServices.dioDeleteApiService(
      url: AppUrls.deleteDraft(userId,draftId),
      headers: headers,
    );
    return DeleteDraftModel.fromJson(response);
  }

  // *------ Attach file to application form ------*/
  Future<AttachFileModel> attachFile(
      {required dynamic userId,
      required dynamic headers,
      required dynamic body}) async {
    dynamic response = await _dioBaseApiServices.dioPostApiService(
      url: AppUrls.attachFile(userId),
      headers: headers,
      body: body,
    );
    return AttachFileModel.fromJson(response);
  }

  // *------ Get User (student) Information Method ------*/
  Future<PersonalDetailsModel> getPersonalDetails(
      {required String userId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: AppUrls.getPersonalDetails(userId),
      headers: headers,
    );
    return PersonalDetailsModel.fromJson(response);
  }

  // // *------ Update User (student) Information Method ------*/
  Future<UpdatePersonalDetailsModel> updatePersonalDetails(
      {required String userId,
      required dynamic body,
      required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioPutApiService(
      url: AppUrls.updateProfileDetails(userId),
      body: body,
      headers: headers,
    );
    return UpdatePersonalDetailsModel.fromJson(response);
  }


//  *------ Get List of Applications including draft,applied or submitted Method ------*/
  Future<GetListApplicationStatusModel> getListApplicationStatus(
      {required String userId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: AppUrls.getApplicationsList(userId),
      headers: headers,
    );
    return GetListApplicationStatusModel.fromJson(response);
  }

  //  *------ Get List of submitted Application Method ------*/
  Future<MyScholarshipModel> getMyScholarship(
      {required String userId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: AppUrls.getMyScholarship(userId),
      headers: headers,
    );
    return MyScholarshipModel.fromJson(response);
  }

  // *------ Submit Application Method ------*/
  Future<SubmitApplicationModel> submitApplication(
      {required dynamic userId,
      required dynamic headers,
      required dynamic body}) async {
    dynamic response = await _dioBaseApiServices.dioPostApiService(
      url: AppUrls.submitApplication(userId),
      headers: headers,
      body: body,
    );
    return SubmitApplicationModel.fromJson(response);
  }

  // *------ Get Employment Status Method ------*/
  Future<GetEmploymentStatusModel> getEmploymentStatus(
      {required String userId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: AppUrls.getEmploymentStatus(userId),
      headers: headers,
    );
    return GetEmploymentStatusModel.fromJson(response);
  }

  // *------ Get Employment Status Method ------*/
  Future<CreateUpdateEmploymentStatusModel> createUpdateEmploymentStatus(
      {required String userId,
      required dynamic headers,
      required dynamic body,
      required bool updating}) async {
    dynamic response = updating
        ? await _dioBaseApiServices.dioPutApiService(
            url: AppUrls.updateEmploymentStatus(userId),
            headers: headers,
            body: body)
        :

        /// If not updating which means we are creating new employment status
        await _dioBaseApiServices.dioPostApiService(
            url: AppUrls.createEmploymentStatus(userId),
            headers: headers,
            body: body);
    return CreateUpdateEmploymentStatusModel.fromJson(response);
  }

  // *------ Get Employment Status base64String Method ------*/
  Future<GetBase64StringModel> getBase64String({
    required dynamic userId,
    required dynamic headers,
    required dynamic body,
    required AttachmentType attachmentType,
  }) async {
    // Determine the URL based on the attachment type
    late String url;

    switch (attachmentType) {
      case AttachmentType.employment:
        url = AppUrls.getEmploymentStatusFileContent(userId);
        break;
      case AttachmentType.request:
        url = AppUrls.getRequestFileContent(userId);
        break;
      case AttachmentType.updateNote:
        url = AppUrls.getUpdateNoteFileContent(userId);
        break;
      }

    try {
      // Make the API call
      final response = await _dioBaseApiServices.dioPostApiService(
        url: url,
        headers: headers,
        body: body,
      );

      // Convert the response to the desired model
      return GetBase64StringModel.fromJson(response);
    } catch (error) {
      // Log or handle errors here
      throw Exception("Failed to fetch base64 string: $error");
    }
  }

  // *------ Get My Finance Status Status Method ------*/
  Future<MyFinanceStatusModel> myFinanceStatus(
      {required String userId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: AppUrls.myFinanceStatus(userId),
      headers: headers,
    );
    return MyFinanceStatusModel.fromJson(response);
  }

  // *------ Get All Requests Method ------*/
  Future<GetAllRequestsModel> getAllRequests(
      {required String userId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: AppUrls.getAllRequests(userId),
      headers: headers,
    );
    return GetAllRequestsModel.fromJson(response);
  }

  // *------ CREATE REQUEST  Method ------*/
  Future<UpdateRequestModel> createRequest(
      {required dynamic userId,
      required dynamic headers,
      required dynamic body}) async {
    dynamic response = await _dioBaseApiServices.dioPostApiService(
      url: AppUrls.createRequest(userId),
      headers: headers,
      body: body,
    );
    return UpdateRequestModel.fromJson(response);
  }

  // *------ UPDATE REQUEST  Method ------*/
  Future<UpdateRequestModel> updateRequest(
      {required dynamic userId,
      required dynamic headers,
      required dynamic body}) async {
    dynamic response = await _dioBaseApiServices.dioPutApiService(
      url: AppUrls.updateRequest(userId),
      headers: headers,
      body: body,
    );
    return UpdateRequestModel.fromJson(response);
  }

  // *------ Get My Advisor's Method ------*/
  Future<GetMyAdvisorModel> getMyAdvisor(
      {required String userId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: AppUrls.getMyAdvisor(userId),
      headers: headers,
    );
    return GetMyAdvisorModel.fromJson(response);
  }

  // *------ Get profile picture url method Method ------*/
  Future<GetProfilePictureUrlModel> getProfilePictureUrl(
      {required String userId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: AppUrls.getProfilePicture(userId),
      headers: headers,
    );
    return GetProfilePictureUrlModel.fromJson(response);
  }

  // *------ UPDATE PROFILE PICTURE METHOD ------*/
  Future<GetProfilePictureUrlModel> updateProfilePicture(
      {required dynamic userId,
      required dynamic headers,
      required dynamic body}) async {
    dynamic response = await _dioBaseApiServices.dioPutApiService(
      url: AppUrls.updateProfilePicture(userId),
      headers: headers,
      body: body,
    );
    return GetProfilePictureUrlModel.fromJson(response);
  }

  // *------ Get  Notifications count Method ------*/
  Future<GetNotificationsCountModel> getNotificationsCount(
      {required String userId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: AppUrls.getNotificationsCount(userId),
      headers: headers,
    );
    return GetNotificationsCountModel.fromJson(response);
  }

  /// GET PAGE CONTENT METHODS
  Future<VisionAndMissionModel> getPageContentByUrl(
      {required dynamic headers, required dynamic body}) async {
    dynamic response = await _dioBaseApiServices.dioPostApiService(
      url: AppUrls.getPageContentByUrl,
      headers: headers,
      body: body,
    );
    return VisionAndMissionModel.fromJson(response);
  }

  /// Get All Notes model
  Future<GetAllNotesModel> getAllNotes(
      {required String userId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: AppUrls.getAllNotes(userId),
      headers: headers,
    );
    return GetAllNotesModel.fromJson(response);
  }

  /// Get All Notes model
  Future<GetSpecificNoteDetailsModel> getSpecificNoteDetails(
      {required String userId,
      required String noteId,
      required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: AppUrls.getSpecificNoteDetails(userId,noteId),
      headers: headers,
    );
    return GetSpecificNoteDetailsModel.fromJson(response);
  }

  /// add comment to note
  Future<AddCommentToNoteModel> addCommentToNote(
      {required String userId,
      required String noteId,
      required dynamic body,
      required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioPutApiService(
        url: AppUrls.addCommentToNote(userId,noteId),
        headers: headers,
        body: body);
    return AddCommentToNoteModel.fromJson(response);
  }

  /// add attachment to note
  Future<UploadAttachmentToNoteModel> uploadAttachmentToNote(
      {required String userId,
      required String noteId,
      required dynamic body,
      required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioPostApiService(
        url: AppUrls.uploadAttachmentToNote(userId,noteId),
        headers: headers,
        body: body);
    return UploadAttachmentToNoteModel.fromJson(response);
  }

  // get all Notifications Model
  Future<List<NotificationData>> getAllNotifications(
      {required String userId, required dynamic headers}) async {
    final List<NotificationData> listOfNotifications = [];

    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: AppUrls.getAllNotifications(userId),
      headers: headers,
    );

    final responseModel = GetAllNotificationsModel.fromJson(response);

    if (responseModel.data?.isNotEmpty ?? false) {
      for (var element in responseModel.data!) {
        listOfNotifications.add(element);
      }
    }

    return listOfNotifications;
  }

  /// add attachment to note
  Future<DecreaseNotificationCountModel> decreaseNotificationCount(
      {required dynamic userId, required dynamic body, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioPutApiService(
        url: AppUrls.decreaseNotificationCount(userId), headers: headers, body: body);
    return DecreaseNotificationCountModel.fromJson(response);
  }

  /// GET APPLICATION SECTIONS MODEL
  Future<GetApplicationSectionsModel> getApplicationSections(
      {required String userId,
      required String applicationNumber,
      required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: AppUrls.getPeopleSoftApplication(userId,applicationNumber),
      headers: headers,
    );
    return GetApplicationSectionsModel.fromJson(response);
  }

  /// Edit Employment History
  // *------ Save As Draft Method ------*/
  Future<UpdatePeopleSoftApplicationModel> editApplicationSection(
      {required String url,
      required String applicationNumber,
      required dynamic body,
      required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioPutApiService(
      url: url,
      body: body,
      headers: headers,
    );
    return UpdatePeopleSoftApplicationModel.fromJson(response);
  }

  /// GET APPLICATION SECTIONS MODEL
  Future<GetListOfAttachmentsModel> getListOfAttachments(
      {required String userId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: AppUrls.getListOfAttachments(userId),
      headers: headers,
    );
    return GetListOfAttachmentsModel.fromJson(response);
  }

  /// upload or update attachment
  Future<UploadUpdateAttachmentModel> uploadUpdateAttachment(
      {required dynamic body,
      required String userId,
      required bool isUpdating,
      required dynamic headers}) async
  {
    dynamic response = await _dioBaseApiServices.dioPostApiService(
        url: isUpdating
            ? AppUrls.updateAttachment(userId)
            : AppUrls.uploadAttachment(userId),
        headers: headers,
        body: body);
    return UploadUpdateAttachmentModel.fromJson(response);
  }

  /// get app version
  Future<GetAppVersionModel> getAppVersion()async{
    try{
      final apiResponse = await _dioBaseApiServices.dioGetApiService(url: AppUrls.getAppVersion, headers: null);
      return GetAppVersionModel.fromJson(apiResponse);
    }catch (e){
      rethrow;
    }
  }

}
