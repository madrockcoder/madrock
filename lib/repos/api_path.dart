import 'package:geniuspay/services/remote_config_service.dart';

class APIPath {
  // static const _baseUrl = 'https://sandbox.geniuspay.com/api/v1.0';
  static final _baseUrl =
      "${RemoteConfigService.getRemoteData.appUrl}/${RemoteConfigService.getRemoteData.apiVersion}";

  /// [AUTH API PATH]
  static String get emailSignUp => '$_baseUrl/accounts/register/';

  static String verifyUserPin(String accountId) =>
      "$_baseUrl/accounts/$accountId/verify-pin";

  static String lockUserAcc(String accountId) =>
      "$_baseUrl/accounts/$accountId/lock-out";

  static String get joinBeta => '$_baseUrl/utils/join-beta';

  static String get updateUserCountry =>
      "$_baseUrl/onboarding/country-of-residence";

  static String get emailOTPSignIn => '$_baseUrl/auth/otp/email';
  static String unlockAccount(String uid) => '$_baseUrl/accounts/$uid/unlock';

  static String checkEmailExists(String email) =>
      '$_baseUrl/utils/check-email/$email';
  static String checkAuthToken(String token) =>
      '$_baseUrl/utils/check-auth-token/$token/status';

  static String get verifyOTP => '$_baseUrl/auth/otp/token';

  static String get emailLogin => '$_baseUrl/accounts/login/';

  static String get logout => '$_baseUrl/auth/otp/logout';

  static String closeAccount(String uid) => '$_baseUrl/accounts/$uid/close';

  static String closeAccountCheck(String uid) =>
      '$_baseUrl/accounts/$uid/close-check';

  static String get postMobileNumber => '$_baseUrl/mobile-numbers';

  static String checkMobileNumberExists(String mobileNumber) =>
      '$_baseUrl/utils/check-mobile-number/$mobileNumber';

  static String changeMobileNumber(String id) => '$_baseUrl/mobile-numbers/$id';

  static String confirmMobileNumber(String numberId) =>
      '$_baseUrl/mobile-numbers/$numberId/confirm';

  static String getMobileNumber(String numberId) =>
      '$_baseUrl/mobile-numbers/$numberId';

  static String authorizeMobileNumber(String accountId) =>
      '$_baseUrl/mobile-numbers/$accountId/authorize';

  static String get getUser => '$_baseUrl/accounts/me';

  static String setAvatar(String uid) => '$_baseUrl/accounts/$uid/avatar';

  static String get setPIN => '$_baseUrl/passcodes';

  static String updatePIN(String uid) => '$_baseUrl/accounts/$uid/update-pin';

  static String updateProfile(String uid) =>
      '$_baseUrl/accounts/$uid/update-profile';

  static String searchCountries(String searchTerm) =>
      '$_baseUrl/references/registration-permitted?filter[search]=$searchTerm';

  static String searchCountryIso(String iso) =>
      '$_baseUrl/references/countries?iso2=$iso';

  static String fetchCountries(String pageNumber) =>
      '$_baseUrl/references/registration-permitted?page_length=$pageNumber';

  static String get fetchAllCountries => '$_baseUrl/references/countries';

  static String get addWaitlistUser => '$_baseUrl/waitlists';

  static String searchAllCountries(String searchTerm) =>
      '$_baseUrl/references/countries?filter[search]=$searchTerm';

  static String permittedCountry(String countryISO) =>
      '$_baseUrl/references/$countryISO/registration-permitted';

  static String get setUserDeviceInfo => '$_baseUrl/devices';

  static String get uploadAddressProof =>
      '$_baseUrl/address-verification/document';
  static String getPointsList(String accountId) =>
      '$_baseUrl/accounts/$accountId/points-stats';

  static String uploadAvatar(String accountId) =>
      '$_baseUrl/accounts/$accountId/avatar';

  /// [KYC API PATH]

  static String get initialiseKYC => '$_baseUrl/kyc/veriff-sessions';

  static String getVeriffSession(String sessionId) =>
      '$_baseUrl/kyc/veriff-sessions/$sessionId';

  static String getKycVerificationStatus(String uid) {
    return '$_baseUrl/kyc/id-verification/$uid/status';
  }

  static String get kycRisk => '$_baseUrl/kyc/profile-assessment';

  static String get kycAddressVerification =>
      '$_baseUrl/kyc/address-verification';

  static String get kycEnterManualDetails =>
      '$_baseUrl/kyc/identity-verifications/personal-data/manual-details';

  static String createAddress(String accountId) =>
      '$_baseUrl/accounts/$accountId/addresses';

