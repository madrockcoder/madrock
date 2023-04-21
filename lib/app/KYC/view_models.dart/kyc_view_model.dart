import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geniuspay/app/KYC/model/account_item_model.dart';
import 'package:geniuspay/app/KYC/pages/kyc_id_verification/processing_application_page.dart';
import 'package:geniuspay/app/KYC/pages/kyc_risk_assesment/kyc_risk_starting_page.dart';
import 'package:geniuspay/app/KYC/pages/residential_address/add_address_page.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/validators.dart';
import 'package:geniuspay/app/auth/view_models/select_country_view_model.dart';
import 'package:geniuspay/app/shared_widgets/popup_dialogs.dart';
import 'package:geniuspay/core/errors/errors.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/kyc.dart';
import 'package:geniuspay/models/kyc_risk_model.dart';
import 'package:geniuspay/models/tin.dart';
import 'package:geniuspay/models/user.dart';
import 'package:geniuspay/models/verification_status_response.dart';
import 'package:geniuspay/repos/local_repo.dart';
import 'package:geniuspay/services/auth_services.dart';
import 'package:geniuspay/services/kyc_service.dart';
import 'package:geniuspay/util/enum_converter.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:injectable/injectable.dart';
import 'package:veriff_flutter/veriff_flutter.dart';

@lazySingleton
class KycViewModel extends BaseModel with EnumConverter, SignInValidators {
  final SelectCountryViewModel _selectCountryViewModel =
      sl<SelectCountryViewModel>();
  final AuthenticationService _authenticationService =
      sl<AuthenticationService>();
  final Kycservice _kycservice = sl<Kycservice>();
  final LocalBase _localBase = sl<LocalBase>();

  User? get user => _authenticationService.user;

  DocumentType? _option;
  DocumentType? get option => _option;
  set setOption(DocumentType value) {
    _option = value;
    notifyListeners();
  }

  User? _currentUser;
  User? get currentUser => _currentUser;

  Country? _country;
  Country? get country => _country;
  set setCountry(Country value) {
    _country = value;
    _option = null;
    notifyListeners();
  }

  // tax management sections
  String _peselNumber = '';
  String get peselNumber => _peselNumber;
  set peselNumber(String value) {
    _peselNumber = value;
    notifyListeners();
  }

  String _idNumber = '';
  String get idNumber => _idNumber;
  set idNumber(String value) {
    _idNumber = value;
    notifyListeners();
  }

  Country? _taxCountry;
  Country? get taxCountry => _taxCountry;
  set setTaxCountry(Country value) {
    _taxCountry = value;
    notifyListeners();
  }

  bool? _isUs;
  bool? get isUs => _isUs;
  set setIsUs(bool value) {
    _isUs = value;
    notifyListeners();
  }

  // risk assesment
  bool? _isPep;
  bool? get isPep => _isPep;
  set setIsPep(bool value) {
    _isPep = value;
    notifyListeners();
  }

  PepStatus? _pepStatus;
  PepStatus? get pepStatus => _pepStatus;
  set setPepStatus(PepStatus value) {
    _pepStatus = value;
    notifyListeners();
  }

  String? _employeeStatus;

  /// employeeStatus
  String? get employeeStatus => _employeeStatus;
  set employeeStatus(String? value) {
    _employeeStatus = value;
    notifyListeners();
  }

  String? _occupation;

  /// occupation
  String? get occupation => _occupation;
  set occupation(String? value) {
    _occupation = value;
    notifyListeners();
  }

  String? _expectedFunds;

  /// expectedFunds
  String? get expectedFunds => _expectedFunds;
  set expectedFunds(String? value) {
    _expectedFunds = value;
    notifyListeners();
  }

  List<int> _accountPurpose = <int>[];

  /// accountPurpose
  List<int> get accountPurpose => _accountPurpose;
  set accountPurpose(List<int> value) {
    _accountPurpose = value;
    notifyListeners();
  }

  List<int> _sourceOfFunds = <int>[];

  /// sourceOfFunds
  List<int> get sourceOfFunds => _sourceOfFunds;
  set sourceOfFunds(List<int> value) {
    _sourceOfFunds = value;
    notifyListeners();
  }

  List<Country> _overseaCountries = <Country>[];

  /// overseaCountries
  List<Country> get overseaCountries => _overseaCountries;
  set overseaCountries(List<Country> value) {
    _overseaCountries = value;
    notifyListeners();
  }

//methods for API calls
  void init(BuildContext context) async {
    if (_authenticationService.user?.userProfile.citizenshipIso2 == null ||
        _authenticationService.user!.userProfile.citizenshipIso2!.isEmpty) {
      final result = _localBase.getdeviceCountry();
      if (result != null) {
        _country = result;
        notifyListeners();
      }
    } else {
      final result = await _selectCountryViewModel.getCountryFromIso(
          context, _authenticationService.user!.userProfile.citizenshipIso2!);
      _country = result;
      notifyListeners();
    }
    setBusy(value: false);
  }

  Future<void> getUser(BuildContext context) async {
    final result = await _authenticationService.getUser();
    result.fold((l) async {}, (r) {
      _currentUser = r;
    });
  }

  Future<void> initiateKyc(BuildContext context, bool overrideSession) async {
    setBusy(value: true);
    final kyc = KYC(
      uid: _authenticationService.user!.id,
      documentIssuingCountry: country!.iso2,
      documentType: option!,
    );
    final url = _localBase.getVeriffUrl();
    if (url == null) {
      final result = await _kycservice.initialiseKYC(kyc);
      result.fold((l) async {
        PopupDialogs(context).errorMessage(
          FailureToMessage.mapFailureToMessage(l),
        );
        setBusy(value: false);
      }, (r) async {
        _localBase.setVeriffUrl(r);
        _veriff(r, context);
        await _authenticationService.getUser();
        setBusy(value: false);
      });
    } else {
      _veriff(url, context);
      await _authenticationService.getUser();
      setBusy(value: false);
    }
  }

