import 'package:flutter_online_shop/common/http_client.dart';
import 'package:flutter_online_shop/data/banner.dart';
import 'package:flutter_online_shop/data/repo/product_repository.dart';
import 'package:flutter_online_shop/data/source/banner_data_source.dart';

final bannerRepository = BannerRepository(BannerRemoteDataSource(httpClient));

abstract class IBannerRepository {
  Future<List<BannerEntity>> getAll();
}

class BannerRepository implements IBannerRepository {
  final IBannerDataSource dataSource;

  BannerRepository(this.dataSource);

  @override
  Future<List<BannerEntity>> getAll() => dataSource.getAll();
}