  static String get taxResidence => '$_baseUrl/tax-residences';
  static String choosePlan(String accountId) =>
      '$_baseUrl/kyc/onboarding/$accountId/profile';

  static String getSupportPIN(String accountId) =>
      '$_baseUrl/accounts/$accountId/support-pin/find';

  /// [HOMEPAGE API PATH]
  /// [TRANSACTIONS API PATH]
  static String fetchTransactions(String uid, String? pages, String? walletId) {
    if (pages != null) {
      if (walletId != null) {
        return '$_baseUrl/accounts/$uid/transactions?page_length=$pages&authoring_wallet=$walletId';
      } else {
        return '$_baseUrl/accounts/$uid/transactions?page_length=$pages';
      }
    } else {
      if (walletId != null) {
        return '$_baseUrl/accounts/$uid/transactions?authoring_wallet=$walletId';
      } else {
        return '$_baseUrl/accounts/$uid/transactions';
      }
    }
  }

  static String getTransactionByID(String uid, String transactionID) =>
      '$_baseUrl/accounts/$uid/transactions/$transactionID';

  /// [WALLETS API PATH]
  static String fetchCurrencies(String pageNumber) =>
      '$_baseUrl/references/trading-currencies?page_length=$pageNumber&wallet_enabled=true';

  static String searchCurrencies(String searchTerm) =>
      '$_baseUrl/references/trading-currencies?filter[search]=$searchTerm&wallet_enabled=true';

  static String get createWallet => '$_baseUrl/wallets';

  static String changeWalletStatus(String uid, String walletId) =>
      '$_baseUrl/accounts/$uid/wallets/$walletId/change-status';

  static String userWallets(String uid, String searchTerm) =>
      '$_baseUrl/accounts/$uid/wallets?filter[search]=$searchTerm';

  static String getIndividualWallet(String uid, String walletId) =>
      '$_baseUrl/accounts/$uid/wallets/$walletId';

  static String walletAccountDetails(String uid, String walletId) =>
      '$_baseUrl/accounts/$uid/wallets/$walletId/account-details';

  static String updateWalletFriendlyName(String uid, String walletId) =>
      '$_baseUrl/accounts/$uid/wallets/$walletId/friendly-name';

  static String defaultWallet(String uid, String walletId) =>
      '$_baseUrl/accounts/$uid/wallets/$walletId/default';

  static String closeWallet(String uid, String walletId) =>
      '$_baseUrl/accounts/$uid/wallets/$walletId/close';

  static String walletTransactions(String uid, String walletId, String? pages) {
    if (pages != null) {
      return '$_baseUrl/accounts/$uid/wallets/$walletId/transactions?page_length=$pages';
    } else {
      return '$_baseUrl/accounts/$uid/wallets/$walletId/transactions';
    }
  }

  /// [CONNECT BANK API PATH]

  static String getBankAccountsFromCountry(String country) =>
      '$_baseUrl/consents/nordigen/aspsps/$country/find';

  static String get initiateRequisition => '$_baseUrl/consents/nordigen';

  static String getRequisitionStatus(String consentId) =>
      '$_baseUrl/consents/nordigen/$consentId';

  /// [POINTS API PATH]
  static String get getUserPoints => '$_baseUrl/accounts/points/find';

  /// [POINTS API PATH]
  static String updateNotificationOptin(String id) =>
      '$_baseUrl/notification-optins/$id';

  static String updateNotificationOptions(String notificationId) =>
      '$_baseUrl/notification-optins/$notificationId';

  /// [CURRENCY EXCHANGE API PATH]
  static String fetchExchangeConversions({required String uid, String? pages}) {
    if (pages == null) {
      return '$_baseUrl/accounts/$uid/conversions';
    } else {
      return '$_baseUrl/accounts/$uid/conversions?page_length=$pages';
    }
  }

  static String get createConversion => '$_baseUrl/exchange/conversions';

  static String exchangeRatesDetailed(
          {required String amount,
          required String buyCurrency,
          required String fixedSide,
          required String sellCurrency}) =>
      '$_baseUrl/exchange-rates/detailed/$buyCurrency/$sellCurrency/$fixedSide/$amount';

  /// [TRANSFERS API PATH]
  /// P2P
  static String get createp2pTransfer => '$_baseUrl/transfers';

  static String get createp2pMobileTransfer =>
      '$_baseUrl/mobile-money/transfers';

  static String get validateTransfer => '$_baseUrl/transfers/validate-transfer';

  static String payeeIdByEmail(String email) =>
      '$_baseUrl/utils/check-email/$email/get-account-id';

  static String checkgeniuspayUserByEmail(String email) =>
      '$_baseUrl/utils/check-email/$email';

  /// INTERNATIONAL

