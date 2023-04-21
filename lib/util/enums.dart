enum PinCode { verify, createNewPin, updatePin }

enum UserState { unlock, hold }

enum AuthType { signUp, logIn }

enum Policy { termsAndConditions, amlPolicy, privacyPolicy, referalTerms }

enum DayPeriod { morning, afternoon, evening }

enum VerificationStatus { none, addressRequired, verified, unverified, pending, rejected }

enum KYCVerificationStatus { verified, pending, idSumbitted, rejected }

enum PaymentType { priority, regular }

enum PaymentDeliveryTime { instant, urgent, regular }

PaymentDeliveryTime getDeliveryTimeEnum(String deliveryTime) {
  switch (deliveryTime) {
    case 'INSTANT':
      return PaymentDeliveryTime.instant;
    case 'REGULAR':
      return PaymentDeliveryTime.regular;
    case 'URGENT':
      return PaymentDeliveryTime.urgent;
    default:
      return PaymentDeliveryTime.instant;
  }
}

String getPaymentDeliveryTime(PaymentDeliveryTime deliveryTime) {
  switch (deliveryTime) {
    case PaymentDeliveryTime.instant:
      return 'INSTANT';
    case PaymentDeliveryTime.regular:
      return 'REGULAR';
    case PaymentDeliveryTime.urgent:
      return 'URGENT';
  }
}

enum BankIdentifierType {
  sortCode,
  bicSwift,
  routingNo,
  email,
  bsbCode,
  ifsc,
  nscNumber,
  nccCode,
  clabe,
  branchCode,
  bankCode,
  institutionCode,
  aba
}

enum ProfileStatus { active, banned, suspended, blocked, closing, closed, limited, unknown }

enum TransactionType {
  deposit,
  remittance,
  wireTransfer,
  internalTransfer,
  currencyExchange,
  exchange,
  balanceTransfer,
  internetPurchase,
  payoutWithdrawal,
  walletFundTransfer,
  walletRefund,
  voucherDeposit,
  invoiceSettlement,
  feeDebit,
  feeReversal,
  feeWaiver,
  other,
}

enum BankRecipientType { individual, company }

String bankEnumString(BankRecipientType recipient) {
  switch (recipient) {
    case BankRecipientType.individual:
      return 'INDIVIDUAL';
    case BankRecipientType.company:
      return 'COMPANY';
  }
}

enum HomeWidgetType {
  transactions,
  spending,
  budget,
  jars,
  exchangeRates,
}

enum OnboardingStatus {
  onboardingRequired,
  passCodeRequired,
  KycidVerifRequired,
  KycIdVerifSubmitted,
  KycTaxDeclarationRequired,
  onboardingFailed,
  KycAssesmentRequired,
  KycAddressRequired,
  PlanSelectionRequired,
  onboardingCompleted,
  unknown
}

enum ReasonForClosure {
  accountNoLongerRequired,
  customerWish,
  businessRelationEnds,
  other,
}

enum InternalPaymentType { ownWallet, geniuspayWallet }

enum InternalPaymentDirection { from, to }

enum UserType { personal, business }

enum PepStatus { mySelf, family, associate }

enum BusinessType { company, freelancer }

enum CustomSwitchSliderPositionTapped { left, right }

enum NoTINReason { notAssignedYet, notAssignedByCountry, other }

enum PEPType { direct, closeAssoc, familyMember, formerPep }

enum RequestStatus { success, failure, info, warning }

enum ExpectedFunds { less500, f5hto1h, f1kt1k5, f1k5t2k, f2kt3k, more }

enum EmployeeStatus {
  employeeWorker,
  unemployed,
  publicSectorEmployee,
  military,
  freelancer,
  houseWork,
  apprentice,
  executive,
  manager,
  retiree,
  student,
  selfEmployed,
}

enum Occupation {
  publicServant,
  agriculture,
  trade,
  art,
  finance,
  technology,
  construction,
  education,
  manufacturing,
  medical,
  food
}

enum Plans { basic, smart, genius, small, medium, enterprise, enterprisePlus, starter, professional, ultimate }

enum WalletStatus { ACTIVE, INACTIVE, DEACTIVATED }

enum AnimateType { slideLeft, slideUp }

enum InsurancePlan { basic, silver, gold }

String getInsurancePlaneEnum(InsurancePlan plan) {
  switch (plan) {
    case InsurancePlan.basic:
      return 'Basic Plan';
    case InsurancePlan.silver:
      return 'Silver Plan';
    case InsurancePlan.gold:
      return 'Gold Plan';
    default:
      return '';
  }
}
