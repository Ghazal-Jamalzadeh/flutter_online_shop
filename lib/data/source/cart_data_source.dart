import 'package:dio/dio.dart';
import 'package:flutter_online_shop/data/cart_item.dart';
import 'package:flutter_online_shop/data/cart_response.dart';

abstract class ICartDataSource{
  Future<CartResponse> add(int productId);
  Future<CartResponse> changeCount(int cartItemId,int count);
  Future<void> delete(int cartItemId);
  Future<int> count();
  Future<List<CartItemEntity>> getAll();
}

class CartRemoteDataSource implements ICartDataSource{
  final Dio httpClient;

  CartRemoteDataSource(this.httpClient);

  @override
  Future<CartResponse> add(int productId) async{
    final response=await httpClient.post('cart/add',data: {
        "product_id":productId
    });

    return CartResponse.fromJson(response.data);
  }

  @override
  Future<CartResponse> changeCount(int cartItemId, int count) {
    // TODO: implement changeCount
    throw UnimplementedError();
  }

  @override
  Future<int> count() {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int cartItemId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<CartItemEntity>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }


}