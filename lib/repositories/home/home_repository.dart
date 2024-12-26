import 'package:flutter/material.dart';
import 'package:sco_v1/data/network/BaseApiServices.dart';
import 'package:sco_v1/data/network/dio/DioBaseApiServices.dart';
import 'package:sco_v1/data/network/dio/DioNetworkApiServices.dart';
import 'package:sco_v1/models/TestModel.dart';
import 'package:sco_v1/models/account/GetBase64StringModel.dart';
import 'package:sco_v1/models/account/GetEmploymentStatusModel.dart';
import 'package:sco_v1/models/account/GetListApplicationStatusModel.dart';
import 'package:sco_v1/models/account/edit_application_sections_model/GetApplicationSectionsModel.dart';
import 'package:sco_v1/models/account/personal_details/GetProfilePictureUrlModel.dart';
import 'package:sco_v1/models/account/personal_details/UpdatePersonalDetailsModel.dart';
import 'package:sco_v1/models/apply_scholarship/DeleteDraftModel.dart';
import 'package:sco_v1/models/apply_scholarship/GetAllActiveScholarshipsModel.dart';
import 'package:sco_v1/models/apply_scholarship/SaveAsDraftModel.dart';
import 'package:sco_v1/models/apply_scholarship/SubmitApplicationModel.dart';
import 'package:sco_v1/models/home/HomeSliderModel.dart';
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

