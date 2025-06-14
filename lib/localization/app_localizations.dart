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
/// import 'localization/app_localizations.dart';
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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('en')
  ];

  /// No description provided for @proklinik.
  ///
  /// In en, this message translates to:
  /// **'ProKliniK'**
  String get proklinik;

  /// No description provided for @moiErSystem.
  ///
  /// In en, this message translates to:
  /// **'MOI ER SYSTEM'**
  String get moiErSystem;

  /// No description provided for @moiErSystemRehab.
  ///
  /// In en, this message translates to:
  /// **'MOI ER SYSTEM - Rehab Military Medical Complex'**
  String get moiErSystemRehab;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Kindly Enter a Valid Email Address.'**
  String get enterValidEmail;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @kindlyEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Kindly Enter Password.'**
  String get kindlyEnterPassword;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @linkSentToEmail.
  ///
  /// In en, this message translates to:
  /// **'A Password Reset Link Was Sent To Your Email Address.'**
  String get linkSentToEmail;

  /// No description provided for @notRegisteredYet.
  ///
  /// In en, this message translates to:
  /// **'Not Registered Yet ?  '**
  String get notRegisteredYet;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create An Account.'**
  String get createAccount;

  /// No description provided for @logoutPromptTitle.
  ///
  /// In en, this message translates to:
  /// **'Log Out ?'**
  String get logoutPromptTitle;

  /// No description provided for @logoutPromptMessage.
  ///
  /// In en, this message translates to:
  /// **'Are You Sure ?'**
  String get logoutPromptMessage;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success...'**
  String get success;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @todayVisits.
  ///
  /// In en, this message translates to:
  /// **'Today Visits'**
  String get todayVisits;

  /// No description provided for @patients.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get patients;

  /// No description provided for @baseValidator.
  ///
  /// In en, this message translates to:
  /// **'Empty Inputs Are Not Allowed.'**
  String get baseValidator;

  /// No description provided for @phoneValidator.
  ///
  /// In en, this message translates to:
  /// **'Enter Valid Mobile Phone Number.(11 digits)'**
  String get phoneValidator;

  /// No description provided for @nationalIdValidator.
  ///
  /// In en, this message translates to:
  /// **'Enter Valid National Id Number.(14 digits)'**
  String get nationalIdValidator;

  /// No description provided for @addNewPatient.
  ///
  /// In en, this message translates to:
  /// **'Add New Patient'**
  String get addNewPatient;

  /// No description provided for @updatePatientData.
  ///
  /// In en, this message translates to:
  /// **'Update Patient Data'**
  String get updatePatientData;

  /// No description provided for @patientName.
  ///
  /// In en, this message translates to:
  /// **'Patient Name'**
  String get patientName;

  /// No description provided for @patientRank.
  ///
  /// In en, this message translates to:
  /// **'Patient Rank'**
  String get patientRank;

  /// No description provided for @patientWork.
  ///
  /// In en, this message translates to:
  /// **'Patient Workplace'**
  String get patientWork;

  /// No description provided for @patientNationalId.
  ///
  /// In en, this message translates to:
  /// **'Patient National Id'**
  String get patientNationalId;

  /// No description provided for @patientPhone.
  ///
  /// In en, this message translates to:
  /// **'Patient Phone Number'**
  String get patientPhone;

  /// No description provided for @phoneNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Patient Phone Could Not Be Acquired At Time Of Entry.'**
  String get phoneNotAvailable;

  /// No description provided for @noPatientsFound.
  ///
  /// In en, this message translates to:
  /// **'No Patients Found'**
  String get noPatientsFound;

  /// No description provided for @searchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search By Arabic Name / National Id'**
  String get searchTitle;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @clearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear Search'**
  String get clearSearch;

  /// No description provided for @addNewVisit.
  ///
  /// In en, this message translates to:
  /// **'Add New Visit'**
  String get addNewVisit;

  /// No description provided for @arrivalType.
  ///
  /// In en, this message translates to:
  /// **'Arrival Type'**
  String get arrivalType;

  /// No description provided for @noVisitsForToday.
  ///
  /// In en, this message translates to:
  /// **'No Visits Found For Today.'**
  String get noVisitsForToday;

  /// No description provided for @vitalSigns.
  ///
  /// In en, this message translates to:
  /// **'Vital Signs'**
  String get vitalSigns;

  /// No description provided for @addVitalSigns.
  ///
  /// In en, this message translates to:
  /// **'Add Vital Signs'**
  String get addVitalSigns;

  /// No description provided for @bp.
  ///
  /// In en, this message translates to:
  /// **'Bp'**
  String get bp;

  /// No description provided for @pulse.
  ///
  /// In en, this message translates to:
  /// **'Pulse'**
  String get pulse;

  /// No description provided for @rr.
  ///
  /// In en, this message translates to:
  /// **'RR'**
  String get rr;

  /// No description provided for @temp.
  ///
  /// In en, this message translates to:
  /// **'Temp'**
  String get temp;

  /// No description provided for @rbs.
  ///
  /// In en, this message translates to:
  /// **'RBS'**
  String get rbs;

  /// No description provided for @oxygen.
  ///
  /// In en, this message translates to:
  /// **'Oxygen'**
  String get oxygen;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @systole.
  ///
  /// In en, this message translates to:
  /// **'Systole'**
  String get systole;

  /// No description provided for @diastole.
  ///
  /// In en, this message translates to:
  /// **'Diastole'**
  String get diastole;

  /// No description provided for @arrivalTime.
  ///
  /// In en, this message translates to:
  /// **'Arrival Time'**
  String get arrivalTime;

  /// No description provided for @dischargeTime.
  ///
  /// In en, this message translates to:
  /// **'Discharge Time'**
  String get dischargeTime;

  /// No description provided for @admissionTime.
  ///
  /// In en, this message translates to:
  /// **'Admission Time'**
  String get admissionTime;

  /// No description provided for @recordingTime.
  ///
  /// In en, this message translates to:
  /// **'Data Entry Time'**
  String get recordingTime;

  /// No description provided for @dispositionStatus.
  ///
  /// In en, this message translates to:
  /// **'Disposition Status'**
  String get dispositionStatus;

  /// No description provided for @ambulanceDetails.
  ///
  /// In en, this message translates to:
  /// **'Ambulance Details'**
  String get ambulanceDetails;

  /// No description provided for @driverName.
  ///
  /// In en, this message translates to:
  /// **'Driver Name'**
  String get driverName;

  /// No description provided for @paramedicName.
  ///
  /// In en, this message translates to:
  /// **'Paramedic Name'**
  String get paramedicName;

  /// No description provided for @carCode.
  ///
  /// In en, this message translates to:
  /// **'Car Code'**
  String get carCode;

  /// No description provided for @admissionDetails.
  ///
  /// In en, this message translates to:
  /// **'Admission Details'**
  String get admissionDetails;

  /// No description provided for @printAdmissionSheet.
  ///
  /// In en, this message translates to:
  /// **'Print Admission Sheet'**
  String get printAdmissionSheet;

  /// No description provided for @printERSheet.
  ///
  /// In en, this message translates to:
  /// **'Print ER Sheet'**
  String get printERSheet;

  /// No description provided for @printReport.
  ///
  /// In en, this message translates to:
  /// **'Print Report'**
  String get printReport;

  /// No description provided for @relativeDetails.
  ///
  /// In en, this message translates to:
  /// **'Relative Details'**
  String get relativeDetails;

  /// No description provided for @relativeName.
  ///
  /// In en, this message translates to:
  /// **'Relative Name'**
  String get relativeName;

  /// No description provided for @relativeType.
  ///
  /// In en, this message translates to:
  /// **'Relative Type'**
  String get relativeType;

  /// No description provided for @relativeRank.
  ///
  /// In en, this message translates to:
  /// **'Relative Rank'**
  String get relativeRank;

  /// No description provided for @relativePhone.
  ///
  /// In en, this message translates to:
  /// **'Relative Phone'**
  String get relativePhone;

  /// No description provided for @relativeFamilyRelation.
  ///
  /// In en, this message translates to:
  /// **'Relative Family Relation'**
  String get relativeFamilyRelation;

  /// No description provided for @relativeNationalId.
  ///
  /// In en, this message translates to:
  /// **'Relative National Id'**
  String get relativeNationalId;

  /// No description provided for @emergencyConsultation.
  ///
  /// In en, this message translates to:
  /// **'Emergency Consultation'**
  String get emergencyConsultation;

  /// No description provided for @emergencyDoctor.
  ///
  /// In en, this message translates to:
  /// **'Emergency Doctor'**
  String get emergencyDoctor;

  /// No description provided for @selectEmergencyDoctor.
  ///
  /// In en, this message translates to:
  /// **'Select Emergency Doctor'**
  String get selectEmergencyDoctor;

  /// No description provided for @erConsultationResponse.
  ///
  /// In en, this message translates to:
  /// **'ER Consultation Response'**
  String get erConsultationResponse;

  /// No description provided for @labs.
  ///
  /// In en, this message translates to:
  /// **'Labs'**
  String get labs;

  /// No description provided for @rads.
  ///
  /// In en, this message translates to:
  /// **'Rads'**
  String get rads;

  /// No description provided for @procedures.
  ///
  /// In en, this message translates to:
  /// **'Procedures'**
  String get procedures;

  /// No description provided for @drugs.
  ///
  /// In en, this message translates to:
  /// **'Drugs'**
  String get drugs;

  /// No description provided for @erDrugs.
  ///
  /// In en, this message translates to:
  /// **'ER Drugs'**
  String get erDrugs;

  /// No description provided for @administeredDrugs.
  ///
  /// In en, this message translates to:
  /// **'Administered Drugs'**
  String get administeredDrugs;

  /// No description provided for @specConsultations.
  ///
  /// In en, this message translates to:
  /// **'Specialities Consultations'**
  String get specConsultations;

  /// No description provided for @addSpecConsultations.
  ///
  /// In en, this message translates to:
  /// **'Add Speciality Consultation'**
  String get addSpecConsultations;

  /// No description provided for @selectSpecDoctor.
  ///
  /// In en, this message translates to:
  /// **'Select Speciality Doctor'**
  String get selectSpecDoctor;

  /// No description provided for @selectSpecDoctorFirst.
  ///
  /// In en, this message translates to:
  /// **'Select Doctor For Consultation First.'**
  String get selectSpecDoctorFirst;

  /// No description provided for @specConsultationResponse.
  ///
  /// In en, this message translates to:
  /// **'Spec Consultation Response'**
  String get specConsultationResponse;

  /// No description provided for @admissionType.
  ///
  /// In en, this message translates to:
  /// **'Admission Type'**
  String get admissionType;

  /// No description provided for @admissionCondition.
  ///
  /// In en, this message translates to:
  /// **'Admission Condition'**
  String get admissionCondition;

  /// No description provided for @wardDetails.
  ///
  /// In en, this message translates to:
  /// **'Ward Details'**
  String get wardDetails;

  /// No description provided for @wardRoom.
  ///
  /// In en, this message translates to:
  /// **'Ward Room'**
  String get wardRoom;

  /// No description provided for @wardfloor.
  ///
  /// In en, this message translates to:
  /// **'Ward Floor'**
  String get wardfloor;

  /// No description provided for @icuDetails.
  ///
  /// In en, this message translates to:
  /// **'ICU Details'**
  String get icuDetails;

  /// No description provided for @icuName.
  ///
  /// In en, this message translates to:
  /// **'ICU Name'**
  String get icuName;

  /// No description provided for @icuBed.
  ///
  /// In en, this message translates to:
  /// **'ICU Bed'**
  String get icuBed;

  /// No description provided for @primaryDoctor.
  ///
  /// In en, this message translates to:
  /// **'Primary Doctor'**
  String get primaryDoctor;

  /// No description provided for @selectPrimaryDoctor.
  ///
  /// In en, this message translates to:
  /// **'Select Primary Doctor'**
  String get selectPrimaryDoctor;

  /// No description provided for @secondaryDoctor.
  ///
  /// In en, this message translates to:
  /// **'Secondary Doctor'**
  String get secondaryDoctor;

  /// No description provided for @selectSecondaryDoctor.
  ///
  /// In en, this message translates to:
  /// **'Select Secondary Doctor'**
  String get selectSecondaryDoctor;

  /// No description provided for @tertiaryDoctors.
  ///
  /// In en, this message translates to:
  /// **'Tertiary Doctors'**
  String get tertiaryDoctors;

  /// No description provided for @transferNurse.
  ///
  /// In en, this message translates to:
  /// **'Transfer Nurse'**
  String get transferNurse;

  /// No description provided for @admissionNurse.
  ///
  /// In en, this message translates to:
  /// **'Admission Nurse'**
  String get admissionNurse;

  /// No description provided for @selectTransferNurse.
  ///
  /// In en, this message translates to:
  /// **'Select Transfer Nurse'**
  String get selectTransferNurse;

  /// No description provided for @selectAdmissionNurse.
  ///
  /// In en, this message translates to:
  /// **'Select Admission Nurse'**
  String get selectAdmissionNurse;

  /// No description provided for @erSupervisorDoctor.
  ///
  /// In en, this message translates to:
  /// **'Er Supervisor Doctor'**
  String get erSupervisorDoctor;

  /// No description provided for @greaterOfficerDoctor.
  ///
  /// In en, this message translates to:
  /// **'Greater Officer Doctor'**
  String get greaterOfficerDoctor;

  /// No description provided for @selectErSupervisorDoctor.
  ///
  /// In en, this message translates to:
  /// **'Select Er Supervisor Doctor'**
  String get selectErSupervisorDoctor;

  /// No description provided for @selectGreaterOfficerDoctor.
  ///
  /// In en, this message translates to:
  /// **'Select Greater Officer Doctor'**
  String get selectGreaterOfficerDoctor;

  /// No description provided for @confirmDeleteAdmissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Admission ?'**
  String get confirmDeleteAdmissionTitle;

  /// No description provided for @confirmDeleteAdmissionMessage.
  ///
  /// In en, this message translates to:
  /// **'Delete Admission Data ? Continue ?'**
  String get confirmDeleteAdmissionMessage;

  /// No description provided for @deleteErVisit.
  ///
  /// In en, this message translates to:
  /// **'Delete Visit'**
  String get deleteErVisit;

  /// No description provided for @confirmDeleteVisitTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete ER Visit ?'**
  String get confirmDeleteVisitTitle;

  /// No description provided for @confirmDeleteVisitMessage.
  ///
  /// In en, this message translates to:
  /// **'Delete ER Visit for This Patient ? Continue ?'**
  String get confirmDeleteVisitMessage;

  /// No description provided for @printERAdmissionSheet.
  ///
  /// In en, this message translates to:
  /// **'Print ER Admission Sheet'**
  String get printERAdmissionSheet;

  /// No description provided for @past_Medical_History.
  ///
  /// In en, this message translates to:
  /// **'Past Medical History'**
  String get past_Medical_History;

  /// No description provided for @allergies.
  ///
  /// In en, this message translates to:
  /// **'Allergies'**
  String get allergies;

  /// No description provided for @surgries.
  ///
  /// In en, this message translates to:
  /// **'Surgries'**
  String get surgries;

  /// No description provided for @medicalDiseases.
  ///
  /// In en, this message translates to:
  /// **'Medical Diseases'**
  String get medicalDiseases;

  /// No description provided for @noVisitsFound.
  ///
  /// In en, this message translates to:
  /// **'No Visits Found'**
  String get noVisitsFound;

  /// No description provided for @previousErVisits.
  ///
  /// In en, this message translates to:
  /// **'Previous ER Visits'**
  String get previousErVisits;

  /// No description provided for @adminPanel.
  ///
  /// In en, this message translates to:
  /// **'Admin Panel'**
  String get adminPanel;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @clinics.
  ///
  /// In en, this message translates to:
  /// **'Clinics'**
  String get clinics;

  /// No description provided for @articles.
  ///
  /// In en, this message translates to:
  /// **'Articles'**
  String get articles;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @bookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get bookings;

  /// No description provided for @cases.
  ///
  /// In en, this message translates to:
  /// **'Cases'**
  String get cases;

  /// No description provided for @videos.
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get videos;

  /// No description provided for @siteSettings.
  ///
  /// In en, this message translates to:
  /// **'Site Settings'**
  String get siteSettings;

  /// No description provided for @socialContacts.
  ///
  /// In en, this message translates to:
  /// **'Social Contacts'**
  String get socialContacts;

  /// No description provided for @englishName.
  ///
  /// In en, this message translates to:
  /// **'English Name'**
  String get englishName;

  /// No description provided for @arabicName.
  ///
  /// In en, this message translates to:
  /// **'Arabic Name'**
  String get arabicName;

  /// No description provided for @englishTitle.
  ///
  /// In en, this message translates to:
  /// **'English Title'**
  String get englishTitle;

  /// No description provided for @arabicTitle.
  ///
  /// In en, this message translates to:
  /// **'Arabic Title'**
  String get arabicTitle;

  /// No description provided for @englishPrefix.
  ///
  /// In en, this message translates to:
  /// **'English Prefix'**
  String get englishPrefix;

  /// No description provided for @arabicPrefix.
  ///
  /// In en, this message translates to:
  /// **'Arabic Prefix'**
  String get arabicPrefix;

  /// No description provided for @avatar.
  ///
  /// In en, this message translates to:
  /// **'Avatar'**
  String get avatar;

  /// No description provided for @logo.
  ///
  /// In en, this message translates to:
  /// **'Logo'**
  String get logo;

  /// No description provided for @createClinic.
  ///
  /// In en, this message translates to:
  /// **'Create Clinic'**
  String get createClinic;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @offDates.
  ///
  /// In en, this message translates to:
  /// **'Off Dates'**
  String get offDates;

  /// No description provided for @deleteClinic.
  ///
  /// In en, this message translates to:
  /// **'Delete Clinic'**
  String get deleteClinic;

  /// No description provided for @deleteClinicConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Continue with Deleting This Clinic? Are You Sure?'**
  String get deleteClinicConfirmation;

  /// No description provided for @englishAddress.
  ///
  /// In en, this message translates to:
  /// **'English Address'**
  String get englishAddress;

  /// No description provided for @arabicAddress.
  ///
  /// In en, this message translates to:
  /// **'Arabic Address'**
  String get arabicAddress;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone;

  /// No description provided for @whatsapp.
  ///
  /// In en, this message translates to:
  /// **'Whatsapp Number'**
  String get whatsapp;

  /// No description provided for @locationLink.
  ///
  /// In en, this message translates to:
  /// **'Location Link'**
  String get locationLink;

  /// No description provided for @clinicInfo.
  ///
  /// In en, this message translates to:
  /// **'Clinic Info'**
  String get clinicInfo;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @selectWeekday.
  ///
  /// In en, this message translates to:
  /// **'Select Weekday'**
  String get selectWeekday;

  /// No description provided for @selectStartTime.
  ///
  /// In en, this message translates to:
  /// **'Pick Starting Time'**
  String get selectStartTime;

  /// No description provided for @selectEndTime.
  ///
  /// In en, this message translates to:
  /// **'Pick Ending Time'**
  String get selectEndTime;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @clinicImage.
  ///
  /// In en, this message translates to:
  /// **'Clinic Image'**
  String get clinicImage;

  /// No description provided for @createService.
  ///
  /// In en, this message translates to:
  /// **'Add New Service'**
  String get createService;

  /// No description provided for @englishDescription.
  ///
  /// In en, this message translates to:
  /// **'English Description'**
  String get englishDescription;

  /// No description provided for @arabicDescription.
  ///
  /// In en, this message translates to:
  /// **'Arabic Description'**
  String get arabicDescription;

  /// No description provided for @serviceInfo.
  ///
  /// In en, this message translates to:
  /// **'Service Info'**
  String get serviceInfo;

  /// No description provided for @serviceFaqs.
  ///
  /// In en, this message translates to:
  /// **'Service Faqs'**
  String get serviceFaqs;

  /// No description provided for @serviceImage.
  ///
  /// In en, this message translates to:
  /// **'Service Image'**
  String get serviceImage;

  /// No description provided for @deleteService.
  ///
  /// In en, this message translates to:
  /// **'Delete Service'**
  String get deleteService;

  /// No description provided for @deleteServiceConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Continue with Deleting This Service? Are You Sure?'**
  String get deleteServiceConfirmation;

  /// No description provided for @addServiceFaq.
  ///
  /// In en, this message translates to:
  /// **'Add Service Faq'**
  String get addServiceFaq;

  /// No description provided for @englishQuestion.
  ///
  /// In en, this message translates to:
  /// **'English Question'**
  String get englishQuestion;

  /// No description provided for @arabicQuestion.
  ///
  /// In en, this message translates to:
  /// **'Arabic Question'**
  String get arabicQuestion;

  /// No description provided for @englishAnswer.
  ///
  /// In en, this message translates to:
  /// **'English Answer'**
  String get englishAnswer;

  /// No description provided for @arabicAnswer.
  ///
  /// In en, this message translates to:
  /// **'Arabic Answer'**
  String get arabicAnswer;

  /// No description provided for @deleteFaq.
  ///
  /// In en, this message translates to:
  /// **'Delete Faq'**
  String get deleteFaq;

  /// No description provided for @deleteFaqConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Continue with Deleting This Faq? Are You Sure?'**
  String get deleteFaqConfirmation;

  /// No description provided for @mainPhone.
  ///
  /// In en, this message translates to:
  /// **'Main Phone'**
  String get mainPhone;

  /// No description provided for @mainWa.
  ///
  /// In en, this message translates to:
  /// **'Main Whatsapp'**
  String get mainWa;

  /// No description provided for @fb.
  ///
  /// In en, this message translates to:
  /// **'Facebook Page Link'**
  String get fb;

  /// No description provided for @ig.
  ///
  /// In en, this message translates to:
  /// **'Instagram Page Link'**
  String get ig;

  /// No description provided for @yt.
  ///
  /// In en, this message translates to:
  /// **'Youtube Channel Link'**
  String get yt;

  /// No description provided for @li.
  ///
  /// In en, this message translates to:
  /// **'LinkedIn Page Link'**
  String get li;

  /// No description provided for @createVideo.
  ///
  /// In en, this message translates to:
  /// **'Add New Video'**
  String get createVideo;

  /// No description provided for @videoSrc.
  ///
  /// In en, this message translates to:
  /// **'Video Link'**
  String get videoSrc;

  /// No description provided for @isLong.
  ///
  /// In en, this message translates to:
  /// **'is Vertical Video'**
  String get isLong;

  /// No description provided for @videoThumbnail.
  ///
  /// In en, this message translates to:
  /// **'Video Thumbnail'**
  String get videoThumbnail;

  /// No description provided for @createCase.
  ///
  /// In en, this message translates to:
  /// **'Add New Case'**
  String get createCase;

  /// No description provided for @preImage.
  ///
  /// In en, this message translates to:
  /// **'Pre Image'**
  String get preImage;

  /// No description provided for @postImage.
  ///
  /// In en, this message translates to:
  /// **'Post Image'**
  String get postImage;

  /// No description provided for @createArticle.
  ///
  /// In en, this message translates to:
  /// **'Add New Article'**
  String get createArticle;

  /// No description provided for @articleThumbnail.
  ///
  /// In en, this message translates to:
  /// **'Article Thumbnail'**
  String get articleThumbnail;

  /// No description provided for @englishBody.
  ///
  /// In en, this message translates to:
  /// **'English Body'**
  String get englishBody;

  /// No description provided for @arabicBody.
  ///
  /// In en, this message translates to:
  /// **'Arabic Body'**
  String get arabicBody;

  /// No description provided for @articleInfo.
  ///
  /// In en, this message translates to:
  /// **'Article Info'**
  String get articleInfo;

  /// No description provided for @articleParagraphs.
  ///
  /// In en, this message translates to:
  /// **'Article Paragraphs'**
  String get articleParagraphs;

  /// No description provided for @deleteArticle.
  ///
  /// In en, this message translates to:
  /// **'Delete Article'**
  String get deleteArticle;

  /// No description provided for @deleteArticleConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Continue with Deleting This Article? Are You Sure?'**
  String get deleteArticleConfirmation;

  /// No description provided for @deleteParagraph.
  ///
  /// In en, this message translates to:
  /// **'Delete Paragraph'**
  String get deleteParagraph;

  /// No description provided for @deleteParagraphConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Continue with Deleting This Paragraph? Are You Sure?'**
  String get deleteParagraphConfirmation;

  /// No description provided for @createParagraph.
  ///
  /// In en, this message translates to:
  /// **'Add New Paragraph'**
  String get createParagraph;

  /// No description provided for @addDoctorAbout.
  ///
  /// In en, this message translates to:
  /// **'Add Doctor About'**
  String get addDoctorAbout;

  /// No description provided for @doctorAbout.
  ///
  /// In en, this message translates to:
  /// **'Doctor About'**
  String get doctorAbout;

  /// No description provided for @deleteAbout.
  ///
  /// In en, this message translates to:
  /// **'Delete Doctor About'**
  String get deleteAbout;

  /// No description provided for @confirmDeleteAbout.
  ///
  /// In en, this message translates to:
  /// **'Continue with Deleting This About? Are You Sure?'**
  String get confirmDeleteAbout;

  /// No description provided for @heroItems.
  ///
  /// In en, this message translates to:
  /// **'Hero Items'**
  String get heroItems;

  /// No description provided for @addHeroItem.
  ///
  /// In en, this message translates to:
  /// **'Add Hero Item'**
  String get addHeroItem;

  /// No description provided for @heroTitle.
  ///
  /// In en, this message translates to:
  /// **'Hero Title'**
  String get heroTitle;

  /// No description provided for @heroSubitle.
  ///
  /// In en, this message translates to:
  /// **'Hero Subtitle'**
  String get heroSubitle;

  /// No description provided for @heroDescription.
  ///
  /// In en, this message translates to:
  /// **'Hero Description'**
  String get heroDescription;

  /// No description provided for @englishHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'English Hero Title'**
  String get englishHeroTitle;

  /// No description provided for @arabicHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Arabic Hero Title'**
  String get arabicHeroTitle;

  /// No description provided for @fontMobile.
  ///
  /// In en, this message translates to:
  /// **'Font Size Mobile'**
  String get fontMobile;

  /// No description provided for @fontOther.
  ///
  /// In en, this message translates to:
  /// **'Font Size Other'**
  String get fontOther;

  /// No description provided for @align.
  ///
  /// In en, this message translates to:
  /// **'Align'**
  String get align;

  /// No description provided for @spacingTopMobile.
  ///
  /// In en, this message translates to:
  /// **'Spacing Top Mobile'**
  String get spacingTopMobile;

  /// No description provided for @spacingStartMobile.
  ///
  /// In en, this message translates to:
  /// **'Spacing Start Mobile'**
  String get spacingStartMobile;

  /// No description provided for @spacingTopOther.
  ///
  /// In en, this message translates to:
  /// **'Spacing Top Other'**
  String get spacingTopOther;

  /// No description provided for @spacingStartOther.
  ///
  /// In en, this message translates to:
  /// **'Spacing Start Other'**
  String get spacingStartOther;

  /// No description provided for @englishHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'English Hero Subtitle'**
  String get englishHeroSubtitle;

  /// No description provided for @arabicHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Arabic Hero Subtitle'**
  String get arabicHeroSubtitle;

  /// No description provided for @englishHeroDescription.
  ///
  /// In en, this message translates to:
  /// **'English Hero Description'**
  String get englishHeroDescription;

  /// No description provided for @arabicHeroDescription.
  ///
  /// In en, this message translates to:
  /// **'Arabic Hero Description'**
  String get arabicHeroDescription;

  /// No description provided for @heroImageMobile.
  ///
  /// In en, this message translates to:
  /// **'Hero Image Mobile'**
  String get heroImageMobile;

  /// No description provided for @heroImageOther.
  ///
  /// In en, this message translates to:
  /// **'Hero Image Other'**
  String get heroImageOther;

  /// No description provided for @deleteHeroItem.
  ///
  /// In en, this message translates to:
  /// **'Delete Hero Item ?'**
  String get deleteHeroItem;

  /// No description provided for @confirmDeleteHeroItem.
  ///
  /// In en, this message translates to:
  /// **'Are You Sure You Would Delete This Hero Item ? This Action is Irreversible.'**
  String get confirmDeleteHeroItem;

  /// No description provided for @websiteTitleFontColor.
  ///
  /// In en, this message translates to:
  /// **'Website Title Font Color'**
  String get websiteTitleFontColor;

  /// No description provided for @websiteTitleFontShadowColor.
  ///
  /// In en, this message translates to:
  /// **'Website Title Font Shadow Color'**
  String get websiteTitleFontShadowColor;

  /// No description provided for @websiteTitleFontSizeMobile.
  ///
  /// In en, this message translates to:
  /// **'Website Title Font Size Mobile'**
  String get websiteTitleFontSizeMobile;

  /// No description provided for @websiteTitleFontSizeOther.
  ///
  /// In en, this message translates to:
  /// **'Website Title Font Size Other'**
  String get websiteTitleFontSizeOther;

  /// No description provided for @titlesFontColor.
  ///
  /// In en, this message translates to:
  /// **'Titles Font Color'**
  String get titlesFontColor;

  /// No description provided for @titlesFontShadowColor.
  ///
  /// In en, this message translates to:
  /// **'Titles Font Shadow Color'**
  String get titlesFontShadowColor;

  /// No description provided for @titlesFontSizeMobile.
  ///
  /// In en, this message translates to:
  /// **'Titles Font Size Mobile'**
  String get titlesFontSizeMobile;

  /// No description provided for @titlesFontSizeOther.
  ///
  /// In en, this message translates to:
  /// **'Titles Font Size Other'**
  String get titlesFontSizeOther;

  /// No description provided for @subtitlesFontColor.
  ///
  /// In en, this message translates to:
  /// **'Subtitles Font Color'**
  String get subtitlesFontColor;

  /// No description provided for @subtitlesFontShadowColor.
  ///
  /// In en, this message translates to:
  /// **'Subtitles Font Shadow Color'**
  String get subtitlesFontShadowColor;

  /// No description provided for @subtitlesFontSizeMobile.
  ///
  /// In en, this message translates to:
  /// **'Subtitles Font Size Mobile'**
  String get subtitlesFontSizeMobile;

  /// No description provided for @subtitlesFontSizeOther.
  ///
  /// In en, this message translates to:
  /// **'Subtitles Font Size Other'**
  String get subtitlesFontSizeOther;

  /// No description provided for @textFontColor.
  ///
  /// In en, this message translates to:
  /// **'Text Font Color'**
  String get textFontColor;

  /// No description provided for @textFontShadowColor.
  ///
  /// In en, this message translates to:
  /// **'Text Font Shadow Color'**
  String get textFontShadowColor;

  /// No description provided for @textFontSizeMobile.
  ///
  /// In en, this message translates to:
  /// **'Text Font Size Mobile'**
  String get textFontSizeMobile;

  /// No description provided for @textFontSizeOther.
  ///
  /// In en, this message translates to:
  /// **'Text Font Size Other'**
  String get textFontSizeOther;

  /// No description provided for @buttonColor.
  ///
  /// In en, this message translates to:
  /// **'Button Color'**
  String get buttonColor;

  /// No description provided for @buttonFontColor.
  ///
  /// In en, this message translates to:
  /// **'Button Font Color'**
  String get buttonFontColor;

  /// No description provided for @websiteMainTitle.
  ///
  /// In en, this message translates to:
  /// **'Website Main Title'**
  String get websiteMainTitle;

  /// No description provided for @websiteTitles.
  ///
  /// In en, this message translates to:
  /// **'Website Titles'**
  String get websiteTitles;

  /// No description provided for @websiteSubtitles.
  ///
  /// In en, this message translates to:
  /// **'Website Subtitles'**
  String get websiteSubtitles;

  /// No description provided for @websiteText.
  ///
  /// In en, this message translates to:
  /// **'Website Text'**
  String get websiteText;

  /// No description provided for @websiteBackground.
  ///
  /// In en, this message translates to:
  /// **'Website Background'**
  String get websiteBackground;

  /// No description provided for @websiteButtons.
  ///
  /// In en, this message translates to:
  /// **'Website Buttons'**
  String get websiteButtons;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @noBookingsForDate.
  ///
  /// In en, this message translates to:
  /// **'No Bookings Found For Selected Date.'**
  String get noBookingsForDate;
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
      'that was used.');
}
