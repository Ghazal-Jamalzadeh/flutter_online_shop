import 'package:flutter/cupertino.dart';
import 'package:flutter_online_shop/common/http_client.dart';
import 'package:flutter_online_shop/data/auth_info.dart';
import 'package:flutter_online_shop/data/source/auth_data_source.dart';


final authRepository = AuthRepository(AuthRemoteDataSource(httpClient));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> signUp(String username, String password);
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSource dataSource;

  AuthRepository(this.dataSource);
  @override
  Future<void> login(String username, String password) async {
    final AuthInfo authInfo = await dataSource.login(username, password);
    debugPrint("access token is: " + authInfo.accessToken);
  }

  @override
  Future<void> signUp(String username, String password) async {
    try {
      final AuthInfo authInfo = await dataSource.signUp(username, password);
      debugPrint("access token is: " + authInfo.accessToken);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
