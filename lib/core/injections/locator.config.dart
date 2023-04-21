// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i23;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i26;
import 'package:package_info_plus/package_info_plus.dart' as _i39;
import 'package:shared_preferences/shared_preferences.dart' as _i53;

import '../../app/auth/view_models/finger_print_view_model.dart' as _i65;
import '../../app/auth/view_models/login_view_model.dart' as _i30;
import '../../app/auth/view_models/mobile_number_view_model.dart' as _i32;
import '../../app/auth/view_models/otp_view_model.dart' as _i38;
import '../../app/auth/view_models/pin_code_view_model.dart' as _i45;
import '../../app/auth/view_models/select_country_view_model.dart' as _i50;
import '../../app/auth/view_models/signup_email_view_model.dart' as _i54;
import '../../app/currency_exchange/view_models/conversion_history_vm.dart'
    as _i13;
import '../../app/currency_exchange/view_models/create_conversion.dart' as _i16;
import '../../app/currency_exchange/view_models/main_currency_exchange_vm.dart'
    as _i17;
import '../../app/deposit_funds/view_models/card_transfer_view_model.dart'
    as _i11;
import '../../app/deposit_funds/view_models/mollie_view_model.dart' as _i34;
import '../../app/deposit_funds/view_models/payu_view_model.dart' as _i40;
import '../../app/deposit_funds/view_models/stitch_view_model.dart' as _i55;
import '../../app/deposit_funds/view_models/trustly_view_model.dart' as _i56;
import '../../app/devices/view_models/devices_vm.dart' as _i22;
import '../../app/home/pages/notifications/notifications_vm.dart' as _i37;
import '../../app/home/pages/profile_points/view_models/profile_points_vm.dart'
    as _i48;
import '../../app/home/view_models/account_transactions_view_model.dart' as _i4;
import '../../app/home/view_models/home_view_model.dart' as _i24;
import '../../app/KYC/view_models.dart/address_view_model.dart' as _i5;
import '../../app/KYC/view_models.dart/kyc_view_model.dart' as _i27;
import '../../app/landing_page_vm.dart' as _i29;
import '../../app/payout/beneficiaries/view_models/bank_recipient_vm.dart'
    as _i7;
import '../../app/payout/beneficiaries/view_models/borderless_recipient_vm.dart'
    as _i9;
import '../../app/payout/beneficiaries/view_models/mobile_recipient_vm.dart'
    as _i33;
import '../../app/payout/beneficiaries/view_models/select_mobile_network_vm.dart'
    as _i51;
import '../../app/payout/view_models/international_transfer_vm.dart' as _i25;
import '../../app/payout/view_models/payout_vm.dart' as _i42;
import '../../app/perks/view_models/perk_vm.dart' as _i44;
import '../../app/Profile/business_profile/view_models/business_profile_vm.dart'
    as _i10;
import '../../app/Profile/general/view_models/notification_settings_vm.dart'
    as _i36;
import '../../app/Profile/profile/delete_account_vm.dart' as _i19;
import '../../app/Profile/profile_page_vm.dart' as _i47;
import '../../app/shared_widgets/currency_selection_bottomsheet.dart' as _i18;
import '../../app/wallet/connect_bank_account/select_bank_vm.dart' as _i49;
import '../../app/wallet/create_individual_wallet/create_wallet_vm.dart'
    as _i14;
import '../../app/wallet/view_individual_wallet/details/individual_wallet_details_vm.dart'
    as _i57;
import '../../app/wallet/view_individual_wallet/transactions/transactions_widget_vm.dart'
    as _i60;
import '../../app/wallet/wallet_screen_vm.dart' as _i58;
import '../../data_sources/auth_data_source/auth_data_source.dart' as _i83;
import '../../data_sources/beneficiaries_data_source/beneficiaries_data_source.dart'
    as _i85;
import '../../data_sources/business_profile_data_source/business_profile_data_source.dart'
    as _i87;
import '../../data_sources/currency_exchange_data_source/currency_exchange_data_source.dart'
    as _i91;
import '../../data_sources/deposit_funds_data_source/deposit_funds_data_source.dart'
    as _i93;
import '../../data_sources/devices_data_source/devices_data_source.dart'
    as _i61;
import '../../data_sources/kyc_data_source/kyc_data_source.dart' as _i67;
import '../../data_sources/mobile_network_data_source/mobile_network_data_source.dart'
    as _i69;
