import 'dart:ui';

class AppStrings {
  static String _lang = 'en';

  static void setLocale(Locale locale) {
    _lang = locale.languageCode == 'is' ? 'is' : 'en';
  }

  static String _t(String key) {
    return (_localized[_lang]?[key] ?? _localized['en']?[key] ?? key);
  }

  static const String customer = "customer";
  static const String driver = "driver";
  static const String drivercap = "Driver";

  static String get appName => _t('appName');
  static String get rider => _t('rider');
  static String get travelwithsafety => _t('travelwithsafety');
  static String get register => _t('register');
  static String get ratings => _t('ratings');
  static String get login => _t('login');
  static String get next => _t('next');
  static String get notnow => _t('notnow');
  static String get addastop => _t('addastop');
  static String get bookaride => _t('bookaride');
  static String get sharearide => _t('sharearide');
  static String get vehicles => _t('vehicles');
  static String get vehicledetails => _t('vehicledetails');
  static String get wantosave => _t('wantosave');
  static String get enteryourdetails => _t('enteryourdetails');
  static String get verification => _t('verification');
  static String get verifymobilenumber => _t('verifymobilenumber');
  static String get verify => _t('verify');
  static String get entermobilenumber => _t('entermobilenumber');
  static String get home => _t('home');
  static String get yourcurrentlocation => _t('yourcurrentlocation');
  static String get whereto => _t('whereto');
  static String get confirmdestination => _t('confirmdestination');
  static String get destination => _t('destination');
  static String get from => _t('from');
  static String get currentLocation => _t('currentLocation');
  static String get wheretoo => _t('wheretoo');
  static String get confirm => _t('confirm');
  static String get done => _t('done');
  static String get choose => _t('choose');
  static String get myTrips => _t('myTrips');
  static String get payment => _t('payment');
  static String get profile => _t('profile');
  static String get aboutus => _t('aboutus');
  static String get terms => _t('terms');
  static String get privacy => _t('privacy');
  static String get logout => _t('logout');
  static String get suretologout => _t('suretologout');
  static String get cancel => _t('cancel');
  static String get savechanges => _t('savechanges');
  static String get cancelride => _t('cancelride');
  static String get pleaseselectreason => _t('pleaseselectreason');
  static String get send => _t('send');
  static String get welcome => _t('welcome');
  static String get fillvehicledetail => _t('fillvehicledetail');
  static String get chooseVehicleType => _t('chooseVehicleType');
  static String get enterVehicleMake => _t('enterVehicleMake');
  static String get enterVehicleModel => _t('enterVehicleModel');
  static String get vehicleYear => _t('vehicleYear');
  static String get enterRegistrationNumber => _t('enterRegistrationNumber');
  static String get enterVehicleColour => _t('enterVehicleColour');
  static String get addvehicleimage => _t('addvehicleimage');
  static String get adddoc => _t('adddoc');
  static String get fillRequiredSteps => _t('fillRequiredSteps');
  static String get whatyouneedtodo => _t('whatyouneedtodo');
  static String get profilePhoto => _t('profilePhoto');
  static String get recommendednextstep => _t('recommendednextstep');
  static String get drivingLicenseFront => _t('drivingLicenseFront');
  static String get drivingLicense => _t('drivingLicense');
  static String get getStarted => _t('getStarted');
  static String get vehicleInsurance => _t('vehicleInsurance');
  static String get registrationCertificate => _t('registrationCertificate');
  static String get backgroundCheckVerification =>
      _t('backgroundCheckVerification');
  static String get usethisphoto => _t('usethisphoto');
  static String get retake => _t('retake');
  static String get submit => _t('submit');
  static String get takephoto => _t('takephoto');
  static String get save => _t('save');
  static String get gotoaccountstatus => _t('gotoaccountstatus');
  static String get gotonextstep => _t('gotonextstep');
  static String get thanksforyourphoto => _t('thanksforyourphoto');
  static String get registrationCert => _t('registrationCert');
  static String get backgroundveragree => _t('backgroundveragree');
  static String get agree => _t('agree');
  static String get arrive => _t('arrive');
  static String get signupusing => _t('signupusing');
  static String get phonenumber => _t('phonenumber');
  static String get apple => _t('apple');
  static String get google => _t('google');
  static String get resendCode => _t('resendCode');
  static String get didnotrec => _t('didnotrec');
  static String get editprofile => _t('editprofile');
  static String get chat => _t('chat');
  static String get loading => _t('loading');
  static String get useappas => _t('useappas');
  static String get user => _t('user');
  static String get wallet => _t('wallet');
  static String get manageyourvehicle => _t('manageyourvehicle');
  static String get nointernet => _t('nointernet');
  static String get cantSendEmptyMessage => _t('cantSendEmptyMessage');
  static String get sendamessage => _t('sendamessage');
  static String get yes => _t('yes');
  static String get checkyourconnection => _t('checkyourconnection');
  static String get rides => _t('rides');
  static String get events => _t('events');
  static String get account => _t('account');
  static String get emailupdate => _t('emailupdate');
  static String get deleteAccount => _t('deleteAccount');
  static String get happening => _t('happening');
  static String get selectcontacts => _t('selectcontacts');
  static String get confirmpickup => _t('confirmpickup');
  static String get dropoff => _t('dropoff');
  static String get pickup => _t('pickup');
  static String get choosepickuptime => _t('choosepickuptime');
  static String get location => _t('location');
  static String get categories => _t('categories');
  static String get eventfilters => _t('eventfilters');
  static String get eventdate => _t('eventdate');
  static String get eventdescription => _t('eventdescription');
  static String get visitwebsite => _t('visitwebsite');
  static String get visitprofile => _t('visitprofile');
  static String get watchtoearn => _t('watchtoearn');
  static String get parcelpickup => _t('parcelpickup');
  static String get profilesettings => _t('profilesettings');
  static String get signinsecurity => _t('signinsecurity');
  static String get paymentsprefs => _t('paymentsprefs');
  static String get subscriptions => _t('subscriptions');
  static String get rideprefs => _t('rideprefs');
  static String get notificationsetting => _t('notificationsetting');
  static String get apprefs => _t('apprefs');
  static String get supportlegal => _t('supportlegal');
  static String get signinandsecurity => _t('signinandsecurity');
  static String get passkeys => _t('passkeys');
  static String get recoverymethod => _t('recoverymethod');
  static String get connectedsocialmedia => _t('connectedsocialmedia');
  static String get addcard => _t('addcard');
  static String get addigitalwallet => _t('addigitalwallet');
  static String get riderequest => _t('riderequest');
  static String get scheduledride => _t('scheduledride');
  static String get addaddress => _t('addaddress');
  static String get helpcenter => _t('helpcenter');
  static String get contactus => _t('contactus');
  static String get emergencyassistance => _t('emergencyassistance');
  static String get reportproblm => _t('reportproblm');
  static String get emailsupport => _t('emailsupport');
  static String get messages => _t('messages');
  static String get yourearnings => _t('yourearnings');
  static String get referafriend => _t('referafriend');
  static String get buyleggoshares => _t('buyleggoshares');
  static String get myevents => _t('myevents');
  static String get changeLanguage => _t('changeLanguage');
  static String get yourVehicles => _t('yourVehicles');
  static String get onYourWayToRewards => _t('onYourWayToRewards');
  static String get of => _t('of');
  static String get welcomeToDashboard => _t('welcomeToDashboard');
  static String get letsDrive => _t('letsDrive');
  static String get youAreCurrently => _t('youAreCurrently');
  static String get online => _t('online');
  static String get offline => _t('offline');
  static String get acceptingRides => _t('acceptingRides');
  static String get rejectingRides => _t('rejectingRides');
  static String get accountDetails => _t('accountDetails');
  static String get settings => _t('settings');
  static String get rideRequests => _t('rideRequests');
  static String get tripHistoryTitle => _t('tripHistoryTitle');
  static String get youAreOfflineGoOnline => _t('youAreOfflineGoOnline');
  static String get pleaseWaitDocsApproval => _t('pleaseWaitDocsApproval');
  static String get english => _t('english');
  static String get icelandic => _t('icelandic');
  static String get recentTrips => _t('recent_trips');
  static String get filters => _t('filters');
  static String get thereIsNoRecordOfPreviousTrips =>
      _t('there_is_no_record_of_previous_trips');
  static String get completed => _t('completed');
  static String get cancelled => _t('cancelled');
  static String get searchFilters => _t('search_filters');
  static String get timeRange => _t('time_range');
  static String get distance => _t('distance');
  static String get rideStatus => _t('ride_status');

