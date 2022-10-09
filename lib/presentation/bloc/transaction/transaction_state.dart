part of 'transaction_cubit.dart';

class TransactionState extends Equatable {
  final ViewData<List<TransactionData>> transactionState;

  const TransactionState({
    required this.transactionState,
  });

  TransactionState copyWith({
    ViewData<List<TransactionData>>? transactionState,
  }) {
    return TransactionState(
      transactionState: transactionState ?? this.transactionState,
    );
  }

  @override
  List<Object> get props => [transactionState];
}
