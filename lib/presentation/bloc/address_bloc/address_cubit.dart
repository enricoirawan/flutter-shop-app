import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/common/constant.dart';
import 'package:flutter_shop_app/core/state/view_state.dart';
import 'package:flutter_shop_app/core/use_case/use_case.dart';
import 'package:flutter_shop_app/domain/usecase/cache_get_user_address_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/get_user_address_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/get_user_position_usecase.dart';
import 'package:flutter_shop_app/domain/usecase/save_user_address_usecase.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final GetUserPositionUseCase getUserPositionUseCase;
  final SaveUserAddressUseCase saveUserAddressUseCase;
  final CacheGetUserAddressUseCase cacheGetUserAddressUseCase;
  final GetUserAddressUseCase getUserAddressUseCase;

  AddressCubit({
    required this.getUserPositionUseCase,
    required this.saveUserAddressUseCase,
    required this.cacheGetUserAddressUseCase,
    required this.getUserAddressUseCase,
  }) : super(AddressState(addressState: ViewData.initial()));

  void getUserPosition() async {
    emit(AddressState(addressState: ViewData.loading()));
    final result = await getUserPositionUseCase.call(const NoParams());

    result.fold(
      (error) {
        emit(
          AddressState(
            addressState: ViewData.error(
              message: error.message,
              failure: error,
            ),
          ),
        );
      },
      (result) async {
        final saveUserAddressResult = await saveUserAddressUseCase.call(result);

        saveUserAddressResult.fold((error) {
          emit(
            AddressState(
              addressState: ViewData.error(
                message: error.message,
                failure: error,
              ),
            ),
          );
        }, (result) async {
          final cacheGetUserAddressResult =
              await cacheGetUserAddressUseCase.call(
            const NoParams(),
          );

          cacheGetUserAddressResult.fold((error) {}, (result) {
            emit(
              AddressState(
                addressState: ViewData.loaded(
                  data: AppConstants.cachedKey.cacheGetUserAddressKey,
                ),
              ),
            );
          });
        });
      },
    );
  }

  void getUserAddress() async {
    emit(
      AddressState(addressState: ViewData.loading()),
    );
    final result = await getUserAddressUseCase.call(const NoParams());

    result.fold(
      (error) {
        emit(
          AddressState(
            addressState: ViewData.error(
              message: error.message,
              failure: error,
            ),
          ),
        );
      },
      (result) {
        emit(
          AddressState(
            addressState: ViewData.loaded(
              data: result,
            ),
          ),
        );
      },
    );
  }
}
