import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:geniuspay/models/business_profile_model.dart';
import 'package:geniuspay/models/connect_bank_response.dart';
import 'package:geniuspay/models/earnings_model.dart';
import 'package:geniuspay/models/kyc_verification.dart';
import 'package:geniuspay/models/total_amount.dart';
import 'package:geniuspay/models/transaction_limit.dart';

import '../util/enums.dart';
import 'notification_option.dart';

class UserProfile extends Equatable {
  final VerificationStatus verificationStatus;
  final OnboardingStatus onboardingStatus;
  final bool kycSubmitted;
  final String? countryIso2;
  final String? citizenshipIso2;
  final String? customerNumber;
  final String? rank;
  UserProfileMobileNumber? mobileNumber;
  final ProfileStatus status;
  final String? referralId;
  final List<String> reasonUsingApp;
  final Address? addresses;
  final String? website;
  final bool isFreelancer;
  final NotificationOption? notificationOption;
  final String? timeZone;
  final String? birthDate;
  final String? passCode;
  final TotalAmount? totalBalance;
  final String? points;
  final String? language;
  final String? placeOfBirth;
  final String? defaultCurrency;
  final bool onboardingCompleted;
  final ConnectBankResponse? aisConsent;
  final Refferal refferal;
  final bool optForBeta;
  final Plans subscriptionPlan;
  final TransactionLimits? transactionLimits;
  final bool? limitRaised;
  final EarningsModel? earnings;
  final BusinessProfileModel? businessProfile;
  final KYCVerification? kycVerification;

  UserProfile(
      {required this.verificationStatus,
      required this.onboardingStatus,
      required this.kycSubmitted,
      required this.countryIso2,
      required this.citizenshipIso2,
      required this.customerNumber,
      required this.rank,
      this.mobileNumber,
      required this.status,
      required this.referralId,
      required this.reasonUsingApp,
      required this.addresses,
      required this.website,
      required this.isFreelancer,
      required this.notificationOption,
      required this.timeZone,
      required this.birthDate,
      required this.points,
      required this.language,
      required this.placeOfBirth,
      required this.defaultCurrency,
      required this.onboardingCompleted,
      required this.refferal,
      this.earnings,
      this.transactionLimits,
      this.limitRaised,
      this.aisConsent,
      this.totalBalance,
      this.passCode,
      this.kycVerification,
      required this.optForBeta,
      this.businessProfile,
      this.subscriptionPlan = Plans.basic});