import '../../data/network/NetworkApiServices.dart';
import '../../models/account/CreateUpdateEmploymentStatusModel.dart';
import '../../models/account/personal_details/PersonalDetailsModel.dart';
import '../../models/apply_scholarship/AttachFileModel.dart';
import '../../models/apply_scholarship/FindDraftByConfigurationKeyModel.dart';
import '../../models/drawer/vision_and_mission_model.dart';
import '../../models/notifications/DecreaseNotificationCountModel.dart';
import '../../resources/app_urls.dart';
import '../../utils/constants.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  final DioBaseApiServices _dioBaseApiServices = DioNetworkApiServices();

  //*------Home Slider Method-------*
  Future<List<HomeSliderModel>> homeSlider({required dynamic headers}) async {
    dynamic response = await _apiServices.getGetApiServices(
      url: AppUrls.homeSlider,
      headers: headers,
    );

    List<HomeSliderModel> homeSliderItemsList = [];

    for (var item in response) {
      homeSliderItemsList.add(HomeSliderModel.fromJson(item));
    }

    return homeSliderItemsList;
  }

  // *------Apply Scholarship section start------*/

  // get all active scholarships
  Future<List<GetAllActiveScholarshipsModel>> getAllActiveScholarships({
    required dynamic headers,
  }) async {
    try {
      // defining list:
      List<GetAllActiveScholarshipsModel> list = [];

      dynamic response = await _dioBaseApiServices.dioGetApiService(
          url: AppUrls.getAllActiveScholarships, headers: headers);

      // converting response to list
      list = (response as List).map((element) {
        return GetAllActiveScholarshipsModel.fromJson(element);
      }).toList();

      // return list of scholarships
      return list;
    } catch (e) {
      throw e;
    }
  }







  // *------ Save As Draft Method ------*/
  Future<SaveAsDraftModel> saveAsDraft(
      {required String userId,required String applicationNumber,required dynamic body, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioPostApiService(
      url: '${AppUrls.baseUrl}e-services/${userId}/draft-application/${applicationNumber}',
      body: body,
      headers: headers,
    );
    return SaveAsDraftModel.fromJson(response);
  }

  // *------ Fetch Draft By Configuration Key ------*/
  Future<FindDraftByConfigurationKeyModel> findDraftByConfigurationKey(
      {required dynamic headers,required dynamic body}) async {
    dynamic response = await _dioBaseApiServices.dioPostApiService(
      url: AppUrls.findDraftByConfigurationKey,
      headers: headers,
      body: body,
    );
    return FindDraftByConfigurationKeyModel.fromJson(response);
  }

  // *------ Fetch Draft By Draft ID ------*/
  Future<FindDraftByConfigurationKeyModel> findDraftByDraftId(
      {required dynamic headers,required dynamic draftId}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: "${AppUrls.commonBaseUrl}jsonws/application.applicationdetails/fetch-by-application-id/application-no/$draftId",
      headers: headers,
    );
    return FindDraftByConfigurationKeyModel.fromJson(response);
  }



  // *------ Delete Draft Method ------*/
  Future<DeleteDraftModel> deleteDraft(
      {required String userId,required String draftId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioDeleteApiService(
      url: '${AppUrls.baseUrl}e-services/${userId}/delete-draft/${draftId}',
      headers: headers,
    );
    return DeleteDraftModel.fromJson(response);
  }



  // *------ Attach file to application form ------*/
  // url: "https://stg.sco.ae/o/mopa-sco-api/e-services/$userId/attach-file",

  Future<AttachFileModel> attachFile(
      {required dynamic userId,required dynamic headers,required dynamic body}) async {
    dynamic response = await _dioBaseApiServices.dioPostApiService(
      url: "${AppUrls.baseUrl}e-services/$userId/attach-file",
      headers: headers,
      body: body,
    );
    return AttachFileModel.fromJson(response);
  }


  // *------ Get User (student) Information Method ------*/
  Future<PersonalDetailsModel> getPersonalDetails(
      {required String userId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: '${AppUrls.baseUrl}self-service/personalInformation/$userId',
      headers: headers,
    );
    return PersonalDetailsModel.fromJson(response);
  }


  // // *------ Update User (student) Information Method ------*/
  Future<UpdatePersonalDetailsModel> updatePersonalDetails(
      {required String userId,required dynamic body, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioPutApiService(
      url: '${AppUrls.baseUrl}self-service/personalInformation/$userId',
      body: body,
      headers: headers,
    );
    return UpdatePersonalDetailsModel.fromJson(response);
  }
  // // *------ Update User (student) Information Method ------*/
  // Future<UpdatePersonalDetailsModel> updatePersonalDetails(
  //     {required String userId,required dynamic body, required dynamic headers}) async {
  //   dynamic response = await _dioBaseApiServices.dioMultipartApiService(
  //     url: '${AppUrls.baseUrl}self-service/personalInformation/$userId',
  //     data: body,
  //     method: 'PUT',
  //     headers: headers,
  //   );
  //   return UpdatePersonalDetailsModel.fromJson(response);
  // }





//  *------ Get List of Applications including draft,applied or submitted Method ------*/
  Future<GetListApplicationStatusModel> getListApplicationStatus(
      {required String userId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: '${AppUrls.baseUrl}e-services/$userId/list-application-status',
      headers: headers,
    );
    return GetListApplicationStatusModel.fromJson(response);
  }


  //  *------ Get List of submitted Application Method ------*/
  Future<MyScholarshipModel> getMyScholarship(
      {required String userId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: '${AppUrls.baseUrl}self-service/myscholarship/$userId',
      headers: headers,
    );
    return MyScholarshipModel.fromJson(response);
  }







  // *------ Submit Application Method ------*/
  Future<SubmitApplicationModel> submitApplication(
      {required dynamic userId,required dynamic headers,required dynamic body}) async {
    dynamic response = await _dioBaseApiServices.dioPostApiService(
      url: "${AppUrls.baseUrl}e-services/$userId/submit-application",
      headers: headers,
      body: body,
    );
    return SubmitApplicationModel.fromJson(response);
  }


  // *------ Get Employment Status Method ------*/
  Future<GetEmploymentStatusModel> getEmploymentStatus(
      {required String userId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: '${AppUrls.baseUrl}e-services/$userId/my-employment-status',
      headers: headers,
    );
    return GetEmploymentStatusModel.fromJson(response);
  }


  // *------ Get Employment Status Method ------*/
  Future<CreateUpdateEmploymentStatusModel> createUpdateEmploymentStatus(
      {required String userId, required dynamic headers,required dynamic body,required bool updating}) async {
    dynamic response =
    updating ?
    await _dioBaseApiServices.dioPutApiService(url: '${AppUrls.baseUrl}e-services/$userId/update-employment-status', headers: headers, body: body)
    :
    /// If not updating which means we are creating new employment status
    await _dioBaseApiServices.dioPostApiService(
      url: '${AppUrls.baseUrl}e-services/$userId/create-employment-status',
      headers: headers,
      body: body
    );
    return CreateUpdateEmploymentStatusModel.fromJson(response);
  }



  // *------ Get Employment Status base64String Method ------*/
  Future<GetBase64StringModel> getBase64String({
    required dynamic headers,
    required dynamic body,
    required AttachmentType attachmentType,
  }) async {
    // Determine the URL based on the attachment type
    late String url;

    switch (attachmentType) {
      case AttachmentType.employment:
        url = AppUrls.getEmploymentStatusFileContent;
        break;
      case AttachmentType.request:
        url = AppUrls.getRequestFileContent;
        break;
      case AttachmentType.updateNote:
        url = AppUrls.getUpdateNoteFileContent;
        break;
      default:
        throw Exception("Invalid attachment type: $attachmentType");
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
      url: '${AppUrls.baseUrl}e-services/$userId/my-finance-status',
      headers: headers,
    );
    return MyFinanceStatusModel.fromJson(response);
  }

  // *------ Get All Requests Method ------*/
  Future<GetAllRequestsModel> getAllRequests(
      {required String userId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: '${AppUrls.baseUrl}self-service/service-request/$userId/get-service-requests',
      headers: headers,
    );
    return GetAllRequestsModel.fromJson(response);
  }

  // *------ CREATE REQUEST  Method ------*/
  Future<UpdateRequestModel> createRequest(
      {required dynamic userId,required dynamic headers,required dynamic body}) async {
    dynamic response = await _dioBaseApiServices.dioPostApiService(
      url: '${AppUrls.baseUrl}self-service/service-request/$userId/add-service-request',
      headers: headers,
      body: body,
    );
    return UpdateRequestModel.fromJson(response);
  }

  // *------ UPDATE REQUEST  Method ------*/
  Future<UpdateRequestModel> updateRequest(
      {required dynamic userId,required dynamic headers,required dynamic body}) async {
    dynamic response = await _dioBaseApiServices.dioPutApiService(
      url: '${AppUrls.baseUrl}self-service/service-request/$userId/add-comment-exiting-request',
      headers: headers,
      body: body,
    );
    return UpdateRequestModel.fromJson(response);
  }


  // *------ Get My Advisor's Method ------*/
  Future<GetMyAdvisorModel> getMyAdvisor(
      {required String userId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: '${AppUrls.baseUrl}e-services/my-advisor/$userId',
      headers: headers,
    );
    return GetMyAdvisorModel.fromJson(response);
  }

  // *------ Get profile picture url method Method ------*/
  Future<GetProfilePictureUrlModel> getProfilePictureUrl(
      {required String userId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: '${AppUrls.commonBaseUrl}jsonws/userext.userextension/get-user-portrait-url/user-id/$userId',
      headers: headers,
    );
    return GetProfilePictureUrlModel.fromJson(response);
  }


  // *------ UPDATE PROFILE PICTURE METHOD ------*/
  Future<GetProfilePictureUrlModel> updateProfilePicture(
      {required dynamic userId,required dynamic headers,required dynamic body}) async {
    dynamic response = await _dioBaseApiServices.dioPostApiService(
      url: AppUrls.updateProfilePicture,
      headers: headers,
      body: body,
    );
    return GetProfilePictureUrlModel.fromJson(response);
  }

   // *------ Get  Notifications count Method ------*/
  Future<dynamic> getNotificationsCount(
      {required String userEmiratesId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: '${AppUrls.commonBaseUrl}jsonws/mopanotification.mopanotification/get-notification-new-count-for-user/user-name/$userEmiratesId',
      headers: headers,
    );
    return response;
  }

  /// GET PAGE CONTENT METHODS
  //*------Faq's API method------*/
  Future<VisionAndMissionModel> getPageContentByUrl(
      {required dynamic headers, required dynamic body}) async {
    dynamic response = await _apiServices.getPostApiServices(
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
      url: '${AppUrls.baseUrl}self-service/advisee/get-note-by-advisee/$userId',
      headers: headers,
    );
    return GetAllNotesModel.fromJson(response);
  }


  /// Get All Notes model
  Future<GetSpecificNoteDetailsModel> getSpecificNoteDetails(
      {required String userId,required String noteId, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: '${AppUrls.baseUrl}self-service/advisee/get-note-details/$userId/$noteId',
      headers: headers,
    );
    return GetSpecificNoteDetailsModel.fromJson(response);
  }

  /// add comment to note
  Future<AddCommentToNoteModel> addCommentToNote(
      {required String userId,required String noteId,required dynamic body, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioPutApiService(
      url: '${AppUrls.baseUrl}self-service/advisee/$userId/update-note/$noteId',
      headers: headers,
      body: body
    );
    return AddCommentToNoteModel.fromJson(response);
  }

  /// add attachment to note
  Future<UploadAttachmentToNoteModel> uploadAttachmentToNote(
      {required String userId,required String noteId,required dynamic body, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioPostApiService(
        url: '${AppUrls.baseUrl}self-service/notes/$userId/upload-attachment/$noteId',
        headers: headers,
        body: body
    );
    return UploadAttachmentToNoteModel.fromJson(response);
  }

  // get all Notifications Model
  Future<List<GetAllNotificationsModel>> getAllNotifications(
      {required String userId, required dynamic headers}) async {

    final List<GetAllNotificationsModel> listOfNotifications = [];

    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: '${AppUrls.commonBaseUrl}jsonws/mopanotification.mopanotification/get-all-notification-for-user/user-id/$userId',
      headers: headers,
    );

    if(response.isNotEmpty){
      for(var element in response){
        listOfNotifications.add(GetAllNotificationsModel.fromJson(element));
      }
    }

    return listOfNotifications;
  }

  /// add attachment to note
  Future<DecreaseNotificationCountModel> decreaseNotificationCount(
      {required dynamic body, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioPostApiService(
        url: AppUrls.decreaseNotificationCount,
        headers: headers,
        body: body
    );
    return DecreaseNotificationCountModel.fromJson(response);
  }

  /// GET APPLICATION SECTIONS MODEL
  Future<GetApplicationSectionsModel> getApplicationSections(
      {required String userId,required String applicationNumber, required dynamic headers}) async {
    dynamic response = await _dioBaseApiServices.dioGetApiService(
      url: '${AppUrls.baseUrl}e-services/$userId/fetch-ps-application/$applicationNumber',
      headers: headers,
    );
    return GetApplicationSectionsModel.fromJson(response);
  }
}
