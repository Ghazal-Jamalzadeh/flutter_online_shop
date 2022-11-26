import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_online_shop/common/exceptions.dart';
import 'package:flutter_online_shop/data/banner.dart';
import 'package:flutter_online_shop/data/product.dart';
import 'package:flutter_online_shop/data/repo/banner_repository.dart';
import 'package:flutter_online_shop/data/repo/product_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository bannerRepository;
  final IProductRepository productRepository;
  HomeBloc({required this.bannerRepository, required this.productRepository})
      : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted || event is HomeRefresh) {
        try {
          emit(HomeLoading());
          final banners = await bannerRepository.getAll();
          final latestProducts =
          await productRepository.getAll(ProductSort.latest);
          final popularProducts =
          await productRepository.getAll(ProductSort.popular);
          /* وقتی به این نقطه برسیم یعنی همه api ها call شده و ریسپانسش هم اومده */
          emit(HomeSuccess(
              banners: banners,
              latestProducts: latestProducts,
              popularProducts: popularProducts));
        } catch (e) {
        /*اگه اروری که رخ داده از نوع http error بود که همونو نشون میدیم در غیر این صورت خودمون یکی پیش فرض میسازیم*/
          emit(HomeError(exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
