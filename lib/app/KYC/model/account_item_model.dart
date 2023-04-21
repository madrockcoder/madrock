class AccountItemModel {
  AccountItemModel(
      {required this.icon, required this.name, required this.requestText});
  final String name;
  final String icon;
  final String requestText;
}

class AccountItemList {
  static final accountPurposeList = [
    AccountItemModel(
      requestText: 'PERSONAL_EXPENSES',
      icon: 'assets/images/personal_expense.svg',
      name: 'Personal Expenses',
    ),
    AccountItemModel(
      requestText: 'FASTER_TRANSACTION',
      icon: 'assets/images/faster_transaction.svg',
      name: 'Faster transactions',
    ),
    AccountItemModel(
      requestText: 'MONEY_TRANSFER',
      icon: 'assets/images/send_moneyy.svg',
      name: 'Money transfers',
    ),
    AccountItemModel(
      requestText: 'ONLINE_PAYMENTS',
      icon: 'assets/images/online_payment.svg',
      name: 'Online payments',
    ),
    AccountItemModel(
      requestText: 'USE_ABROAD',
      icon: 'assets/images/for_abroad.svg',
      name: 'For use abroad',
    ),
    AccountItemModel(
      requestText: 'FINANCIAL_ASSETS',
      icon: 'assets/images/financial_asset.svg',
      name: 'Your financial assets',
    ),
    AccountItemModel(
      requestText: 'GAMBLING_BETTING',
      icon: 'assets/images/gaming.svg',
      name: 'Gaming or Betting on-line',
    ),
    AccountItemModel(
      requestText: 'BUSINESS_ACTIVITY',
      icon: 'assets/images/recive_income.svg',
      name: 'Receive income from business activity',
    ),
  ];
  static final sourceOfFunds = [
    AccountItemModel(
      requestText: 'SALARY_PENSION',
      icon: 'assets/images/salary.svg',
      name: 'Salary or pension',
    ),
    AccountItemModel(
      requestText: 'BUSINESS_EARNINGS',
      icon: 'assets/images/business.svg',
      name: 'Business Activity',
    ),
    AccountItemModel(
      requestText: 'SAVINGS',
      icon: 'assets/images/saving.svg',
      name: 'My Savings',
    ),
    AccountItemModel(
      requestText: 'RENTAL_INCOME',
      icon: 'assets/images/rental.svg',
      name: 'Rental Income',
    ),
    AccountItemModel(
      requestText: 'LOAN_BORROWED_FUNDS',
      icon: 'assets/images/loaans.svg',
      name: 'Loans / borrowed funds',
    ),
    AccountItemModel(
      requestText: 'FRIENDS_FAMILY',
      icon: 'assets/images/funds_family.svg',
      name: 'Funds from close relatives',
    ),
    AccountItemModel(
      requestText: 'INHERITANCE',
      icon: 'assets/images/inheritance.svg',
      name: 'Inherited funds',
    ),
    AccountItemModel(
      requestText: 'PROPERTY_SALE',
      icon: 'assets/images/sales_properties.svg',
      name: 'Sales of property',
    ),
    AccountItemModel(
      requestText: 'LOTTERY',
      icon: 'assets/images/lottery.svg',
      name: 'Lottery / Gamble',
    ),
  ];

  static final employeeStatus = [
    AccountItemModel(
      icon: 'assets/images/statu_director.svg',
      name: 'Director / Owner',
      requestText: 'EXECUTIVE',
    ),
    AccountItemModel(
      icon: 'assets/images/statu_executive.svg',
      name: 'Executive',
      requestText: 'EXECUTIVE',
    ),
    AccountItemModel(
      icon: 'assets/images/statu_manager.svg',
      name: 'Manager',
      requestText: 'MANAGER',
    ),
    AccountItemModel(
      icon: 'assets/images/statu_employee.svg',
      name: 'Employee / Worker',
      requestText: 'EMPLOYEE_WORKER',
    ),
    AccountItemModel(
      icon: 'assets/images/statu_self.svg',
      name: 'Self employed',
      requestText: 'SELF_EMPLOYED',
    ),
    AccountItemModel(
      icon: 'assets/images/statu_student.svg',
      name: 'Student',
      requestText: 'STUDENT',
    ),
    AccountItemModel(
      icon: 'assets/images/statu_retiree.svg',
      name: 'Retiree',
      requestText: 'RETIREE',
    ),
    AccountItemModel(
      icon: 'assets/images/statu_unemployed.svg',
      name: 'Unemployed',
      requestText: 'UNEMPLOYED',
    ),
  ];

  static final occupationList = [
    AccountItemModel(
      icon: 'assets/images/occu_public.svg',
      name: 'Public servant / Police / Military',
      requestText: '',
    ),
    AccountItemModel(
      icon: 'assets/images/occu_craft.svg',
      name: 'Craftwork / Trade',
      requestText: '',
    ),
    AccountItemModel(
      icon: 'assets/images/occu_art.svg',
      name: 'Arts / Culture / Sport',
      requestText: '',
    ),
    AccountItemModel(
      icon: 'assets/images/occu_banking.svg',
      name: 'Banking / Insurance / Finance / Auditing',
      requestText: '',
    ),
    AccountItemModel(
      icon: 'assets/images/occu_agric.svg',
      name: 'Agriculture',
      requestText: '',
    ),
    AccountItemModel(
      icon: 'assets/images/occu_construction.svg',
      name: 'Construction / Publicworks',
      requestText: '',
    ),
    AccountItemModel(
      icon: 'assets/images/occu_education.svg',
      name: 'Education',
      requestText: '',
    ),
    AccountItemModel(
      icon: 'assets/images/occu_medical.svg',
      name: 'Medical / Paramedical',
      requestText: '',
    ),
    AccountItemModel(
      icon: 'assets/images/occu_it.svg',
      name: 'Services / IT',
      requestText: '',
    ),
    AccountItemModel(
      icon: 'assets/images/occu_ngo.svg',
      name: 'Social Security / NGO',
      requestText: '',
    ),
    AccountItemModel(
      icon: 'assets/images/occu_politican.svg',
      name: 'Politician ',
      requestText: '',
    ),
    AccountItemModel(
      icon: 'assets/images/occu_food.svg',
      name: 'Food industry / Hospitality / Tourism ',
      requestText: '',
    ),
  ];

  static final expectedFunds = [
    AccountItemModel(
      icon: '',
      name: 'Less than \$500',
      requestText: 'LESS_THAN_500',
    ),
    AccountItemModel(
      icon: '',
      name: '\$500 - \$1,000',
      requestText: 'FROM_500_1000',
    ),
    AccountItemModel(
      icon: '',
      name: '\$1,001 - \$1,500',
      requestText: 'FROM_1001_1500',
    ),
    AccountItemModel(
      icon: '',
      name: '\$1,501 - \$2,000',
      requestText: 'FROM_1501_2000',
    ),
    AccountItemModel(
      icon: '',
      name: '\$2,001 - \$3,000',
      requestText: 'FROM_2001_3000',
    ),
    AccountItemModel(
      icon: '',
      name: 'More than \$3,000',
      requestText: 'MORE_THAN_3000',
    ),
  ];
}