import '../../data_sources/payout_data_source/payout_data_source.dart' as _i71;
import '../../data_sources/perks_data_source/perks_data_source.dart' as _i73;
import '../../data_sources/points_data_source/points_data_source.dart' as _i75;
import '../../data_sources/settings_data_source/settings_data_source.dart'
    as _i77;
import '../../data_sources/transactions_data_source/transactions_data_source.dart'
    as _i79;
import '../../data_sources/wallet_data_source/connect_bank_data_source.dart'
    as _i89;
import '../../data_sources/wallet_data_source/wallet_data_source.dart' as _i80;
import '../../repos/auth_repo/auth_repository.dart' as _i84;
import '../../repos/beneficiaries_repository.dart' as _i86;
import '../../repos/business_profile_repo.dart' as _i88;
import '../../repos/connect_bank_repository.dart' as _i90;
import '../../repos/currency_exchange_repository.dart' as _i92;
import '../../repos/deposit_funds_repository.dart' as _i94;
import '../../repos/devices_repository.dart' as _i63;
import '../../repos/kyc_repository.dart' as _i68;
import '../../repos/local_repo.dart' as _i64;
import '../../repos/mobile_network_repo.dart' as _i70;
import '../../repos/payout_repository.dart' as _i72;
import '../../repos/perks_repository.dart' as _i74;
import '../../repos/points_repository.dart' as _i76;
import '../../repos/settings_repository.dart' as _i78;
import '../../repos/transactions_repository.dart' as _i82;
import '../../repos/wallet_repository.dart' as _i81;
import '../../services/auth_services.dart' as _i6;
import '../../services/beneficiaries_services.dart' as _i8;
import '../../services/connect_bank_services.dart' as _i12;
import '../../services/currency_exchange_service.dart' as _i15;
import '../../services/deposit_funds_service.dart' as _i20;
import '../../services/devices_services.dart' as _i21;
import '../../services/kyc_service.dart' as _i28;
import '../../services/mobile_network_services.dart' as _i31;
import '../../services/payout_services.dart' as _i41;
import '../../services/perks_services.dart' as _i43;
import '../../services/points_services.dart' as _i46;
import '../../services/settings_services.dart' as _i52;
import '../../services/transactions_services.dart' as _i3;
import '../../services/wallet_services.dart' as _i59;
import '../network/http_requester.dart' as _i66;
import '../network/network_info.dart' as _i35;
import '../network/networks.dart' as _i62;
import 'register_module.dart' as _i95; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.AccountTransactionsService>(
      () => _i3.AccountTransactionsServiceImpl());
  gh.lazySingleton<_i4.AccountTransactionsViewModel>(
      () => _i4.AccountTransactionsViewModel());
  gh.lazySingleton<_i5.AddressViewModel>(() => _i5.AddressViewModel());
  gh.lazySingleton<_i6.AuthenticationService>(
      () => _i6.AuthenticationServiceImpl());
  gh.lazySingleton<_i7.BankRecipientVM>(() => _i7.BankRecipientVM());
  gh.lazySingleton<_i8.BeneficiariesService>(
      () => _i8.BeneficiariesServiceImpl());
  gh.lazySingleton<_i9.BorderLessRecipientVM>(
      () => _i9.BorderLessRecipientVM());
  gh.lazySingleton<_i10.BusinessProfileVM>(() => _i10.BusinessProfileVM());
  gh.lazySingleton<_i11.CardTransferViewModel>(
      () => _i11.CardTransferViewModel());
  gh.lazySingleton<_i12.ConnectBankService>(
      () => _i12.ConnectBankServiceImpl());
  gh.lazySingleton<_i13.ConversionHistoryVM>(() => _i13.ConversionHistoryVM());
  gh.lazySingleton<_i14.CreateWalletViewModel>(
      () => _i14.CreateWalletViewModel());
  gh.lazySingleton<_i15.CurrencyExchangeService>(
      () => _i15.CurrencyExchangeServiceImpl());
  gh.lazySingleton<_i16.CurrencyExchangeViewModel>(
      () => _i16.CurrencyExchangeViewModel());
  gh.lazySingleton<_i17.CurrencyExchangeViewModel>(
      () => _i17.CurrencyExchangeViewModel());
  gh.lazySingleton<_i18.CurrencySelectionViewModel>(
      () => _i18.CurrencySelectionViewModel());
  gh.lazySingleton<_i19.DeleteAccountVM>(() => _i19.DeleteAccountVM());
  gh.lazySingleton<_i20.DepositFundsService>(
      () => _i20.DepositFundsServiceImpl());
  gh.lazySingleton<_i21.DevicesServices>(() => _i21.DevicesServicesImpl());
  gh.lazySingleton<_i22.DevicesVM>(() => _i22.DevicesVM());
  gh.factory<_i23.Dio>(() => registerModule.dio);
  gh.lazySingleton<_i24.HomeViewModel>(() => _i24.HomeViewModel());
  gh.lazySingleton<_i25.InternationalTransferVM>(
      () => _i25.InternationalTransferVM());
  gh.factory<_i26.InternetConnectionChecker>(
      () => registerModule.internetConnectionChecker);
  gh.lazySingleton<_i27.KycViewModel>(() => _i27.KycViewModel());
  gh.lazySingleton<_i28.Kycservice>(() => _i28.KycserviceImpl());
  gh.lazySingleton<_i29.LandingPageVM>(() => _i29.LandingPageVM());
  gh.lazySingleton<_i30.LoginEmailViewModel>(() => _i30.LoginEmailViewModel());
  gh.lazySingleton<_i31.MobileNetworkServices>(
      () => _i31.MobileNetworkServicesImpl());
  gh.lazySingleton<_i32.MobileNumberViewModel>(
      () => _i32.MobileNumberViewModel());
  gh.lazySingleton<_i33.MobileRecipientVM>(() => _i33.MobileRecipientVM());
  gh.lazySingleton<_i34.MollieViewModel>(() => _i34.MollieViewModel());
  gh.lazySingleton<_i35.NetworkInfo>(
      () => _i35.NetworkInfoImpl(get<_i26.InternetConnectionChecker>()));
  gh.lazySingleton<_i36.NotificationSettingsVM>(
      () => _i36.NotificationSettingsVM());
  gh.lazySingleton<_i37.NotificationsVM>(() => _i37.NotificationsVM());
  gh.lazySingleton<_i38.OtpViewModel>(() => _i38.OtpViewModel());
  await gh.factoryAsync<_i39.PackageInfo>(() => registerModule.packageInfo,
      preResolve: true);
  gh.lazySingleton<_i40.PayUViewModel>(() => _i40.PayUViewModel());
  gh.lazySingleton<_i41.PayoutService>(() => _i41.PayoutServiceImpl());
  gh.lazySingleton<_i42.PayoutVM>(() => _i42.PayoutVM());
  gh.lazySingleton<_i43.PerksService>(() => _i43.PerksServiceImpl());
  gh.lazySingleton<_i44.PerksViewModel>(() => _i44.PerksViewModel());
  gh.lazySingleton<_i45.PinCodeViewModel>(() => _i45.PinCodeViewModel());
  gh.lazySingleton<_i46.PointsService>(() => _i46.PointsServiceImpl());
  gh.lazySingleton<_i47.ProfilePageVM>(() => _i47.ProfilePageVM());
  gh.lazySingleton<_i48.ProfilePointsVM>(() => _i48.ProfilePointsVM());
  gh.lazySingleton<_i49.SelectBankVM>(() => _i49.SelectBankVM());
  gh.lazySingleton<_i50.SelectCountryViewModel>(
      () => _i50.SelectCountryViewModel());
  gh.lazySingleton<_i51.SelectMobileNetworkVM>(
      () => _i51.SelectMobileNetworkVM());
  gh.lazySingleton<_i52.SettingsService>(() => _i52.SettingsServiceImpl());
  await gh.factoryAsync<_i53.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true);
  gh.lazySingleton<_i54.SignupEmailViewModel>(
      () => _i54.SignupEmailViewModel());
  gh.lazySingleton<_i55.StitchViewModel>(() => _i55.StitchViewModel());
  gh.lazySingleton<_i56.TrustlyViewModel>(() => _i56.TrustlyViewModel());
  gh.lazySingleton<_i57.WalletDetailsVM>(() => _i57.WalletDetailsVM());
  gh.lazySingleton<_i58.WalletScreenVM>(() => _i58.WalletScreenVM());
  gh.lazySingleton<_i59.WalletService>(() => _i59.WalletServiceImpl());
  gh.lazySingleton<_i60.WalletTransactionsVM>(
      () => _i60.WalletTransactionsVM());
  gh.lazySingleton<_i61.DevicesDataSource>(() => _i61.DevicesDataSourceImpl(
      networkInfo: get<_i62.NetworkInfo>(),
      dio: get<_i23.Dio>(),
      httpClient: get<_i62.HttpServiceRequester>()));
  gh.lazySingleton<_i63.DevicesRepository>(() => _i63.DevicesRepositoryImpl(
      devicesDataSource: get<_i61.DevicesDataSource>()));
  gh.lazySingleton<_i64.LocalBase>(
      () => _i64.LocalRepo(get<_i53.SharedPreferences>()));
  gh.lazySingleton<_i65.FingerPrintViewModel>(
      () => _i65.FingerPrintViewModel(get<_i64.LocalBase>()));
  gh.lazySingleton<_i66.HttpServiceRequester>(() => _i66.HttpServiceRequester(
      dio: get<_i23.Dio>(),
      networkInfo: get<_i35.NetworkInfo>(),
      localBase: get<_i64.LocalBase>()));
  gh.lazySingleton<_i67.KycDataSource>(() => _i67.KycDataSourceImpl(
      networkInfo: get<_i35.NetworkInfo>(),
      localDataStorage: get<_i64.LocalBase>(),
      dio: get<_i23.Dio>(),
      httpClient: get<_i66.HttpServiceRequester>()));
  gh.lazySingleton<_i68.KycRepository>(() =>
      _i68.KycRepositoryImpl(remoteDataSource: get<_i67.KycDataSource>()));
  gh.lazySingleton<_i69.MobileNetworkDataSource>(() =>
      _i69.MobileNetworkDataSourceImpl(get<_i35.NetworkInfo>(), get<_i23.Dio>(),
          get<_i66.HttpServiceRequester>()));
  gh.lazySingleton<_i70.MobileNetworkRepository>(() =>
      _i70.MobileNetworkRepositoryImpl(get<_i69.MobileNetworkDataSource>()));
  gh.lazySingleton<_i71.PayoutDataSource>(() => _i71.PayoutDataSourceImpl(
      networkInfo: get<_i35.NetworkInfo>(),
      localDataStorage: get<_i64.LocalBase>(),
      dio: get<_i23.Dio>(),
      httpClient: get<_i66.HttpServiceRequester>()));
  gh.lazySingleton<_i72.PayoutRepository>(() => _i72.PayoutRepositoryImpl(
      remoteDataSource: get<_i71.PayoutDataSource>()));
  gh.lazySingleton<_i73.PerksDataSource>(() => _i73.PerksDataSourceImpl(
      networkInfo: get<_i35.NetworkInfo>(),
      localDataStorage: get<_i64.LocalBase>(),
      dio: get<_i23.Dio>(),
      httpClient: get<_i66.HttpServiceRequester>()));
  gh.lazySingleton<_i74.PerksRepository>(() =>
      _i74.PerksRepositoryImpl(remoteDataSource: get<_i73.PerksDataSource>()));
  gh.lazySingleton<_i75.PointsDataSource>(() => _i75.PointsDataSourceImpl(
      networkInfo: get<_i35.NetworkInfo>(),
      localDataStorage: get<_i64.LocalBase>(),
      dio: get<_i23.Dio>(),
      httpClient: get<_i66.HttpServiceRequester>()));
  gh.lazySingleton<_i76.PointsRepository>(() => _i76.PointsRepositoryImpl(
      remoteDataSource: get<_i75.PointsDataSource>()));
  gh.lazySingleton<_i77.SettingsDataSource>(() => _i77.SettingsDataSourceImpl(
      networkInfo: get<_i35.NetworkInfo>(),
      localDataStorage: get<_i64.LocalBase>(),
      dio: get<_i23.Dio>(),
      httpClient: get<_i66.HttpServiceRequester>()));
  gh.lazySingleton<_i78.SettingsRepository>(() => _i78.SettingsRepositoryImpl(
      remoteDataSource: get<_i77.SettingsDataSource>()));
  gh.lazySingleton<_i79.TransactionsDataSource>(() =>
      _i79.TransactionsDataSourceImpl(
          networkInfo: get<_i35.NetworkInfo>(),
          localDataStorage: get<_i64.LocalBase>(),
          dio: get<_i23.Dio>(),
          httpClient: get<_i66.HttpServiceRequester>()));
  gh.lazySingleton<_i80.WalletDataSource>(() => _i80.WalletDataSourceImpl(
      networkInfo: get<_i35.NetworkInfo>(),
      localDataStorage: get<_i64.LocalBase>(),
      dio: get<_i23.Dio>(),
      httpClient: get<_i66.HttpServiceRequester>()));
  gh.lazySingleton<_i81.WalletRepository>(() => _i81.WalletRepositoryImpl(
      remoteDataSource: get<_i80.WalletDataSource>()));
  gh.lazySingleton<_i82.AccountTransactionsRepository>(() =>
      _i82.AccountTransactionsRepositoryImpl(
          remoteDataSource: get<_i79.TransactionsDataSource>()));
  gh.lazySingleton<_i83.AuthDataSourse>(() => _i83.AuthDataSourseImpl(
      networkInfo: get<_i35.NetworkInfo>(),
      localDataStorage: get<_i64.LocalBase>(),
      dio: get<_i23.Dio>(),
      httpClient: get<_i66.HttpServiceRequester>()));
  gh.lazySingleton<_i84.AuthRepository>(() =>
      _i84.AuthRepositoryImpl(remoteDataSource: get<_i83.AuthDataSourse>()));
  gh.lazySingleton<_i85.BeneficiariesDataSource>(() =>
      _i85.BeneficiariesDataSourceImpl(
          networkInfo: get<_i35.NetworkInfo>(),
          localDataStorage: get<_i64.LocalBase>(),
          dio: get<_i23.Dio>(),
          httpClient: get<_i66.HttpServiceRequester>()));
  gh.lazySingleton<_i86.BeneficiariesRepository>(() =>
      _i86.BeneficiariesRepositoryImpl(
          remoteDataSource: get<_i85.BeneficiariesDataSource>()));
  gh.lazySingleton<_i87.BusinessProfileDataSource>(() =>
      _i87.BusinessProfileDataSourceImpl(
          networkInfo: get<_i35.NetworkInfo>(),
          dio: get<_i23.Dio>(),
          httpClient: get<_i66.HttpServiceRequester>()));
  gh.lazySingleton<_i88.BusinessProfileRepository>(() =>
      _i88.BusinessProfileRepositoryImpl(
          remoteDataSource: get<_i87.BusinessProfileDataSource>()));
  gh.lazySingleton<_i89.ConnectBankDataSource>(() =>
      _i89.ConnectBankDataSourceImpl(
          networkInfo: get<_i35.NetworkInfo>(),
          localDataStorage: get<_i64.LocalBase>(),
          dio: get<_i23.Dio>(),
          httpClient: get<_i66.HttpServiceRequester>()));
  gh.lazySingleton<_i90.ConnectBankRepository>(() =>
      _i90.ConnectBankRepositoryImpl(
          remoteDataSource: get<_i89.ConnectBankDataSource>()));
  gh.lazySingleton<_i91.CurrencyExchangeDataSource>(() =>
      _i91.CurrencyExchangeDataSourceImpl(
          networkInfo: get<_i35.NetworkInfo>(),
          localDataStorage: get<_i64.LocalBase>(),
          dio: get<_i23.Dio>(),
          httpClient: get<_i66.HttpServiceRequester>()));
  gh.lazySingleton<_i92.CurrencyExchangeRepository>(() =>
      _i92.CurrencyExchangeRepositoryImpl(
          remoteDataSource: get<_i91.CurrencyExchangeDataSource>()));
  gh.lazySingleton<_i93.DepositFundsDataSource>(() =>
      _i93.DepositFundsDataSourceImpl(
          networkInfo: get<_i35.NetworkInfo>(),
          localDataStorage: get<_i64.LocalBase>(),
          dio: get<_i23.Dio>(),
          httpClient: get<_i66.HttpServiceRequester>()));
  gh.lazySingleton<_i94.DepositFundsRepository>(() =>
      _i94.DepositFundsRepositoryImpl(
          remoteDataSource: get<_i93.DepositFundsDataSource>()));
  return get;
}

class _$RegisterModule extends _i95.RegisterModule {}
