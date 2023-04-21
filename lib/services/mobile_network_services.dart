import 'package:dartz/dartz.dart';
import 'package:geniuspay/core/errors/errors.dart';
import 'package:geniuspay/core/injections/injections.dart';
import 'package:geniuspay/models/mobile_network.dart';
import 'package:geniuspay/repos/mobile_network_repo.dart';
import 'package:injectable/injectable.dart';

abstract class MobileNetworkServices {
  Future<Either<Failure, MobileNetworkList>> fetchMobileNetworks();
}

@LazySingleton(as: MobileNetworkServices)
class MobileNetworkServicesImpl extends MobileNetworkServices {
  final MobileNetworkRepository _mobileNetworkRepository =
      sl<MobileNetworkRepository>();

  @override
  Future<Either<Failure, MobileNetworkList>> fetchMobileNetworks() {
    return _mobileNetworkRepository.fetchMobileNetworks();
  }
}
