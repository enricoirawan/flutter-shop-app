import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_app/common/navigation/router/profile_route.dart';
import 'package:flutter_shop_app/core/state/view_state.dart';
import 'package:flutter_shop_app/presentation/bloc/transaction_bloc/transaction_cubit.dart';

import '../../common/get_it.dart';

class HistoryTransactionScreen extends StatelessWidget {
  const HistoryTransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileRouter profileRouter = sl();

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      profileRouter.goBack();
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  Text(
                    "History Transactions",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            BlocBuilder<TransactionCubit, TransactionState>(
              builder: (context, state) {
                final status = state.transactionState.status;

                if (status.isLoading) {
                  return const CircularProgressIndicator();
                } else if (status.isHasData) {
                  final transactions = state.transactionState.data ?? [];
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final transaction = transactions[index];

                        return Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 10.h,
                          ),
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    transaction.id,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    transaction.purcashedProductTitle,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    "\$${transaction.total}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: transactions.length,
                    ),
                  );
                } else if (status.isNoData) {
                  return Center(
                    child: Text(state.transactionState.message),
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
