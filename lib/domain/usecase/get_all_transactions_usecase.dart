import 'package:flutter_shop_app/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_shop_app/core/database/entity/transaction_data.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';
import 'package:flutter_shop_app/domain/repository/transaction_repository.dart';

class GetAllTransactionsUseCase
    extends UseCase<List<TransactionData>, NoParams> {
  final TransactionRepository transactionRepository;

  GetAllTransactionsUseCase({required this.transactionRepository});

  @override
  Future<Either<Failure, List<TransactionData>>> call(NoParams params) {
    return transactionRepository.getAllTransactions();
  }
}
