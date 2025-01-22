import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get proklinik => 'بروكلينيك';

  @override
  String get moiErSystem => 'نظام ادارة الاستقبال و الطوارئ';

  @override
  String get moiErSystemRehab => 'نظام ادارة الاستقبال و الطوارئ - المجمع الطبى بالرحاب';

  @override
  String get email => 'البريد الالكتروني';

  @override
  String get enterValidEmail => 'برجاء ادخال بريد الكتروني صحيح.';

  @override
  String get password => 'كلمة السر';

  @override
  String get kindlyEnterPassword => 'برجاء ادخال كلمة السر';

  @override
  String get rememberMe => 'تذكرني';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get forgotPassword => 'نسيان كلمة السر';

  @override
  String get linkSentToEmail => 'تم ارسال رابط تعديل كلمة السر علي البريد الالكتروني';

  @override
  String get notRegisteredYet => 'ليس لديك حساب ؟  ';

  @override
  String get createAccount => 'انشاء حساب.';

  @override
  String get logoutPromptTitle => 'تسجيل الخروج ؟';

  @override
  String get logoutPromptMessage => 'هل تود الاستمرار بتسجيل الخروج ؟';

  @override
  String get success => 'تم بنجاح...';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get confirm => 'تأكيد';

  @override
  String get language => 'اللغة';

  @override
  String get save => 'حفظ';

  @override
  String get edit => 'تعديل';

  @override
  String get cancel => 'الغاء';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get todayVisits => 'زيارات اليوم';

  @override
  String get patients => 'سجل المرضي';

  @override
  String get baseValidator => 'لا يمكن قبول ادخال فارغ';

  @override
  String get phoneValidator => 'ادخل رقم موبايل مكون من احد عشر رقم';

  @override
  String get nationalIdValidator => 'ادخل الرقم القومي مكون من اربعة عشر رقم';

  @override
  String get addNewPatient => 'اضافة مريض جديد';

  @override
  String get updatePatientData => 'تعديل بيانات مريض';

  @override
  String get patientName => 'اسم المريض';

  @override
  String get patientRank => 'الرتبة';

  @override
  String get patientWork => 'جهة العمل';

  @override
  String get patientNationalId => 'الرقم القومي';

  @override
  String get patientPhone => 'رقم الموبايل';

  @override
  String get phoneNotAvailable => 'تعذر الحصول علي رقم المريض';

  @override
  String get noPatientsFound => 'لم يتم العثور علي مرضي بمعاملات البحث المطلوبة';

  @override
  String get searchTitle => 'بحث بالاسم او الرقم القومي';

  @override
  String get search => 'بحث';

  @override
  String get clearSearch => 'اخلاء البحث';

  @override
  String get addNewVisit => 'اضافة زيارة جديدة';

  @override
  String get arrivalType => 'طريقة الوصول';

  @override
  String get noVisitsForToday => 'لم يتم تسجيل زيارات بتاريخ اليوم بعد.';

  @override
  String get vitalSigns => 'العلامات الحيوية';

  @override
  String get addVitalSigns => 'اضافة العلامات الحيوية';

  @override
  String get bp => 'الضغط';

  @override
  String get pulse => 'النبض';

  @override
  String get rr => 'التنفس';

  @override
  String get temp => 'الحرارة';

  @override
  String get rbs => 'السكر';

  @override
  String get oxygen => 'الاكسجين';

  @override
  String get time => 'الوقت';

  @override
  String get systole => 'السيستولي';

  @override
  String get diastole => 'الدياستولي';

  @override
  String get arrivalTime => 'وقت الوصول';

  @override
  String get dischargeTime => 'وقت الخروج';

  @override
  String get admissionTime => 'وقت الحجز';

  @override
  String get recordingTime => 'وقت التسجيل الالكتروني';

  @override
  String get dispositionStatus => 'القرار الطبي';

  @override
  String get ambulanceDetails => 'بيانات الاسعاف';

  @override
  String get driverName => 'اسم السائق';

  @override
  String get paramedicName => 'اسم المسعف';

  @override
  String get carCode => 'كود السيارة';

  @override
  String get admissionDetails => 'بيانات الحجز';

  @override
  String get printAdmissionSheet => 'طباعة وثيقة دخول';

  @override
  String get printERSheet => 'طباعة ملف طوارئ';

  @override
  String get printReport => 'طباعة تقرير';

  @override
  String get relativeDetails => 'بيانات المندوب';

  @override
  String get relativeName => 'اسم المندوب';

  @override
  String get relativeType => 'نوع المندوب (اسرة / عسكري)';

  @override
  String get relativeRank => 'رتبة المندوب';

  @override
  String get relativePhone => 'رقم تليفون المندوب';

  @override
  String get relativeFamilyRelation => 'صلة قرابة المندوب';

  @override
  String get relativeNationalId => 'رقم بطاقة المندوب';

  @override
  String get emergencyConsultation => 'عرض الطوارئ';

  @override
  String get emergencyDoctor => 'اخصائي الطوارئ';

  @override
  String get selectEmergencyDoctor => 'اختر اخصائي الطوارئ';

  @override
  String get erConsultationResponse => 'رد عرض الطوارئ';

  @override
  String get labs => 'المعامل';

  @override
  String get rads => 'الاشاعات';

  @override
  String get procedures => 'الاجرائات الطبية';

  @override
  String get drugs => 'الادوية';

  @override
  String get erDrugs => 'ادوية دولاب الطوارئ';

  @override
  String get administeredDrugs => 'ادوية الزيارة';

  @override
  String get specConsultations => 'عروض التخصصات';

  @override
  String get addSpecConsultations => 'اضافة عرض';

  @override
  String get selectSpecDoctor => 'اختر اخصائي العرض';

  @override
  String get selectSpecDoctorFirst => 'اختر الطبيب و التخصص اولا.';

  @override
  String get specConsultationResponse => 'رد عرض التخصص';

  @override
  String get admissionType => 'نوع الحجز';

  @override
  String get admissionCondition => 'الحالة عند الحجز';

  @override
  String get wardDetails => 'بيانات الداخلي';

  @override
  String get wardRoom => 'رقم الغرفة الداخلي';

  @override
  String get wardfloor => 'رقم / اسم الدور الداخلي';

  @override
  String get icuDetails => 'بيانات الرعاية';

  @override
  String get icuName => 'اسم / رقم الرعاية';

  @override
  String get icuBed => 'رقم سرير الرعاية';

  @override
  String get primaryDoctor => 'الاشراف الاولي / الاساسي';

  @override
  String get selectPrimaryDoctor => 'اختر طبيب الاشراف الاولي';

  @override
  String get secondaryDoctor => 'الاشراف الثانوي / المشترك';

  @override
  String get selectSecondaryDoctor => 'اختر طبيب الاشراف الثانوي';

  @override
  String get tertiaryDoctors => 'اطباء الاشراف الفرعي';

  @override
  String get transferNurse => 'تمريض مسلم الحالة';

  @override
  String get admissionNurse => 'تمريض مستلم الحالة';

  @override
  String get selectTransferNurse => 'اختر تمريض مسلم الحالة';

  @override
  String get selectAdmissionNurse => 'اختر تمريض مستلم الحالة';

  @override
  String get erSupervisorDoctor => 'مشرف الاستقبال';

  @override
  String get greaterOfficerDoctor => 'ضابط عظيم';

  @override
  String get selectErSupervisorDoctor => 'اختر مشرف الاستقبال';

  @override
  String get selectGreaterOfficerDoctor => 'اختر ضابط عظيم';

  @override
  String get confirmDeleteAdmissionTitle => 'الغاء الحجز ؟';

  @override
  String get confirmDeleteAdmissionMessage => 'هل تود الاستمرار بالغاء بيانات الحجز ؟';

  @override
  String get deleteErVisit => 'الغاء الزيارة';

  @override
  String get confirmDeleteVisitTitle => 'الغاء الزيارة ؟';

  @override
  String get confirmDeleteVisitMessage => 'هل تود الاستمرار بالغاء هذه الزيارة ؟';

  @override
  String get printERAdmissionSheet => 'طباعة وثيقة دخول طوارئ';

  @override
  String get past_Medical_History => 'التاريخ المرضي السابق';

  @override
  String get allergies => 'حساسية من ادوية';

  @override
  String get surgries => 'العمليات السابقة';

  @override
  String get medicalDiseases => 'الامراض المزمنة';

  @override
  String get noVisitsFound => 'لم يتم العثور علي زيارات';

  @override
  String get previousErVisits => 'زيارات الطوارئ السابقة';
}
