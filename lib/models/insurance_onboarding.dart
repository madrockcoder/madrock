import '../util/enums.dart';
import '../util/iconPath.dart';

///Model to handle insurance onboarding
class InsuranceOnboarding {
  final String icon, description;
  final String funeralCost, accidentCost, temporalDisabilityCost;
  final InsurancePlan insurancePlan;

  InsuranceOnboarding(
      {required this.icon,
      required this.description,
      required this.funeralCost,
      required this.accidentCost,
      required this.temporalDisabilityCost,
      required this.insurancePlan});
}

//List stores the data for displaying items on the Insurance Onboarding page
List<InsuranceOnboarding> listOfInsuranceOnboarding = [
  InsuranceOnboarding(
      icon: IconPath.basicInsuranceIcon,
      description: 'Send €200 (or more) per\nmonth and get coverage for:',
      funeralCost: 'N/A',
      accidentCost: '€5,000',
      temporalDisabilityCost: 'N/A',
      insurancePlan: InsurancePlan.basic),
  InsuranceOnboarding(
      icon: IconPath.silverInsuranceIcon,
      description: 'Send €650 (or more) per\nmonth and get coverage for:',
      funeralCost: '€10,000',
      accidentCost: '€10,000',
      temporalDisabilityCost: '€400',
      insurancePlan: InsurancePlan.silver),
  InsuranceOnboarding(
      icon: IconPath.goldInsuranceIcon,
      description: 'Send €1,500 (or more) per\nmonth and get coverage for:',
      funeralCost: '€10,000',
      accidentCost: '€20,000',
      temporalDisabilityCost: '€750',
      insurancePlan: InsurancePlan.gold),
];
