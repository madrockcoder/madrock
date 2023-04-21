import 'package:flutter/cupertino.dart';
import 'package:geniuspay/models/compliance.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/models/tax_country.dart';
import 'package:geniuspay/repos/auth.dart';
import 'package:geniuspay/repos/compliance_repo.dart';
import 'package:geniuspay/util/enum_converter.dart';
import 'package:geniuspay/util/enums.dart';

class ComplianceProvider with ChangeNotifier, EnumConverter {
  ComplianceProvider({
    required this.complianceBase,
    required this.auth,
    required this.availableCountries,
    this.occupation,
    this.expectedFunds,
    this.isUSPerson = false,
    this.isPEPPerson = false,
    this.tinCode = '',
    this.pepType,
    this.employeeStatus,
    this.noTINReason,
    this.nationalIdNumber = '',
    this.taxPageCountry,
    this.taxCountry,
    this.otCountry,
  }) {
    clearCountriesList();
    _countries.addAll(availableCountries);
  }

  final ComplianceBase complianceBase;
  final AuthBase auth;
  final List<Country> availableCountries;
  Occupation? occupation;
  ExpectedFunds? expectedFunds;
  bool isUSPerson;
  bool isPEPPerson;
  String tinCode;
  PEPType? pepType;
  EmployeeStatus? employeeStatus;
  NoTINReason? noTINReason;
  String nationalIdNumber;
  Country? taxPageCountry;
  TaxCountry? taxCountry;
  Country? otCountry;

  var isLoading = false;
  var isSourceFundPicked = false;

  final _countries = <Country>[];
  List<Country> get countries => _countries;

  final _taxCountries = <TaxCountry>[];
  List<TaxCountry> get taxCountries => _taxCountries;

  final _otCountries = <Country>[];
  List<Country> get otCountries => _otCountries;

  // final _sourcesOfFunds = <SourceOfFunds>[...sourcesOfFunds];

  // List<SourceOfFunds> get sourcesOfFunds => _sourcesOfFunds;

  void sourceFundsPicked() {
    try {
      final s = sourcesOfFunds.firstWhere((e) => e.isSourceOfFund);
      if (s.isSourceOfFund) {
        isSourceFundPicked = true;
        notifyListeners();
      } else {
        isSourceFundPicked = false;
        notifyListeners();
      }
    } catch (e) {
      isSourceFundPicked = false;
      notifyListeners();
    }
  }

  /// Get Countries from ISO2
  Country getCountryFromIso2(String iso2) =>
      availableCountries.firstWhere((country) => country.iso2 == iso2);

  /// Get Countries
  Future<void> getCountries(String searchTerm) async {
    try {
      clearCountriesList();
      isLoading = true;
      notifyListeners();
      final foundCountries = await complianceBase.fetchCountries(searchTerm);
      clearCountriesList();
      _countries.addAll(foundCountries);
      notifyListeners();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> setComplianceAssessment() async {
    final foundSofs = sourcesOfFunds.where((e) => e.isSourceOfFund).toList();
    final sof = <String>[];
    for (var foundSof in foundSofs) {
      sof.add(foundSof.requestText);
    }

    final ot = <String>[];
    for (var otCountry in otCountries) {
      ot.add(otCountry.iso2.toUpperCase());
    }
    try {
      final compliance = Compliance(
        uid: auth.user!.id,
        sourceOfFunds: sof,
        isPep: isPEPPerson,
        pepType: getPEPTypeRequestText(pepType),
        fatca: isUSPerson,
        occupation: getOccupationText(occupation),
        employmentStatus: getEmployeeStatusRequestText(employeeStatus),
        avgTransactionSize: getExpectedFundsRequestText(expectedFunds),
        overseasTransactions: ot,
      );

      await complianceBase.setComplianceAssessment(compliance);
      await auth.getUser();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setTin() async {
    // try {
    //   final tin = TIN(
    //     userID: auth.user!.id,
    //     // pesel: tinCode,
    //     country: auth.user!.userProfile.countryIso2,
    //     // idNumber: getNoTINReasonRequestText(noTINReason)!,
    //   );
    //   await complianceBase.setTin(tin);
    //   await auth.getUser();
    // } catch (e) {
    //   rethrow;
    // }
  }

  void createTaxCountry() {
    final taxCountry = TaxCountry(
      country: taxPageCountry!,
      nationalID: nationalIdNumber,
      tin: tinCode,
      userID: auth.user!.id,
      reasonNoTin: getNoTINReasonRequestText(noTINReason),
    );

    addTaxCountry(taxCountry);
  }

  // Future<void> setTaxResidence() async {
  //   try {
  //     isLoading = true;
  //     final futures = <Future<void>>[];
  //     for (var tx in _taxCountries) {
  //       futures.add(auth.setTaxResidence(tx));
  //     }
  //     await Future.wait(futures);

  //     isLoading = false;
  //     notifyListeners();
  //   } catch (e) {
  //     isLoading = false;
  //     notifyListeners();
  //     rethrow;
  //   }
  // }

  void addTaxCountry(TaxCountry taxCountry) {
    updateWith(taxCountry: taxCountry);
    if (_taxCountries.contains(taxCountry)) return;
    _taxCountries.add(taxCountry);
    notifyListeners();
  }

  void removeTaxCountry(TaxCountry tax) {
    _taxCountries.remove(tax);
    notifyListeners();
  }

  void addOTCountry(Country otCountry) {
    updateWith(otCountry: otCountry);
    if (_otCountries.contains(otCountry)) return;
    _otCountries.add(otCountry);
    notifyListeners();
  }

  void removeOTCountry(Country otCountry) {
    _otCountries.remove(otCountry);
    notifyListeners();
  }

  void clearCountriesList() => _countries.clear();

  void updateWith({
    TaxCountry? taxCountry,
    Country? otCountry,
    Country? taxPageCountry,
    String? tinCode,
    ExpectedFunds? expectedFunds,
    bool? isUSPerson,
    bool? isPEPPerson,
    EmployeeStatus? employeeStatus,
    NoTINReason? noTINReason,
    String? nationalIdNumber,
    PEPType? pepType,
    Occupation? occupation,
  }) {
    this.tinCode = tinCode ?? this.tinCode;
    this.isUSPerson = isUSPerson ?? this.isUSPerson;
    this.isPEPPerson = isPEPPerson ?? this.isPEPPerson;
    this.nationalIdNumber = nationalIdNumber ?? this.nationalIdNumber;
    this.expectedFunds = expectedFunds ?? this.expectedFunds;
    this.employeeStatus = employeeStatus ?? this.employeeStatus;
    this.pepType = pepType ?? this.pepType;
    this.noTINReason = noTINReason ?? this.noTINReason;
    this.occupation = occupation ?? this.occupation;
    this.taxPageCountry = taxPageCountry ?? this.taxPageCountry;
    this.otCountry = otCountry ?? this.otCountry;
    this.taxCountry = taxCountry ?? this.taxCountry;
  }
}
