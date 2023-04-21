import 'package:dartz/dartz.dart';
import 'package:geniuspay/core/errors/errors.dart';
import 'package:geniuspay/core/injections/locator.dart';
import 'package:geniuspay/repos/points_repository.dart';
import 'package:injectable/injectable.dart';

abstract class PointsService {
  Future<Either<Failure, String>> getPoints();
}

@LazySingleton(as: PointsService)
class PointsServiceImpl extends PointsService {
  final PointsRepository _pointsRepository = sl<PointsRepository>();

  @override
  Future<Either<Failure, String>> getPoints() async {
    return _pointsRepository.getPoints();
  }
}