  Future<void> taxAssessment(BuildContext context, String? taxNum) async {
    setBusy(value: true);

    final tin = taxNum == null
        ? TIN(
            userID: _authenticationService.user!.id,
            taxNo: '',
            reasonNoTIN: 'NOT_ASSIGNED_YET')
        : TIN(userID: _authenticationService.user!.id, taxNo: taxNum);
    final result = await _kycservice.kycTaxAssesment(tin);
    result.fold((l) async {
      PopupDialogs(context).errorMessage(
        'Unable to enter tax verification details. Please try again',
      );
      setBusy(value: false);
    }, (r) {
      KYCRiskStartingPage.show(context);
      setBusy(value: false);
    });
  }

  Future<void> getVerificationStatus() async {
    final result = await _kycservice
        .getKycVerificationStatus(_authenticationService.user!.id);
    result.fold((l) {}, (r) {
      verificationStatusResponse = r;
      notifyListeners();
    });
  }

  VerificationStatusResponse? verificationStatusResponse;
  Future<void> riskAssessment(BuildContext context) async {
    setBusy(value: true);
    final sourceOfFunds = <String>[];
    final overseasTransaction = <String>[];
    final accountPurpose = <String>[];
    for (var element in _sourceOfFunds) {
      sourceOfFunds.add(AccountItemList.sourceOfFunds[element].requestText);
    }
    for (var element in _accountPurpose) {
      accountPurpose
          .add(AccountItemList.accountPurposeList[element].requestText);
    }
    for (var element in _overseaCountries) {
      overseasTransaction.add(element.iso2);
    }

    final riskKyc = KycRiskAssessment(
      avgTransactionSize: _expectedFunds ?? '',
      employmentStatus: _employeeStatus ?? '',
      fatcaRelevant: _isUs ?? false,
      occupation: _occupation ?? '',
      overseasTransaction: overseasTransaction,
      pep: _isPep!,
      pepType: getPEPStatusRequestText(_pepStatus),
      sourceofFunds: sourceOfFunds,
      uid: user!.id,
      usCitizenTaxResident: _isUs ?? false,
      accountPurpose: accountPurpose,
    );

    final result = await _kycservice.kycRisk(riskKyc);
    result.fold((l) async {
      PopupDialogs(context).errorMessage(
        FailureToMessage.mapFailureToMessage(l),
      );
      setBusy(value: false);
    }, (r) {
      AddAddressPage.show(context);
      setBusy(value: false);
    });
  }

  Future<void> _veriff(String url, BuildContext context) async {
    var veriff = Veriff();
    const logo = AssetImage('assets/images/logo.png');
    Branding branding = Branding(
      background: "#017189",
      //statusBarColor: "#ffffff",
      onBackgroundSecondary: "#001B21",
      // secondaryTextColor: "#3a593d",
      buttonRadius: 16,
      logo: logo,
      //androidNotificationIcon: "ic_notification",
      onPrimary: "#017189",
    );

    Configuration config = Configuration(url, branding: branding);
    try {
      Result result = await veriff.start(config);
      switch (result.status) {
        case Status.done:
          // PopupDialogs(context).successMessage(
          //   'You have successfully been verified',
          // );
          // await context.read<AuthProvider>().getUserId();
          // PersonalDetailsPage.show(context);
          ProcessingApplicationPage.show(context);
          break;
        case Status.canceled:
          PopupDialogs(context).errorMessage(
            'Complete this step to unlock all the charm of GenioXperience.',
          );
          break;
        case Status.error:
          switch (result.error) {
            case Error.cameraUnavailable:
              PopupDialogs(context).errorMessage(
                'Unable to continue KYC registration. Registration requires device camera.',
              );
              break;
            case Error.microphoneUnavailable:
              PopupDialogs(context).errorMessage(
                'Unable to continue KYC registration. Registration requires device microphone.',
              );
              break;
            case Error.networkError:
              PopupDialogs(context).errorMessage(
                'This error typically occurs when there\'s an issue with the network. Please try again later.',
              );
              break;
            case Error.sessionError:
              PopupDialogs(context).errorMessage(
                'A local error happened before submitting the session.',
              );
              break;
            case Error.deprecatedSDKVersion:
              break;
            case Error.unknown:
              PopupDialogs(context).errorMessage(
                'An unknown error has occurred. Please contact support to fix this.',
              );
              break;
            case Error.nfcError:
              PopupDialogs(context).errorMessage(
                'An NFC error has occurred. Please contact support to fix this.',
              );
              break;
            case Error.setupError:
              PopupDialogs(context).errorMessage(
                'An error occurred while setting up process. Please contact support to fix this.',
              );
              break;
            case Error.none:
              break;
            default:
              break;
          }
          break;
        default:
          break;
      }
    } on PlatformException {
      // handle exception
      PopupDialogs(context).errorMessage(
        'A platform error has occurred. Please contact support to fix this.',
      );
    }
  }

  bool manualDetailsEntered = false;
  Future<void> enterManualDetails(BuildContext context, String firstName,
      String lastName, String DOB) async {
    final result = await _kycservice.enterManualDetails(
        _authenticationService.user!.id, firstName, lastName, DOB);
    result.fold((l) {
      manualDetailsEntered = false;
      notifyListeners();
      PopupDialogs(context).errorMessage(
          'Unable to add details manually, Please try again later');
    }, (r) {
      manualDetailsEntered = true;
      notifyListeners();
      PopupDialogs(context).successMessage('Your details have been added');
    });
  }
}