  static String get hundredRides => _t('100_rides');
  static String get twoHundredRides => _t('200_rides');
  static String get currentRides => _t('current_rides');
  static String get scheduledRides => _t('scheduled_rides');
  static String get route => _t('route');
  static String get currentlyNorides => _t('currently_no_rides_available');
  static String get totalFare => _t('total_fare');
  static String get accept => _t('accept');
  static String get decline => _t('decline');
  static String get currentlyNoRideRequests => _t('currently_no_ride_requests');
  static String get firstName => _t('first_name');
  static String get lastName => _t('last_name');
  static String get email => _t('email');
  static String get changeEmail => _t('change_email');
  static String get useEmailToRecieveMessages =>
      _t('use_email_to_recieve_messages');
  static String get code => _t('code');
  static String get usePhoneToRecieveNotifications =>
      _t('use_phone_to_recieve_notifications');
  static String get deleteVehicles => _t('delete_vehicles');
  static String get viewDocuments => _t('view_documents');
  static String get setAsDefault => _t('set_as_default');
  static String get view => _t('view');
  static String get addVehicles => _t('add_vehicles');
  static String get noDataAvailable => _t('no_data_available');
  static String get thisIsDefaultVehicle => _t('this_is_default_vehicle');
  static String get vehicleType => _t('vehicle_type');
  static String get vehicleMake => _t('vehicle_make');
  static String get vehicleModel => _t('vehicle_model');
  static String get vehicleColor => _t('vehicle_color');
  static String get registrationNumber => _t('registration_number');
  static String get vehicleImages => _t('vehicle_images');
  static String get waitingForAdminApproval => _t('waiting_for_admin_approval');
  static String get select => _t('select');
  static String get make => _t('make');
  static String get model => _t('model');
  static String get color => _t('color');
  static String get number => _t('number');
  static String get photoGallery => _t('photo_gallery');
  static String get camera => _t('camera');
  static String get welcomeDriver => _t('welcome_driver');
  static String get takePhotoVehicleInsurance =>
      _t('take_photo_vehicle_insurance');
  static String get makeSureVehicleInsurance =>
      _t('make_sure_vehicle_insurance');
  static String get takePhotoRc => _t('take_photo_rc');
  static String get makeSureRc => _t('make_sure_rc');
  static String get takePhotoDrivingLicense => _t('take_photo_driving_license');
  static String get uploadDrivingLicense => _t('upload_driving_license');
  static String get inProgress => _t('in_progress');
  static String get complete => _t('complete');
  static String get addProfileToMove => _t('add_profile_to_move');
  static String get addDrivingLicenseToMove => _t('add_driving_to_move');
  static String get addVehicleInsuranceToMove =>
      _t('add_vehicle_insurance_to_move');
  static String get addRcToMove => _t('add_rc_to_move');
  static String get takeProfilePhoto => _t('take_profile_photo');
  static String get profilePhotoHelps => _t('profile_photo_helps');
  static String get wantToUsePhoto => _t('want_to_use_photo');
  static String get makeSureDrivingLicense => _t('make_sure_driving_license');
  static String get addBackPhoto => _t('add_back_photo');
  static String get continueUploadingVehicle =>
      _t('continue_uploading_vehicle');
  static String get insurance => _t('insurance');
  static String get takeAdditionalPhoto => _t('take_additional_photo');
  static String get continueUploadingRc => _t('continue_upload_rc');
  static String get submitted => _t('submitted');
  static String get pending => _t('pending');
  static String get byTappingYes => _t('by_tapping_yes');
  static String get vendorCanCollect => _t('vendor_can_collect');
  static String get technologyThatAllows => _t('technology_that_allows');
  static String get thankyouForUploadingDriving =>
      _t('thankyou_for_uploading_driving');
  static String get thankyouForUploadingVehicleInsurance =>
      _t('thankyou_for_uploading_vehicle_insurance');
  static String get thankyouForUploadingRc => _t('thankyou_for_uploading_rc');
  static String get tripDetails => _t('trip_details');
  static String get paymentInfo => _t('payment_info');
  static String get receipt => _t('receipt');
  static String get totalAmount => _t('total_amount');
  static String get billDetails => _t('bill_details');
  static String get subtotal => _t('subtotal');
  static String get tax => _t('tax');
  static String get paymentMethod => _t('payment_method');
  static String get riderInfo => _t('rider_info');
  static String get feedback => _t('feedback');
  static String get packageInfo => _t('package_info');
  static String get needHelp => _t('need_help');
  static String get reportIssue => _t('report_issue');
  static String get requestSupport => _t('request_support');
  static String get tripRoute => _t('trip_route');
  static String get stop1 => _t('stop_1');
  static String get stop2 => _t('stop_2');
  static String get stop3 => _t('stop_3');
  static String get source => _t('source');
  static String get splittedPrice => _t('splitted_price');
  static String get enterPickupOtp => _t('enter_pickup_otp');
  static String get startRide => _t('start_ride');
  static String get endRide => _t('end_ride');
  static String get howWasTrip => _t('how_was_trip');
  static String get comment => _t('comment');
  static String get profileCreationCompleted =>
      _t('profile_creation_completed');
  static String get youWillBeNotified => _t('you_will_be_notified');
  static String get moveToHome => _t('move_to_home');
  static String get cancellingTheRide => _t('cancelling_the_ride');
  static String get yourScheduledRides => _t('your_scheduled_rides');
  static String get offers => _t('offers');
  static String get noOffersMatch => _t('no_offers_match');
  static String get usageType => _t('usage_type');
  static String get redeem => _t('redeem');
  static String get redeemRequestPlaced => _t('redeem_request_placed');
  static String get validFor => _t('valid_for');

