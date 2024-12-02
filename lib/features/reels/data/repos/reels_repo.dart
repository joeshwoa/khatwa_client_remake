import 'package:dartz/dartz.dart';

import '../../../../old_core/errors/failuresreels.dart';
import '../models/reels_model.dart';
import '../models/watched_model.dart';

abstract class ReelsRepo {
  Future<Either<Failure, List<ReelsModel>>> fetchReels();
  Future removeReels(
      {required String videoId});
}