  void updatePhone(UserProfileMobileNumber? phone) {
    mobileNumber = phone;
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    final rank = map['rank'] ?? '';
    return UserProfile(
        verificationStatus: getVerificationStatus(map['verification_status']),
        onboardingStatus: getOnboardingStatus(map['onboarding_status']),
        kycSubmitted: map['kyc_submitted'] ?? false,
        countryIso2: map['country'] ?? '',
        citizenshipIso2: map['citizenship'],
        placeOfBirth: map['country_of_birth'] ?? '',
        customerNumber: map['customer_number'] ?? '',
        status: getProfileStatus(map['account_status'] ?? ''),
        referralId: map['referral_id'] ?? '',
        rank: serializedWords(rank as String),
        reasonUsingApp: map['reason_using_app'] == null
            ? []
            : [...map['reason_using_app'] as List<String>],
        addresses: map['address'] == null
            ? null
            : Address.fromMap(map['address'] as Map<String, dynamic>),
        mobileNumber: map['mobile_number'] == null
            ? null
            : UserProfileMobileNumber.fromMap(
                map['mobile_number'] as Map<String, dynamic>,
              ),
        website: map['website'] ?? '',
        isFreelancer: map['is_freelancer'] as bool,
        timeZone: map['time_zone'] ?? '',
        birthDate: map['birth_date'] ?? '',
        notificationOption: map['notification_optin'] == null
            ? null
            : NotificationOption.fromMap(
                map['notification_optin'] as Map<String, dynamic>),
        totalBalance: TotalAmount.fromMap(
          map['balance_in_default_currency'] as Map<String, dynamic>,
        ),
        passCode: map['passcode'] ?? '',
        points: map['points']['points'] == null
            ? '0'
            : map['points']['points'].toString(),
        language: map['language'] ?? '',
        defaultCurrency: map['default_currency'] ?? '',
        businessProfile: map['business'] == null
            ? null
            : BusinessProfileModel.fromJson(map['business']),
        onboardingCompleted: map['onboarding_completed'] ?? false,
        refferal: Refferal(
            earned: map['referrals']['earnings'],
            joined: map['referrals']['total_referred']),
        aisConsent: map['ais_consent'] == null
            ? null
            : ConnectBankResponse.fromMap(map['ais_consent']),
        limitRaised: map['limit_raised'] ?? false,
        optForBeta: map['opt_for_beta_testing'] ?? false,
        subscriptionPlan: getPlanFromString(map['subscription_plan']),
        transactionLimits: map['transaction_limits'] == null
            ? null
            : TransactionLimits.fromMap(map['transaction_limits']),
        kycVerification: map['kyc_verification'] == null
            ? null
            : KYCVerification.fromMap(
                map['kyc_verification'],
              ),
        earnings: map['earnings'] == null
            ? null
            : EarningsModel.fromMap(map['earnings']));
  }

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source));

  @override
  List<Object> get props {
    return [
      verificationStatus,
      onboardingStatus,
      kycSubmitted,
      countryIso2!,
      customerNumber!,
      rank!,
      status,
      referralId!,
      reasonUsingApp,
      website!,
      isFreelancer,
      timeZone!,
    ];
  }

  @override
  String toString() {
    return 'UserProfile(verificationStatus: $verificationStatus, onboardingStatus: $onboardingStatus, kycSubmitted: $kycSubmitted, countryIso2: $countryIso2, citizenshipIso2: $citizenshipIso2, customerNumber: $customerNumber, rank: $rank, mobileNumber: $mobileNumber, status: $status, referralId: $referralId, reasonUsingApp: $reasonUsingApp, addresses: $addresses, website: $website, isFreelancer: $isFreelancer, notificationOption: $notificationOption, timeZone: $timeZone)';
  }
}

ProfileStatus getProfileStatus(String? status) {
  switch (status) {
    case "ACTIVE":
      return ProfileStatus.active;
    case "BANNED":
      return ProfileStatus.banned;
    case "SUSPENDED":
      return ProfileStatus.suspended;
    case "BLOCKED":
      return ProfileStatus.blocked;
    case "CLOSING":
      return ProfileStatus.closing;
    case "CLOSED":
      return ProfileStatus.closed;
    case "LIMITED":
      return ProfileStatus.limited;
    default:
      return ProfileStatus.unknown;
  }
}

Plans getPlanFromString(String? plan) {
  switch (plan) {
    case 'BASIC':
      return Plans.basic;
    case 'SMART':
      return Plans.smart;
    case 'GENIUS':
      return Plans.genius;
    case 'SMALL':
      return Plans.small;
    case 'MEDIUM':
      return Plans.medium;
    case 'ENTERPRISE':
      return Plans.enterprise;
    case 'ENTERPRISE_PLUS':
      return Plans.enterprisePlus;
    case 'STARTER':
      return Plans.starter;
    case 'PROFESSIONAL':
      return Plans.professional;
    case 'ULTIMATE':
      return Plans.ultimate;
    default:
      return Plans.basic;
  }
}

UserType getUserType(String? userType) {
  switch (userType) {
    case 'PERSONAL':
      return UserType.personal;
    case 'BUSINESS':
      return UserType.business;
    default:
      return UserType.personal;
  }
}

String convertToTitleCase(String word) {
  final text = word.toLowerCase();
  final tail = text.split(text[0]).last;
  return '${text[0].toUpperCase()}$tail';
}

String serializedWords(String word) {
  final wordArr = word.toLowerCase().split(' ');
  var converted = '';

  for (var w in wordArr) {
    converted += '${convertToTitleCase(w)} ';
  }

  return converted;
}

