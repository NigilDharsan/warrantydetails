class AppConstants {
  static const String appName = 'Byufuel';

  static const String configUrl = 'configs';
  static const String onBoards = 'on-boards';
  static const String socialLoginUrl = 'social-login';

  static const String mobileDeviceUrl = 'api/mobile-devices';
  static const String signupVerificationUrl =
      'api/uam/users/sign-up-verification';
  static const String registerUrl = 'api/uam/registration';
  static const String createAddressUrl =
      'api/uam/account-addresses/create-address';
  static const String updateAddressUrl = 'api/uam/registration';

  static const String bankAccountVerifyUrl = 'api/razorpay/fund-accounts';

  static const String addBankAccountUrl = 'api/bank-account-details';
  static const String defaultAddressUrl =
      "api/uam/account-addresses/default-address";

  static const String addressList = "api/uam/account-addresses/";
  static const String accountDetailUrl = "api/bank-account-details/";
  //
  static const String registerWithPhone = 'register-by-phone';
  static const String verifyPhoneOTP = 'verify-phone-otp';
  static const String resendPhoneOTP = 'resend-phone-otp';
  static const String getPhoneLoginOTP = 'get-login-otp';
  static const String verifyLoginPhoneOTP = 'verify-login-otp';
  static const String verifyEmailOTP = 'email-verify';
  static const String resendEmailOTP = 'resend-email-otp';
  static const String forgotPasswordOTP = 'api/uam/otp/generate';

  // static const String verifyOTPForForgotPassword = 'verify-otp';
  static const String resetPassword = 'api/uam/users/reset-password';

  //home
  static const String homeScreen = 'home-screen';

  //profile
  static const String profile = 'api/uam/me';
  static const String updateProfile = 'user/update-profile';
  static const String deleteAccount = 'user/delete-account';

  static const String avatarUpdate = 'api/uam/users/profile/avatar';
  static const String getAvatarUrl = 'api/uam/users/';
  static const String validateUrl = 'api/uam/users/validate/MOBILE/';
  static const String kycDocuments = 'api/documents';

  //search
  static const String searchCourses = "search-courses";

  //Chat

  static const String chatCountApi = 'api/messages/GetUnReadMessageCount';
  static const String chatHubApi = 'api/chat/chathub';

  //notification
  static const String notificationApi = 'user/notifications';
  static const String getNotificationSettingApi =
      'api/uam/user-notifications-configs/search?';
  static const String updateNotificationSettingApi =
      "api/uam/user-notifications-configs/";
  static const String getNotificationUrl = 'api/saas/push-notifications';

  //report
  static const String getSupplierReportUrl = 'api/get-supplier-graph-data';
  static const String getDriverReportUrl = 'api/get-driver-graph-data';

// UCO
  static const String ucoSchedulePost = 'api/uco-schedules';
  static const String ucoGetData = 'mobile/uco-mdm';
  static const String ucoTypeUrl = 'mobile/uco-type';
  static const String documentTypes = 'mobile/supplier-documents';
  static const String ucoEstablishmentData = 'mobile/registration';
  static const String uploadDocuments = 'api/documents/upload-documents';
  static const String driverDocumentTypes = 'mobile/driver-documents';
  static const String raiseComplaint = 'api/complaints';
  static const String getUploadFiles = 'api/documents/search?';
  static const String chatConversations = 'api/conversations';
  static const String groupChatConversations = 'api/conversations/participants';

  static const String getDocumentation = "api/uco-configurations/UCOSUPDOC/";
  static const String uploadDocumentation = "api/supplier-document-upload";
  static const String ucoDateConfigUrl = "api/uco-configurations/SUPPICKDAYS/";
  static const String ucoConfigurationUrl = "api/uco-configurations/";

  static const String isSupplier = 'is_supplier';
  static const String theme = 'lms_theme';
  static const String token = 'lms_token';
  static const String refreshToken = 'refresh_token';
  static const String countryCode = 'lms_country_code';
  static const String languageCode = 'lms_language_code';
  static const String languagename = 'lms_language_name';
  static const String userPassword = 'lms_user_password';
  static const String userNumber = 'lms_user_number';
  static const String userEmail = 'lms_user_email';
  static const String userCountryCode = 'lms_user_country_code';
  static const String notification = 'lms_notification';
  static const String isOnBoardScreen = 'lms_on_board_seen';
  static const String topic = 'customer';
  static const String localizationKey = 'X-localization';
  static const String configUri = '/api/v1/customer/config';
  static const String socialRegisterUrl = '/api/v1/auth/social-register';
  static const String tokenUrl = '/api/v1/customer/update/fcm-token';
  static const String notificationCount = '/api/v1/customer/notification';
  static const String resetPasswordUrl = '/api/v1/customer/notification';
  static const String customerInfoUrl = '/api/v1/customer/notification';
  static const String updateProfileUrl = '/api/v1/customer/notification';
  static const String verifyTokenUrl = '/api/v1/customer/notification';
  static const String finishCollectionUrl = 'api/itinerary-uco-details';
  static const String containerDetailListUrl = 'api/containers/itinerary-drop';
  static const String collectOilUrl = 'api/itinerary-uco-details/collect-oil';
  static const String plannedDistanceURL = 'api/itinerary-distance-logs';
  static const String driverContainerCountUrl =
      'api/containers/planned-collected';
  static const String finishcollectOilUrl =
      'api/itinerary-uco-details/finish-collect-oil';
  static const String removeUcoUrl = 'api/itinerary-uco-details/remove-uco';
  static const String addNewContainerUrl = 'api/containers';

  static const String pages = '/api/v1/customer/config/pages';

  static const String verifyPhoneUrl = '/api/v1/customer/config/pages';
  static const String subscriptionUrl = '/api/v1/customer/config/pages';
  static const String getChannelList = 'get-channel-list';
  static const String getConversation = 'get-conversation';
  static const String searchHistory = 'search-history';

  // PAYMENT
  static const String paymentHistoryUrl = '/api/supplier-payments/search?';

  //ITINERARY COMPLETED
  static const String startTripValidationUrl =
      'api/uco-schedule-itineraries/{itineraryId}/driver-journey-start';
  static const String ucoScheduleCancelUrl = 'api/cancellation-remarks';
  static const String updateWorkFlowStatusUrl = 'api/update-workflow-status';

  static const String arrivedAtWarehouse = 'api/uco-schedule-itineraries';
  static const String ucoScheduleItineraryUrl = 'api/uco-schedule-itineraries';

  static const String ucoScheduleWHRouteUrl =
      'api/uco-schedule-itinerary-route-wf-audits/';
  static const String ucoSchedulePickUpRouteUrl =
      'api/uco-schedule-itinerary-route-wf-audits/';
}
