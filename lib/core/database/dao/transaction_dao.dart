import 'package:floor/floor.dart';

import '../entity/transaction_data.dart';

@dao
abstract class TransactionDao {
  @Query('SELECT * FROM TransactionData')
  Future<List<TransactionData>> getAllTransactions();

  @insert
  Future<int> insertTransaction(TransactionData transaction);
}