VerificationStatus getVerificationStatus(String verifStatus) {
  switch (verifStatus) {
    case 'ADDRESS_REQUIRED':
      return VerificationStatus.addressRequired;
    case 'VERIFIED':
      return VerificationStatus.verified;
    case 'UNVERIFIED':
      return VerificationStatus.unverified;
    case 'PENDING':
      return VerificationStatus.pending;
    case 'IDV_SUBMITTED':
      return VerificationStatus.pending;
    case 'REJECTED':
      return VerificationStatus.rejected;
  }
  return VerificationStatus.none;
}

OnboardingStatus getOnboardingStatus(String status) {
  switch (status) {
    case 'ONBOARDING_REQUIRED':
      return OnboardingStatus.onboardingRequired;
    case 'PASSCODE_REQUIRED':
      return OnboardingStatus.passCodeRequired;
    case 'ID_VERIFICATION_REQUIRED':
      return OnboardingStatus.KycidVerifRequired;
    case 'ID_VERIFICATION_SUBMITTED':
      return OnboardingStatus.KycIdVerifSubmitted;
    case 'TAX_DECLARATION_REQUIRED':
      return OnboardingStatus.KycTaxDeclarationRequired;
    case 'ONBOARDING_FAILED':
      return OnboardingStatus.onboardingFailed;
    case 'ASSESSMENT_REQUIRED':
      return OnboardingStatus.KycAssesmentRequired;
    case 'ADDRESS_REQUIRED':
      return OnboardingStatus.KycAddressRequired;
    case 'PLAN_REQUIRED':
      return OnboardingStatus.PlanSelectionRequired;
    case 'COMPLETED':
      return OnboardingStatus.onboardingCompleted;
    default:
      return OnboardingStatus.unknown;
  }
}

class Address extends Equatable {
  final String id;
  final String addressLine1;
  final String addressLine2;
  final String state;
  final String city;
  final String countryIso2;
  final String status;
  final String zipCode;

  const Address({
    required this.id,
    required this.addressLine1,
    required this.state,
    required this.city,
    required this.countryIso2,
    required this.status,
    required this.zipCode,
    required this.addressLine2,
  });

  factory Address.fromMap(Map<String, dynamic>? map) {
    return Address(
      id: map?['id'] ?? '',
      addressLine1: map?['address_line_1'] ?? '',
      addressLine2: map?['address_line_2'] ?? '',
      state: map?['state'] ?? '',
      city: map?['city'] ?? '',
      countryIso2: map?['country'] ?? '',
      status: map?['account_status'] ?? '',
      zipCode: map?['zip_code'] ?? '',
    );
  }

  RegisteredAddress toRegisteredAddress() => RegisteredAddress(
        addressLine1: addressLine1,
        addressLine2: addressLine2,
        city: city,
        stateOrProvince: state.isEmpty ? city : state,
        zipCode: zipCode,
        country: countryIso2,
      );

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source));

  @override
  List<Object> get props {
    return [
      id,
      addressLine1,
      state,
      city,
      countryIso2,
      status,
      zipCode,
    ];
  }

  @override
  String toString() {
    return 'Address(id: $id, addressLine1: $addressLine1, state: $state, city: $city, countryIso2: $countryIso2, status: $status, zipCode: $zipCode)';
  }
}

class UserProfileMobileNumber extends Equatable {
  final String id;
  final String number;
  final bool verified;

  const UserProfileMobileNumber({
    required this.id,
    required this.number,
    required this.verified,
  });

  factory UserProfileMobileNumber.fromMap(Map<String, dynamic>? map) {
    return UserProfileMobileNumber(
      id: map?['id'] ?? '',
      number: map?['number'] ?? '',
      verified: map?['verified'] ?? false,
    );
  }

  factory UserProfileMobileNumber.fromJson(source) =>
      UserProfileMobileNumber.fromMap(source);

  @override
  List<Object> get props => [id, number, verified];

  @override
  String toString() =>
      'UserProfileMobileNumber(id: $id, number: $number, verified: $verified)';
}

class Refferal {
  final double earned;
  final int joined;

  Refferal({required this.earned, required this.joined});
}
