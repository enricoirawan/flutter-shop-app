import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/core/database/entity/transaction_data.dart';
import 'package:flutter_shop_app/core/state/view_state.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';
import 'package:flutter_shop_app/domain/usecase/clear_cart_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/get_all_transactions_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/insert_transaction_usecase.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final InsertTransactionUseCase insertTransactionUseCase;
  final GetAllTransactionsUseCase getAllTransactionsUseCase;
  final ClearCartUseCase clearCartUseCase;

  TransactionCubit({
    required this.insertTransactionUseCase,
    required this.getAllTransactionsUseCase,
    required this.clearCartUseCase,
  }) : super(TransactionState(transactionState: ViewData.initial()));

  void getAllTransactions() async {
    emit(TransactionState(transactionState: ViewData.loaded()));

    final result = await getAllTransactionsUseCase.call(const NoParams());

    result.fold(
      (error) {
        emit(
          TransactionState(
            transactionState: ViewData.error(
              message: error.message,
              failure: error,
            ),
          ),
        );
      },
      (result) {
        if (result.isEmpty) {
          emit(
            TransactionState(
              transactionState: ViewData.noData(
                message: "Transaction not found, try to add one!",
              ),
            ),
          );
        } else {
          emit(
            TransactionState(transactionState: ViewData.loaded(data: result)),
          );
        }
      },
    );
  }

  void insertTransaction(TransactionData transaction) async {
    final result = await insertTransactionUseCase.call(transaction);

    result.fold(
      (error) {
        emit(
          TransactionState(
            transactionState: ViewData.error(
              message: error.message,
              failure: error,
            ),
          ),
        );
      },
      (result) async {
        final deleteCartStatus = await clearCartUseCase.call(const NoParams());

        deleteCartStatus.fold((error) {
          emit(
            TransactionState(
              transactionState: ViewData.error(
                message: error.message,
                failure: error,
              ),
            ),
          );
        }, (result) {
          emit(
            TransactionState(
              transactionState: ViewData.loaded(),
            ),
          );
        });
      },
    );
  }
}
