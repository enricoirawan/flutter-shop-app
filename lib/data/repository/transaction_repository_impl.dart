import 'package:flutter_shop_app/core/database/entity/transaction_data.dart';
import 'package:flutter_shop_app/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/data/datasource/local/transaction_local_datasources.dart';
import 'package:flutter_shop_app/domain/repository/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDataSources transactionLocalDataSources;

  TransactionRepositoryImpl({
    required this.transactionLocalDataSources,
  });

  @override
  Future<Either<Failure, List<TransactionData>>> getAllTransactions() async {
    try {
      final result = await transactionLocalDataSources.getAllTransactions();
      return Right(result);
    } on DatabaseFailure catch (error) {
      return Left(DatabaseFailure(error.message));
    } on Exception catch (error) {
      return Left(DatabaseFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> insertTransaction(
      TransactionData transaction) async {
    try {
      final result =
          await transactionLocalDataSources.insertTransaction(transaction);
      return Right(result);
    } on DatabaseFailure catch (error) {
      return Left(DatabaseFailure(error.message));
    } on Exception catch (error) {
      return Left(DatabaseFailure(error.toString()));
    }
  }
}
