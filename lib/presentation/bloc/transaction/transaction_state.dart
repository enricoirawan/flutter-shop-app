part of 'transaction_cubit.dart';

class TransactionState extends Equatable {
  final ViewData<List<TransactionData>> transactionState;

  const TransactionState({
    required this.transactionState,
  });

  @override
  List<Object> get props => [transactionState];
}
