import 'package:dio/dio.dart';
import 'package:flutter_online_shop/common/http_response_validator.dart';
import 'package:flutter_online_shop/data/banner.dart';

abstract class IBannerDataSource {
  Future<List<BannerEntity>> getAll();
}

class BannerRemoteDataSource with HttpResponseValidator implements IBannerDataSource {
  final Dio httpClient;

  BannerRemoteDataSource(this.httpClient);
  @override
  Future<List<BannerEntity>> getAll() async {
    final response = await httpClient.get('banner/slider');
    validateResponse(response);
    final List<BannerEntity> banners = [];
    (response.data as List).forEach((jsonObject) {
      banners.add(BannerEntity.fromJson(jsonObject));
    });
    return banners;
  }
}
