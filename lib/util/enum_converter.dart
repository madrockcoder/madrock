import 'package:flutter/material.dart';

import '../models/source_of_funds.dart';
import 'color_scheme.dart';
import 'enums.dart';

mixin EnumConverter {
  final sourcesOfFunds = <SourceOfFunds>[
    SourceOfFunds(title: 'Rental income', requestText: 'RENTAL_INCOME'),
    SourceOfFunds(
        title: 'Loan borrowed funds', requestText: 'LOAN_BORROWED_FUNDS'),
    SourceOfFunds(title: 'Sales of property', requestText: 'PROPERTY_SALE'),
    SourceOfFunds(title: 'Lottery', requestText: 'LOTTERY'),
    SourceOfFunds(
        title: 'Funds from family members/close relatives',
        requestText: 'FRIENDS_FAMILY'),
    SourceOfFunds(title: 'Betting/gambling', requestText: 'BETTING_GAMBLING'),
    SourceOfFunds(title: 'Personal wealth', requestText: 'PERSONAL_WEALTH'),
    SourceOfFunds(title: 'Inheritance', requestText: 'INHERITANCE'),
    SourceOfFunds(title: 'Investment', requestText: 'INVESTMENT'),
    SourceOfFunds(
        title: 'Salary or pension (including redundancy)',
        requestText: 'SALARY_PENSION'),
    SourceOfFunds(title: 'Savings', requestText: 'SAVINGS'),
    SourceOfFunds(title: 'Business earnings', requestText: 'BUSINESS_EARNINGS'),
    SourceOfFunds(
        title: 'Business owner shareholder',
        requestText: 'BUSINESS_OWNER_SHAREHOLDER'),
    SourceOfFunds(title: 'Other', requestText: 'OTHER'),
  ];

  String getVerifStatusString(VerificationStatus? status) {
    if (status == null) return '';
    switch (status) {
      case VerificationStatus.addressRequired:
        return 'Address required';
      case VerificationStatus.verified:
        return 'Verified';
      case VerificationStatus.unverified:
        return 'Unverified';
      case VerificationStatus.pending:
        return 'Pending';
      case VerificationStatus.rejected:
        return 'Rejected';
      case VerificationStatus.none:
        return 'None';
    }
  }

  String getBankIdentifierType(BankIdentifierType bankId) {
    switch (bankId) {
      case BankIdentifierType.sortCode:
        return 'SORT_CODE';
      case BankIdentifierType.bicSwift:
        return 'BIC_SWIFT';
      case BankIdentifierType.routingNo:
        return 'ROUTING_NUMBER';
      case BankIdentifierType.email:
        return 'EMAIL';
      case BankIdentifierType.bsbCode:
        return 'BSB_CODE';
      case BankIdentifierType.ifsc:
        return 'IFSC';
      case BankIdentifierType.nscNumber:
        return 'NSC_NUMBER';
      case BankIdentifierType.nccCode:
        return 'NCC_CODE';
      case BankIdentifierType.clabe:
        return 'CLABE';
      case BankIdentifierType.branchCode:
        return 'BRANCH_CODE';
      case BankIdentifierType.bankCode:
        return 'BANK_CODE';
      case BankIdentifierType.institutionCode:
        return 'INSTITUTION_CODE';
      case BankIdentifierType.aba:
        return 'ABA';
    }
  }

  String getOnboardingStatusString(OnboardingStatus? status) {
    if (status == null) return '';
    switch (status) {
      case OnboardingStatus.onboardingRequired:
        return 'Onboarding Required';
      case OnboardingStatus.passCodeRequired:
        return 'Passcode Required';
      case OnboardingStatus.KycidVerifRequired:
        return 'KYC ID verification required';
      case OnboardingStatus.KycIdVerifSubmitted:
        return 'KYC ID verification submitted';
      case OnboardingStatus.KycTaxDeclarationRequired:
        return 'KYC Tax declaration Required';
      case OnboardingStatus.onboardingFailed:
        return 'Onboarding failed';
      case OnboardingStatus.KycAssesmentRequired:
        return 'KYC Profile Assesment required';
      case OnboardingStatus.KycAddressRequired:
        return 'KYC address verificaiton required';
      case OnboardingStatus.PlanSelectionRequired:
        return 'Plan selection required';
      case OnboardingStatus.onboardingCompleted:
        return 'Onboarding Completed';
      case OnboardingStatus.unknown:
        return 'Unknown status';
    }
  }

  String getPlanName(Plans plan) {
    switch (plan) {
      case Plans.basic:
        return 'Basic';
      case Plans.smart:
        return 'Smart';
      case Plans.genius:
        return 'Genius';
      case Plans.small:
        return 'Small';
      case Plans.medium:
        return 'Medium';
      case Plans.enterprise:
        return 'Enterprise';
      case Plans.enterprisePlus:
        return 'Enterprise +';
      case Plans.starter:
        return 'Starter';
      case Plans.professional:
        return 'Professional';
      case Plans.ultimate:
        return 'Ultimate';
    }
  }

  String getStringFromPlan(Plans plan) {
    switch (plan) {
      case Plans.basic:
        return 'BASIC';
      case Plans.smart:
        return 'SMART';
      case Plans.genius:
        return 'GENIUS';
      case Plans.small:
        return 'SMALL';
      case Plans.medium:
        return 'MEDIUM';
      case Plans.enterprise:
        return 'ENTERPRISE';
      case Plans.enterprisePlus:
        return 'ENTERPRISE_PLUS';
      case Plans.starter:
        return 'STARTER';
      case Plans.professional:
        return 'PROFESSIONAL';
      case Plans.ultimate:
        return 'ULTIMATE';
    }
  }

  Color getVerifStatusColor(VerificationStatus? status) {
    if (status == null) return AppColor.kRedColor;
    switch (status) {
      case VerificationStatus.addressRequired:
        return AppColor.kRedColor;
      case VerificationStatus.verified:
        return AppColor.kGreen;
      case VerificationStatus.unverified:
        return AppColor.kRedColor;
      case VerificationStatus.pending:
        return AppColor.kOnboard3Color;
      case VerificationStatus.rejected:
        return AppColor.kRedColor;
      default:
        return AppColor.kRedColor;
    }
  }

  String getTransactionTypeString(TransactionType type) {
    switch (type) {
      case TransactionType.deposit:
        return 'Deposit';
      case TransactionType.remittance:
        return 'Remittance';
      case TransactionType.wireTransfer:
        return 'Wire transfer';
      case TransactionType.internalTransfer:
        return 'Internal transfer';
      case TransactionType.currencyExchange:
        return 'Currency Exchange';
      case TransactionType.exchange:
        return 'Currency Exchange';
      case TransactionType.balanceTransfer:
        return 'Transfer';
      case TransactionType.internetPurchase:
        return 'Internal Purchase';
      case TransactionType.payoutWithdrawal:
        return 'Payout Withdrawal';
      case TransactionType.walletFundTransfer:
        return 'Wallet fund transfer';
      case TransactionType.walletRefund:
        return 'Wallet refund';
      case TransactionType.voucherDeposit:
        return 'Voucher Deposit';
      case TransactionType.invoiceSettlement:
        return 'Invoice settlement';
      case TransactionType.feeDebit:
        return 'Fee debit';
      case TransactionType.feeReversal:
        return 'Fee reversal';
      case TransactionType.feeWaiver:
        return 'Fee Waiver';
      case TransactionType.other:
        return 'Other';
    }
  }

  String getPEPTypeText(PEPType? type) {
    switch (type) {
      case PEPType.direct:
        return 'Direct';
      case PEPType.closeAssoc:
        return 'Close associates';
      case PEPType.familyMember:
        return 'Family member';
      case PEPType.formerPep:
        return 'Former pep';
      default:
        return '';
    }
  }

  String? getPEPTypeRequestText(PEPType? type) {
    if (type == null) return null;
    switch (type) {
      case PEPType.direct:
        return 'DIRECT';
      case PEPType.closeAssoc:
        return 'CLOSE_ASSOC';
      case PEPType.familyMember:
        return 'FAMILY_MEMBER';
      case PEPType.formerPep:
        return 'FORMER_PEP';
    }
  }

  String? getPEPStatusRequestText(PepStatus? type) {
    if (type == null) return null;
    switch (type) {
      case PepStatus.mySelf:
        return 'DIRECT';
      case PepStatus.associate:
        return 'CLOSE_ASSOC';
      case PepStatus.family:
        return 'FAMILY_MEMBER';
    }
  }

  String getNoTINReasonText(NoTINReason? reason) {
    switch (reason) {
      case NoTINReason.notAssignedYet:
        return 'Not assigned yet';
      case NoTINReason.notAssignedByCountry:
        return 'Not assigned by Country';
      case NoTINReason.other:
        return 'Other';
      default:
        return 'Other';
    }
  }

  String? getNoTINReasonRequestText(NoTINReason? reason) {
    if (reason == null) return null;
    switch (reason) {
      case NoTINReason.notAssignedYet:
        return 'NOT_ASSIGNED_YET';
      case NoTINReason.notAssignedByCountry:
        return 'NOT_ASSIGNED_BY_COUNTRY';
      case NoTINReason.other:
        return 'OTHER';
      default:
        return 'OTHER';
    }
  }

  String getExpectedFundsText(ExpectedFunds? funds) {
    switch (funds) {
      case ExpectedFunds.less500:
        return 'Less than \$500';
      case ExpectedFunds.f5hto1h:
        return '\$500-\$1,000';
      case ExpectedFunds.f1kt1k5:
        return '\$1001-\$1,500';
      case ExpectedFunds.f1k5t2k:
        return '\$1501-\$2,000';
      case ExpectedFunds.f2kt3k:
        return '\$2,001-\$3,000';
      case ExpectedFunds.more:
        return 'More than\$3,000';
      default:
        return 'More than\$3,000';
    }
  }

  String getExpectedFundsRequestText(ExpectedFunds? funds) {
    switch (funds) {
      case ExpectedFunds.less500:
        return 'LESS_THAN_500';
      case ExpectedFunds.f5hto1h:
        return 'FROM_500_1000';
      case ExpectedFunds.f1kt1k5:
        return 'FROM_1001_1500';
      case ExpectedFunds.f1k5t2k:
        return 'FROM_1501_2000';
      case ExpectedFunds.f2kt3k:
        return 'FROM_2001_3000';
      case ExpectedFunds.more:
        return 'MORE_THAN_3000';
      default:
        return 'MORE_THAN_3000';
    }
  }

  String getOccupationText(Occupation? occupation) {
    switch (occupation) {
      case Occupation.publicServant:
        return 'Public servant/Police/Military';
      case Occupation.agriculture:
        return 'Agriculture';
      case Occupation.trade:
        return 'Craftwork/Trade';
      case Occupation.art:
        return 'Arts/Culture/Sport';
      case Occupation.finance:
        return 'Banking/Insurance/Finance/Auditing';
      case Occupation.construction:
        return 'Construction/Publicworks';
      case Occupation.technology:
        return 'Technology/science';
      case Occupation.education:
        return 'Education';
      case Occupation.manufacturing:
        return 'Manufacturing/Maintenance';
      case Occupation.medical:
        return 'Medical/Paramedical';
      case Occupation.food:
        return 'Food industry/Work from home/Hospitality/Tourism';
      default:
        return 'Other';
    }
  }

  String getEmployeeStatusText(EmployeeStatus? employeeStatus) {
    switch (employeeStatus) {
      case EmployeeStatus.employeeWorker:
        return 'Employee (worker)';
      case EmployeeStatus.unemployed:
        return 'Unemployed';
      case EmployeeStatus.publicSectorEmployee:
        return 'Public sector employee';
      case EmployeeStatus.military:
        return 'Military';
      case EmployeeStatus.freelancer:
        return 'Freelancer';
      case EmployeeStatus.houseWork:
        return 'House work';
      case EmployeeStatus.apprentice:
        return 'Apprentice';
      case EmployeeStatus.executive:
        return 'Executive';
      case EmployeeStatus.manager:
        return 'Manager';
      case EmployeeStatus.retiree:
        return 'Retiree';
      case EmployeeStatus.student:
        return 'Student';
      case EmployeeStatus.selfEmployed:
        return 'Self Employed';
      default:
        return 'Other';
    }
  }

  String getEmployeeStatusRequestText(EmployeeStatus? employeeStatus) {
    switch (employeeStatus) {
      case EmployeeStatus.employeeWorker:
        return 'EMPLOYEE_WORKER';
      case EmployeeStatus.unemployed:
        return 'UNEMPLOYED';
      case EmployeeStatus.publicSectorEmployee:
        return 'PUBLIC_SECTOR_EMPLOYEE';
      case EmployeeStatus.military:
        return 'SOLDIER';
      case EmployeeStatus.freelancer:
        return 'FREELANCER';
      case EmployeeStatus.houseWork:
        return 'HOUSEWORK';
      case EmployeeStatus.apprentice:
        return 'APPRENTICE';
      case EmployeeStatus.executive:
        return 'EXECUTIVE';
      case EmployeeStatus.manager:
        return 'MANAGER';
      case EmployeeStatus.retiree:
        return 'RETIREE';
      case EmployeeStatus.student:
        return 'STUDENT';
      case EmployeeStatus.selfEmployed:
        return 'SELF_EMPLOYED';
      default:
        return 'Other';
    }
  }

  String getReasonForClosureText(ReasonForClosure? reason) {
    switch (reason) {
      case ReasonForClosure.accountNoLongerRequired:
        return 'Account no longer required';
      case ReasonForClosure.customerWish:
        return 'Customer wish';
      case ReasonForClosure.businessRelationEnds:
        return 'Business relations end';
      case ReasonForClosure.other:
        return 'Other';
      default:
        return 'Other';
    }
  }

  String getReasonForClosureRequestText(ReasonForClosure? reason) {
    if (reason == null) return 'OTHER';
    switch (reason) {
      case ReasonForClosure.accountNoLongerRequired:
        return 'ACCOUNT_NO_LONGER_REQUIRED';
      case ReasonForClosure.customerWish:
        return 'CUSTOMER_WISH';
      case ReasonForClosure.businessRelationEnds:
        return 'BUSINESS_RELATIONS_END';
      case ReasonForClosure.other:
        return 'OTHER';
      default:
        return 'OTHER';
    }
  }
}
