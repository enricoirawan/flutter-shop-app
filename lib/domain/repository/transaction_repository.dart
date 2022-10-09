import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/common/failure.dart';

import '../../core/database/entity/transaction_data.dart';

abstract class TransactionRepository {
  Future<Either<Failure, List<TransactionData>>> getAllTransactions();
  Future<Either<Failure, bool>> insertTransaction(TransactionData transaction);
}