  static String get noRidesAvailable => _t('no_rides_available');
  // static String get english => _t('english');
  // static String get english => _t('english');
  // static String get english => _t('english');

  static final Map<String, Map<String, String>> _localized = {
    'en': {
      'appName': '24*7 Taxi Driver',
      'rider': 'Rider',
      'travelwithsafety': 'Travel with safety',
      'register': 'Register',
      'ratings': 'Ratings',
      'login': 'Login',
      'next': 'Next',
      'notnow': 'Not Now',
      'addastop': 'add a stop',
      'bookaride': 'Book a Ride',
      'sharearide': 'Share a Ride',
      'vehicles': 'Vehicles',
      'vehicledetails': 'Vehicle Details',
      'wantosave':
          'Want to save money and reduce your\ncarbon footprint? Share a ride with others!',
      'enteryourdetails': 'Enter your details',
      'verification': 'Verification',
      'verifymobilenumber': 'Verify mobile number',
      'verify': 'Verify',
      'entermobilenumber': 'Enter Mobile Number',
      'home': 'Home',
      'yourcurrentlocation': 'Your Current Location',
      'whereto': 'Where To?',
      'confirmdestination': 'Confirm Destination',
      'destination': 'Destination',
      'from': 'From',
      'currentLocation': 'Current Location',
      'wheretoo': 'Where To',
      'confirm': 'Confirm',
      'done': 'Done',
      'choose': 'Choose Vehicle',
      'myTrips': 'Trip History',
      'payment': 'Payment',
      'profile': 'Profile',
      'aboutus': 'About Us',
      'terms': 'Terms and Conditions',
      'privacy': 'Privacy Policy',
      'logout': 'Logout',
      'suretologout': 'Are you sure you want to logout?',
      'cancel': 'Cancel',
      'savechanges': 'Save Changes',
      'cancelride': 'Cancel Ride',
      'pleaseselectreason': 'Please select a reason for',
      'send': 'Send',
      'welcome': 'Welcome',
      'fillvehicledetail': 'Please fill Vehicle Details',
      'chooseVehicleType': 'Choose Vehicle Type',
      'enterVehicleMake': 'Enter Vehicle Make',
      'enterVehicleModel': 'Enter Vehicle Model',
      'vehicleYear': 'Vehicle Year',
      'enterRegistrationNumber': 'Enter Registration Number',
      'enterVehicleColour': 'Enter Vehicle Colour',
      'addvehicleimage': 'Add Vehicle Image',
      'adddoc': 'add documents',
      'fillRequiredSteps': 'Please fill Required Steps',
      'whatyouneedtodo': 'Here’s what you need to do to set up your account.',
      'profilePhoto': 'Profile Photo',
      'recommendednextstep': 'Recommended next step',
      'drivingLicenseFront': 'Driving License - Front & Back',
      'drivingLicense': 'Driving License',
      'getStarted': 'Get Started',
      'vehicleInsurance': 'Vehicle Insurance',
      'registrationCertificate': 'Registration Certificate (RC)',
      'backgroundCheckVerification': 'Background Check Verification ',
      'usethisphoto': 'Use this photo?',
      'retake': 'Retake',
      'submit': 'Submit',
      'takephoto': 'Take Photo',
      'save': 'Save',
      'gotoaccountstatus': 'Go to Account Status',
      'gotonextstep': 'Go To Next Step',
      'thanksforyourphoto': 'Thanks For Your Photo',
      'registrationCert': 'Registration Certificate',
      'backgroundveragree': 'Background Verification \nAgreement',
      'agree': 'I Agree',
      'arrive': 'Arrive',
      'signupusing': 'Sign up using',
      'phonenumber': 'Phone Number',
      'apple': 'Apple',
      'google': 'Google',
      'resendCode': 'Resend Code',
      'didnotrec': "Didn't receive SMS? ",
      'editprofile': 'Edit profile',
      'chat': 'Chat',
      'loading': 'Syncing Contacts...',
      'useappas': 'Use App as a ',
      'user': 'User',
      'wallet': 'Wallet',
      'manageyourvehicle': 'Manage Your Vehicle',
      'nointernet': 'NO INTERNET',
      'cantSendEmptyMessage': "Can't Send Empty Message",
      'sendamessage': 'Send a message',
      'yes': 'Yes',
      'checkyourconnection': 'Check your connection and try again',
      'rides': 'Rides',
      'events': 'Events',
      'account': 'Account',
      'emailupdate': 'Email Update',
      'deleteAccount': 'Delete your account',
      'happening': '🎉 Happening Near You',
      'selectcontacts': 'Select Contact',
      'confirmpickup': 'Confirm Pick-up',
      'dropoff': 'Drop-off',
      'pickup': 'Pick-up',
      'choosepickuptime': 'Choose Pick-up Time',
      'location': 'Location',
      'categories': 'Categories',
      'eventfilters': 'Event Filters',
      'eventdate': 'Event Date',
      'eventdescription': 'Event Description',
      'visitwebsite': 'Visit Event Website',
      'visitprofile': 'Visit Social Profile',
      'watchtoearn': 'Watch to earn',
      'parcelpickup': 'Parcel Pickup',
      'profilesettings': 'Profile Settings',
      'signinsecurity': 'Sign-in and Security',
      'paymentsprefs': 'Payment Preferences (soon)',
      'subscriptions': 'Subscriptions',
      'rideprefs': 'Ride Preferences',
      'notificationsetting': 'Notification Settings',
      'apprefs': 'App Preferences',
      'supportlegal': 'Support & Legal',
      'signinandsecurity': 'Sign In and Security',
      'passkeys': 'Passkeys',
      'recoverymethod': 'Recovery Methods',
      'connectedsocialmedia': 'Connected Social Apps',
      'addcard': 'Add New Card',
      'addigitalwallet': 'Add Digital Wallet',
      'riderequest': 'Ride Requests',
      'scheduledride': 'Scheduled Rides',
      'addaddress': 'Add New Address',
      'helpcenter': 'Help Center',
      'contactus': 'Contact Us',
      'emergencyassistance': 'Emergency Assistance',
      'reportproblm': 'Report a Problem',
      'emailsupport': 'Email Support',
      'messages': 'Messages',
      'yourearnings': 'Your Earnings',
      'referafriend': 'Refer a Friend',
      'buyleggoshares': 'Buy Leggoo Share',
      'myevents': 'My Events',
      'changeLanguage': 'Change Language',
      'yourVehicles': 'Your Vehicles',
      'onYourWayToRewards': '🎉 You’re on your way to rewards!',
      'of': 'of',
      'welcomeToDashboard': 'Welcome to your dashboard',
      'letsDrive': "Let's Drive,",
      'youAreCurrently': 'You are currently',
      'online': 'Online',
      'offline': 'Offline',
      'acceptingRides': 'Accepting Rides',
      'rejectingRides': 'Rejecting Rides',
      'accountDetails': 'Account Details',
      'settings': 'Settings',
      'rideRequests': 'Ride Requests',
      'tripHistoryTitle': 'Trip History',
      'youAreOfflineGoOnline':
          'You are offline. Please go online to see ride requests',
      'pleaseWaitDocsApproval':
          "Please wait. Your vehicle documents are under the admin's approval process.",
      'english': 'English',
      'icelandic': 'Icelandic',
      'recent_trips': 'Recent Trips',
      'filters': 'Filters',
      'there_is_no_record_of_previous_trips':
          "There is no record of any previous trips.",
      'completed': 'Completed',
      'cancelled': 'Cancelled',
      'search_filters': 'Search Filters',
      'time_range': 'Time Range',
      'distance': 'Distance',
      'ride_status': 'Ride Status',
      '100_rides': "100\nRides",
      '200_rides': "200\nRides",
      'current_rides': "Current Rides",
      'scheduled_rides': "Scheduled Rides",
      'currently_no_rides_available': 'Currently No Rides Requests',
      'route': "Route",
      'total_fare': 'Total Fare',
      'accept': 'Accept',
      'decline': 'Decline',
      'currently_no_ride_requests': 'Currently No Rides Requests',
      'first_name': 'First Name',
      'last_name': 'Last Name',
      'email': 'Email',
      'change_email': 'Change Email?',
      'use_email_to_recieve_messages':
          'You’ll use this email to receive messages, sign in and recover your account',
      'code': 'Code',
      'use_phone_to_recieve_notifications':
          'You’ll use this phone number to get notifications, sign in, and recover your account.',
      'delete_vehicles': "Delete Vehicle",
      'view_documents': "View Documents",
      'set_as_default': "Set as Default",
      'view': 'View',
      'add_vehicles': 'Add Vehicle',
      'no_data_available': 'No Data Available!',
      'this_is_default_vehicle': 'This is your Default Vehicle',
      'vehicle_type': 'Vehicle Type',
      'vehicle_make': 'Vehicle Make',
      'vehicle_model': 'Vehicle Model',
      'vehicle_color': 'Vehicle Color',
      'registration_number': 'Registration Number',
      'vehicle_images': 'Vehicle Images',
      'waiting_for_admin_approval': 'Waiting for admin\'s\n approval',
      'select': "Select",
      'make': 'Make',
      'model': 'Model',
      'color': 'Color',
      'number': 'Number',
      'photo_gallery': 'Photo Gallery',
      'camera': 'Camera',
      'welcome_driver': 'WELCOME DRIVER',
      'take_photo_vehicle_insurance': 'Take a photo of your Vehicle Insurance',
      'make_sure_vehicle_insurance':
          'Make sure photo is not blurred and these details are clearly visible - Model, Vehicle number, Chasis number, Registration Name, Start Date, Expiry Date, Financier name or Company name. You may need to submit additional photos if your document has multiple pages or sides or if first image was not clear.',
      'take_photo_rc': 'Take a photo of your Registration Certificate (RC)',
      'make_sure_rc': 'Please make sure we can easily read all the details.',
      'take_photo_driving_license':
          'Take a photo of your Driving License - Front & Back',
      'upload_driving_license':
          '1. Upload backside of Driving Licence first if some information is present on backside before the front side upload.\n2. Make sure that your driver license validates the class of vehicle you are choosing to drive in GOTUO.\n3 .Make sure License number, Driving License Type, your Address, Father\'s Name, D.O.B, Expiration Date and Govt logo on the License are clearly visible and the photo is not blurred.',
      'in_progress': 'In Progress',
      'complete': 'Complete',
      'add_profile_to_move': 'Add Profile Photo To Move Further',
      'add_driving_to_move': 'Add Driving License To Move Further',
      'add_vehicle_insurance_to_move': 'Add Vehicle Insurance To Move Further',
      'add_rc_to_move': 'Add Registration Certificate To Move Further',
      'take_profile_photo': 'Take your profile photo',
      'profile_photo_helps':
          'Your profile photo helps people recognize you. Please note that once you submit your profile photo it cannot be changed.',
      'want_to_use_photo': 'Want to use this photo?',
      'make_sure_driving_license':
          'Make sure your Driving License - Back is readable',
      'add_back_photo': 'Add Back Photo of The License',
      'continue_uploading_vehicle': 'Continue uploading your Vehicle',
      'insurance': 'Insurance',
      'take_additional_photo':
          'Take an additional photo if your document has multiple pages or sides or if first image was not clear.',
      'continue_upload_rc':
          'Continue uploading your Registration Certificate (RC)',
      'submitted': 'Submitted',
      'pending': 'Pending',
      'by_tapping_yes': 'By tapping save, you agree that you or a trusted',
      'vendor_can_collect': 'vendor can collect and process your photos with',
      'technology_that_allows':
          'technology that allows us to verify your identity.',
      'thankyou_for_uploading_driving':
          'Thanks for providing your Driving License - Front & Back',
      'thankyou_for_uploading_vehicle_insurance':
          'Thanks for providing your Vehicle Insurance',
      'thankyou_for_uploading_rc':
          'Thanks for providing your Registration Certificate (RC)',
      'trip_details': 'Trip Details',
      'payment_info': 'Payment Info',
      'receipt': 'Receipt',
      'total_amount': 'Total Amount',
      'bill_details': 'Bill Details',
      'subtotal': 'Subtotal',
      'tax': 'Tax',
      'payment_method': 'Payment Method',
      'rider_info': 'Rider Info',
      'feedback': 'Feedback',
      'package_info': 'Package Info',
      'need_help': 'Need Help?',
      'report_issue': 'Report Issue',
      'request_support': 'Request Support',
      'trip_route': 'Trip Route',
      'stop_1': 'Stop 1',
      'stop_2': 'Stop 2',
      'stop_3': 'Stop 3',
      'source': 'Source',
      'splitted_price': 'Splitted Price:',
      'enter_pickup_otp': 'Enter Pickup OTP',
      'start_ride': 'Start Ride',
      'end_ride': "End Ride",
      'how_was_trip': 'How  was Your Trip?',
      'comment': 'comment',
      'profile_creation_completed': 'Profile Creation Completed',
      'you_will_be_notified':
          'You will be notified when Admin will verify all details from his end',
      'move_to_home': 'Move to Home',
      'cancelling_the_ride': 'cancelling the ride',
      'your_scheduled_rides': 'Your Scheduled Rides',
      'offers': 'Offers',
      'no_offers_match':
          'No offers match your location, schedule, or filters right now.',
      'usage_type': 'Usage Type',
      'redeem': 'Redeem',
      'redeem_request_placed': 'Redeem request placed',
      'valid_for': 'Valid for',

      'no_rides_available':'No Rides Available',
    },
    'is': {
      'appName': '24*7 Leigubílstjóri',
      'rider': 'Farþegi',
      'travelwithsafety': 'Ferðastu örugglega',
      'register': 'Skráning',
      'ratings': 'Einkunnir',
      'login': 'Innskráning',
      'next': 'Næsta',
      'notnow': 'Ekki núna',
      'addastop': 'bæta við stoppi',
      'bookaride': 'Bóka ferð',
      'sharearide': 'Deila ferð',
      'vehicles': 'Ökutæki',
      'vehicledetails': 'Upplýsingar um ökutæki',
      'wantosave':
          'Viltu spara peninga og minnka\nkolefnissporið? Deildu ferð með öðrum!',
      'enteryourdetails': 'Sláðu inn upplýsingar',
      'verification': 'Staðfesting',
      'verifymobilenumber': 'Staðfestu símanúmer',
      'verify': 'Staðfesta',
      'entermobilenumber': 'Sláðu inn símanúmer',
      'home': 'Heim',
      'yourcurrentlocation': 'Núverandi staðsetning',
      'whereto': 'Hvert?',
      'confirmdestination': 'Staðfesta áfangastað',
      'destination': 'Áfangastaður',
      'from': 'Frá',
      'currentLocation': 'Núverandi staðsetning',
      'wheretoo': 'Hvert',
      'confirm': 'Staðfesta',
      'done': 'Lokið',
      'choose': 'Velja ökutæki',
      'myTrips': 'Ferðasaga',
      'payment': 'Greiðsla',
      'profile': 'Prófíll',
      'aboutus': 'Um okkur',
      'terms': 'Skilmálar',
      'privacy': 'Persónuverndarstefna',
      'logout': 'Skrá út',
      'suretologout': 'Ertu viss um að þú viljir skrá þig út?',
      'cancel': 'Hætta við',
      'savechanges': 'Vista breytingar',
      'cancelride': 'Hætta við ferð',
      'pleaseselectreason': 'Vinsamlegast veldu ástæðu fyrir',
      'send': 'Senda',
      'welcome': 'Velkomin',
      'fillvehicledetail': 'Vinsamlegast fylltu inn upplýsingar um ökutæki',
      'chooseVehicleType': 'Veldu tegund ökutækis',
      'enterVehicleMake': 'Sláðu inn framleiðanda',
      'enterVehicleModel': 'Sláðu inn gerð',
      'vehicleYear': 'Árgerð',
      'enterRegistrationNumber': 'Sláðu inn skráningarnúmer',
      'enterVehicleColour': 'Sláðu inn lit ökutækis',
      'addvehicleimage': 'Bæta við mynd af ökutæki',
      'adddoc': 'bæta við skjölum',
      'fillRequiredSteps': 'Vinsamlegast kláraðu nauðsynleg skref',
      'whatyouneedtodo':
          'Hér er það sem þú þarft að gera til að setja upp aðganginn.',
      'profilePhoto': 'Prófílmynd',
      'recommendednextstep': 'Mælt næsta skref',
      'drivingLicenseFront': 'Ökuskírteini - framan og aftan',
      'drivingLicense': 'Ökuskírteini',
      'getStarted': 'Byrja',
      'vehicleInsurance': 'Trygging ökutækis',
      'registrationCertificate': 'Skráningarskírteini (RC)',
      'backgroundCheckVerification': 'Bakgrunnsskoðun ',
      'usethisphoto': 'Nota þessa mynd?',
      'retake': 'Taka aftur',
      'submit': 'Senda inn',
      'takephoto': 'Taka mynd',
      'save': 'Vista',
      'gotoaccountstatus': 'Fara í stöðu aðgangs',
      'gotonextstep': 'Fara í næsta skref',
      'thanksforyourphoto': 'Takk fyrir myndina',
      'registrationCert': 'Skráningarskírteini',
      'backgroundveragree': 'Samþykki fyrir \n bakgrunnsskoðun',
      'agree': 'Ég samþykki',
      'arrive': 'Koma',
      'signupusing': 'Skrá með',
      'phonenumber': 'Símanúmer',
      'apple': 'Apple',
      'google': 'Google',
      'resendCode': 'Senda kóða aftur',
      'didnotrec': 'Fékkst ekki SMS? ',
      'editprofile': 'Breyta prófíl',
      'chat': 'Spjall',
      'loading': 'Samstilli tengiliði...',
      'useappas': 'Nota app sem ',
      'user': 'Notandi',
      'wallet': 'Veski',
      'manageyourvehicle': 'Stjórna ökutæki',
      'nointernet': 'ENGIN NETTENGING',
      'cantSendEmptyMessage': 'Ekki hægt að senda tómt skilaboð',
      'sendamessage': 'Senda skilaboð',
      'yes': 'Já',
      'checkyourconnection': 'Athugaðu tenginguna og reyndu aftur',
      'rides': 'Ferðir',
      'events': 'Viðburðir',
      'account': 'Aðgangur',
      'emailupdate': 'Uppfærsla á netfangi',
      'deleteAccount': 'Eyða aðgangi',
      'happening': '🎉 Að gerast nálægt þér',
      'selectcontacts': 'Velja tengilið',
      'confirmpickup': 'Staðfesta sókn',
      'dropoff': 'Afhending',
      'pickup': 'Sókn',
      'choosepickuptime': 'Veldu sóknartíma',
      'location': 'Staðsetning',
      'categories': 'Flokkar',
      'eventfilters': 'Viðburðasíur',
      'eventdate': 'Dagsetning viðburðar',
      'eventdescription': 'Lýsing viðburðar',
      'visitwebsite': 'Heimsækja vefsíðu viðburðar',
      'visitprofile': 'Heimsækja samfélagsprófíl',
      'watchtoearn': 'Horfa og vinna',
      'parcelpickup': 'Sækja sendingu',
      'profilesettings': 'Prófílstillingar',
      'signinsecurity': 'Innskráning og öryggi',
      'paymentsprefs': 'Greiðslustillingar (bráðum)',
      'subscriptions': 'Áskriftir',
      'rideprefs': 'Ferðastillingar',
      'notificationsetting': 'Tilkynningastillingar',
      'apprefs': 'App-stillingar',
      'supportlegal': 'Aðstoð og lög',
      'signinandsecurity': 'Innskráning og öryggi',
      'passkeys': 'Aðgangslyklar',
      'recoverymethod': 'Endurheimtaraðferðir',
      'connectedsocialmedia': 'Tengdar samfélagsaðgerðir',
      'addcard': 'Bæta við korti',
      'addigitalwallet': 'Bæta við stafrænu veski',
      'riderequest': 'Ferðabeiðnir',
      'scheduledride': 'Áætlaðar ferðir',
      'addaddress': 'Bæta við heimilisfangi',
      'helpcenter': 'Hjálparmiðstöð',
      'contactus': 'Hafa samband',
      'emergencyassistance': 'Neyðaraðstoð',
      'reportproblm': 'Tilkynna vandamál',
      'emailsupport': 'Tölvupóst stuðningur',
      'messages': 'Skilaboð',
      'yourearnings': 'Tekjur þínar',
      'referafriend': 'Mæla með vini',
      'buyleggoshares': 'Kaupa Leggoo hlut',
      'myevents': 'Mínir viðburðir',
      'changeLanguage': 'Breyta tungumáli',
      'yourVehicles': 'Ökutækin þín',
      'onYourWayToRewards': '🎉 Þú ert á leiðinni í verðlaun!',
      'of': 'af',
      'welcomeToDashboard': 'Velkomin á stjórnborðið',
      'letsDrive': 'Keyrum af stað,',
      'youAreCurrently': 'Þú ert núna',
      'online': 'Á neti',
      'offline': 'Ótengdur',
      'acceptingRides': 'Tek við ferðum',
      'rejectingRides': 'Tek ekki við ferðum',
      'accountDetails': 'Upplýsingar um aðgang',
      'settings': 'Stillingar',
      'rideRequests': 'Ferðabeiðnir',
      'tripHistoryTitle': 'Ferðasaga',
      'youAreOfflineGoOnline':
          'Þú ert ótengdur. Farðu á netið til að sjá ferðabeiðnir',
      'pleaseWaitDocsApproval':
          'Vinsamlegast bíddu. Skjöl ökutækis eru í samþykkisferli hjá stjórnanda.',
      'english': 'Enska',
      'icelandic': 'Íslenska',
      'recent_trips': 'Nýlegar ferðir',
      'filters': 'Síur',
      'there_is_no_record_of_previous_trips':
          'Engin skrá er til um fyrri ferðir.',
      'completed': 'Lokið',
      'cancelled': 'Hætt við',
      'search_filters': 'Leitarsíur',
      'time_range': 'Tímabil',
      'distance': 'Vegalengd',
      'ride_status': 'Staða ferðar',
      '100_rides': "100\nFerðir",
      '200_rides': "200\nFerðir",
      'current_rides': "Núverandi ferðir",
      'scheduled_rides': "Áætlaðar ferðir",
      'currently_no_rides_available': 'Engar ferðarbeiðnir í augnablikinu',
      'route': "Leið",
      'total_fare': 'Heildargjald',
      'accept': 'Samþykkja',
      'decline': 'Hafna',
      'currently_no_ride_requests': 'Engar ferðarbeiðnir í augnablikinu',
      'first_name': 'Fornafn',
      'last_name': 'Eftirnafn',
      'email': 'Netfang',
      'change_email': 'Breyta netfangi?',
      'use_email_to_recieve_messages':
          'Þú munt nota þetta netfang til að fá skilaboð, skrá þig inn og endurheimta aðganginn þinn',
      'code': 'Kóði',
      'use_phone_to_recieve_notifications':
          'Þú munt nota þetta símanúmer til að fá tilkynningar, skrá þig inn og endurheimta aðganginn þinn.',
      'delete_vehicles': "Eyða ökutæki",
      'view_documents': "Skoða skjöl",
      'set_as_default': "Setja sem sjálfgefið",
      'view': 'Skoða',
      'add_vehicles': 'Bæta við ökutæki',
      'no_data_available': 'Engin gögn tiltæk!',
      'this_is_default_vehicle': 'Þetta er sjálfgefna ökutækið þitt',
      'vehicle_type': 'Tegund ökutækis',
      'vehicle_make': 'Framleiðandi ökutækis',
      'vehicle_model': 'Gerð ökutækis',
      'vehicle_color': 'Litur ökutækis',
      'registration_number': 'Skráningarnúmer',
      'vehicle_images': 'Myndir af ökutæki',
      'waiting_for_admin_approval': 'Bíður eftir\n samþykki stjórnanda',
      'select': "Velja",
      'make': 'Framleiðandi',
      'model': 'Gerð',
      'color': 'Litur',
      'number': 'Númer',
      'photo_gallery': 'Myndasafn',
      'camera': 'Myndavél',
      'welcome_driver': 'VELKOMINN ÖKUMAÐUR',
      'take_photo_vehicle_insurance':
          'Taktu mynd af tryggingu ökutækisins þíns',
      'make_sure_vehicle_insurance':
          'Gakktu úr skugga um að myndin sé ekki óskýr og að eftirfarandi upplýsingar séu skýrt sýnilegar - Gerð, ökutækjanúmer, undirvagnsnúmer, skráningarheiti, upphafsdagur, lokadagur, nafn fjármögnunaraðila eða nafn fyrirtækis. Þú gætir þurft að senda inn fleiri myndir ef skjalið þitt hefur margar síður eða hliðar eða ef fyrsta myndin var ekki skýr.',
      'take_photo_rc': 'Taktu mynd af skráningarskírteini ökutækis (RC)',
      'make_sure_rc':
          'Vinsamlegast tryggðu að við getum auðveldlega lesið allar upplýsingar.',
      'take_photo_driving_license':
          'Taktu mynd af ökuskírteininu þínu - framhlið og bakhlið',
      'upload_driving_license':
          '1. Hladdu fyrst upp bakhlið ökuskírteinisins ef einhverjar upplýsingar eru þar áður en framhliðinni er hlaðið upp.\n2. Gakktu úr skugga um að ökuskírteinið þitt heimili þann flokk ökutækis sem þú velur að aka í GOTUO.\n3. Gakktu úr skugga um að númer ökuskírteinis, tegund ökuskírteinis, heimilisfang þitt, nafn föður, fæðingardagur, gildistími og ríkismerki á skírteininu séu skýrt sýnileg og að myndin sé ekki óskýr.',
      'in_progress': 'Í vinnslu',
      'complete': 'Lokið',
      'add_profile_to_move': 'Bættu við prófílmynd til að halda áfram',
      'add_driving_to_move': 'Bættu við ökuskírteini til að halda áfram',
      'add_vehicle_insurance_to_move':
          'Bættu við tryggingu ökutækis til að halda áfram',
      'add_rc_to_move': 'Bættu við skráningarskírteini til að halda áfram',
      'take_profile_photo': 'Taktu prófílmynd',
      'profile_photo_helps':
          'Prófílmyndin þín hjálpar fólki að þekkja þig. Athugaðu að þegar þú hefur sent inn prófílmyndina er ekki hægt að breyta henni.',
      'want_to_use_photo': 'Viltu nota þessa mynd?',
      'make_sure_driving_license':
          'Gakktu úr skugga um að bakhlið ökuskírteinisins sé læsileg',
      'add_back_photo': 'Bæta við bakhlið ökuskírteinisins',
      'continue_uploading_vehicle': 'Halda áfram að hlaða upp ökutækinu þínu',
      'insurance': 'Trygging',
      'take_additional_photo':
          'Taktu viðbótarmynd ef skjalið þitt hefur margar síður eða hliðar eða ef fyrsta myndin var ekki skýr.',
      'continue_upload_rc':
          'Halda áfram að hlaða upp skráningarskírteini ökutækis (RC)',
      'submitted': 'Sent inn',
      'pending': 'Í bið',
      'by_tapping_yes':
          'Með því að ýta á vista samþykkir þú að þú eða traustur',
      'vendor_can_collect':
          'þjónustuaðili getur safnað og unnið úr myndunum þínum með',
      'technology_that_allows':
          'tækni sem gerir okkur kleift að staðfesta auðkenni þitt.',
      'thankyou_for_uploading_driving':
          'Takk fyrir að senda inn ökuskírteinið þitt - framhlið og bakhlið',
      'thankyou_for_uploading_vehicle_insurance':
          'Takk fyrir að senda inn tryggingu ökutækisins þíns',
      'thankyou_for_uploading_rc':
          'Takk fyrir að senda inn skráningarskírteini ökutækis (RC)',
      'trip_details': 'Ferðaupplýsingar',
      'payment_info': 'Greiðsluupplýsingar',
      'receipt': 'Kvittun',
      'total_amount': 'Heildarupphæð',
      'bill_details': 'Reikningsupplýsingar',
      'subtotal': 'Millisamtala',
      'tax': 'Skattur',
      'payment_method': 'Greiðslumáti',
      'rider_info': 'Upplýsingar um farþega',
      'feedback': 'Endurgjöf',
      'package_info': 'Upplýsingar um pakka',
      'need_help': 'Þarftu hjálp?',
      'report_issue': 'Tilkynna vandamál',
      'request_support': 'Biðja um aðstoð',
      'trip_route': 'Ferðaleið',
      'stop_1': 'Stopp 1',
      'stop_2': 'Stopp 2',
      'stop_3': 'Stopp 3',
      'source': 'Uppruni',
      'splitted_price': 'Skipt verð:',
      'enter_pickup_otp': 'Sláðu inn OTP fyrir upphafsstað',
      'start_ride': 'Hefja ferð',
      'end_ride': 'Ljúka ferð',
      'how_was_trip': 'Hvernig var ferðin þín?',
      'comment': 'Athugasemd',
      'profile_creation_completed': 'Stofnun prófíls lokið',
      'you_will_be_notified':
          'Þú færð tilkynningu þegar stjórnandi hefur staðfest allar upplýsingar',
      'move_to_home': 'Fara á heim',
      'cancelling_the_ride': 'Hætti við ferðina',
      'your_scheduled_rides': 'Þínar áætluðu ferðir',
      'offers': 'Tilboð',
      'no_offers_match':
          'Engin tilboð passa við staðsetningu, tíma eða aðrar kröfur eins og er.',
      'usage_type': 'Notkunartegund',
      'redeem': 'Innleysa',
      'redeem_request_placed': 'Innlausnarbeiðni send',
      'valid_for': 'Gildir í',
      'no_rides_available':'Engar ferðir í boði',
    },
  };
}
