import 'package:flutter_shop_app/core/database/entity/transaction_data.dart';
import 'package:sqflite/sqflite.dart';

import '../../../common/constant.dart';
import '../../../common/failure.dart';
import '../../../core/database/database.dart';

abstract class TransactionLocalDataSources {
  Future<List<TransactionData>> getAllTransactions();
  Future<bool> insertTransaction(TransactionData transaction);
}

class TransactionLocalDataSourcesImpl implements TransactionLocalDataSources {
  final AppDatabase appDatabase;

  TransactionLocalDataSourcesImpl({
    required this.appDatabase,
  });

  @override
  Future<List<TransactionData>> getAllTransactions() async {
    try {
      final result = await appDatabase.transactionDao.getAllTransactions();
      return result;
    } on DatabaseException catch (_) {
      throw DatabaseFailure(AppConstants.errorMessage.failedGetCarts);
    }
  }

  @override
  Future<bool> insertTransaction(TransactionData transaction) async {
    try {
      final result =
          await appDatabase.transactionDao.insertTransaction(transaction);
      return result > 0 ? true : false;
    } on DatabaseException catch (_) {
      throw DatabaseFailure(AppConstants.errorMessage.failedInsertTransaction);
    }
  }
}