  static String get getInternationalTransferQuotation =>
      '$_baseUrl/payment-quotations';

  static String get validateInternationalTransfer =>
      '$_baseUrl/validate-payments';

  static String get validateInternationalQuotation =>
      '$_baseUrl/payments/convert-and-send/validate-payment';

  static String get createInternationalTransfer => '$_baseUrl/payments';

  static String get createInternationalTransferWithQuotation =>
      '$_baseUrl/payments/convert-and-send/create';

// [BENEFICIARY API PATH]
  static String fetchUserRecipients(String id) =>
      '$_baseUrl/accounts/$id/counterparties/email-recipients';

  static String fetchUserMobileRecipients(String id) =>
      '$_baseUrl/accounts/$id/counterparties/mobile-recipients';

  static String get addEmailRecipient =>
      '$_baseUrl/counterparties/email-recipients';

  static String get addMobileRecipient =>
      '$_baseUrl/counterparties/mobile-recipients';

  static String getBankBeneficiaryRequirements(
          String currency, String country) =>
      '$_baseUrl/references/beneficiary-requirements/$currency/$country';

  static String fetchBankBeneficiaries(String id) =>
      '$_baseUrl/accounts/$id/counterparties/bank-accounts';

  static String get addBankBeneficiary =>
      '$_baseUrl/counterparties/bank-accounts';

  static String get addIbanBankBeneficiary =>
      '$_baseUrl/counterparties/bank-accounts/create-by-iban';

  static String validateIban(String iban) =>
      '$_baseUrl/utils/iban/$iban/validate-iban';

  static String validateSwift(String swift) =>
      '$_baseUrl/bank-information/bic-swift/$swift/search';

  static String validateBsb(String bsb) =>
      '$_baseUrl/bank-information/bsb/$bsb/search';

  static String validateIfsc(String ifsc) =>
      '$_baseUrl/bank-information/ifsc/$ifsc/search';

  /// [PERKS API PATH]

  static String get perks => '$_baseUrl/perks';

  static String getSinglePerk(String perkId) => '$_baseUrl/perks/$perkId';

  static String get claimPerk => '$_baseUrl/perks/claim-perk';

  static String get getPerkCategories => '$_baseUrl/perks/categories';

  /// [DEPOSIT FUNDS API PATH]
  static String get stitchPayment => '$_baseUrl/deposits/stitch';

  static String get payuPayment => '$_baseUrl/deposits/payu';
  static String payuPaymentStatus(String payUid) =>
      '$_baseUrl/deposits/payu/$payUid';
  static String get trustlyPayment => '$_baseUrl/deposits/trustly';
  static String trustlyPaymentStatus(String trustlyId) =>
      '$_baseUrl/deposits/trustly/$trustlyId';

  static String get molliePayment => '$_baseUrl/deposits/mollie';
  static String molliePaymentStatus(String mollieId) =>
      '$_baseUrl/deposits/mollie/$mollieId';

// [DEPOSIT FUNDS API PATH]
  static String get fetchMobileNetworks => '$_baseUrl/mobile-money/networks';

  static String get fetchMMTCountries => '$_baseUrl/mobile-money/destinations';

  // [BUSINESS ONBOARDING API PATH]
  static String getBusinessDetails(String companyNumber) =>
      '$_baseUrl/business-profiles/$companyNumber';
  static String openBusinessAccount(String accountId) =>
      '$_baseUrl/kyb/$accountId/onboarding/';
  static String openBusinessAccountUsingLei(String accountId) =>
      '$_baseUrl/kyb/$accountId/onboarding/create-by-LEI';
  static String getCompanyTypes(String countryIso) =>
      '$_baseUrl/references/legal-entity-types?country=$countryIso';
  static String get getBusinessCategories => '$_baseUrl/references/industries';
  static String validateLEI(String leiCode) =>
      '$_baseUrl/kyb/$leiCode/validate-lei';
  static String validateCompanyCode(String companyCode, String countryIso) =>
      '$_baseUrl/references/company-search/$countryIso/$companyCode/find';

  static String get initiateCardTransfer => '$_baseUrl/deposits/card';
  static String get createStripePaymentIntent =>
      'https://api.stripe.com/v1/payment_intents';
  static String get cardPaymentConfirm =>
      '${Uri.parse(_baseUrl).origin}/events/stripe-notification-ybfi10assn34vvjn';

  // [DEVICES ONBOARDING API PATH]
  static String getDevices(
    String searchTerm,
    int pageNumber,
    int pageSize,
  ) =>
      '$_baseUrl/devices?filter[search]=$searchTerm&page[number]=$pageNumber&page[size]=$pageSize';
  static String get createDevice => '$_baseUrl/devices';
}
