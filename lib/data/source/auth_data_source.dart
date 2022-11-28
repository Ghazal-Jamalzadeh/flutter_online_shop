import 'package:dio/dio.dart';
import 'package:flutter_online_shop/common/constants.dart';
import 'package:flutter_online_shop/common/http_response_validator.dart';
import 'package:flutter_online_shop/data/auth_info.dart';

abstract class IAuthDataSource {
  Future<AuthInfo> login(String username, String password);
  Future<AuthInfo> register(String username, String password);
  Future<AuthInfo> refreshToken(String token);
}

class AuthRemoteDataSource
    with HttpResponseValidator
    implements IAuthDataSource {
  final Dio httpClient;

  AuthRemoteDataSource(this.httpClient);
  @override
  Future<AuthInfo> login(String username, String password) async {
    /* ارسال اطلاعات از طریق جیسون آبجکت */
    final response = await httpClient.post("auth/token", data: {
      "grant_type": "password",
      "client_id": 2,
      "client_secret": Constants.clientSecret,
      "username": username,
      "password": password
    });

    validateResponse(response);

    return AuthInfo(
        response.data["access_token"], response.data["refresh_token"]);
  }

  @override
  Future<AuthInfo> refreshToken(String token) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<AuthInfo> register(String username, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }
}

/*
{
"token_type": "Bearer",
"expires_in": 31536000,
"access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjZlYzExNWY4YjAzMTY0NjU2NGM3ZDAxMTE3NGRiZmZmYjYyMDA2OWY1MDY0MGFiMmNjZGU5MjI3MTU0YmZiMDFhMzAxOWZkMDUyMTM5ZTA0In0.eyJhdWQiOiIyIiwianRpIjoiNmVjMTE1ZjhiMDMxNjQ2NTY0YzdkMDExMTc0ZGJmZmZiNjIwMDY5ZjUwNjQwYWIyY2NkZTkyMjcxNTRiZmIwMWEzMDE5ZmQwNTIxMzllMDQiLCJpYXQiOjE2Njk2MTY1NzgsIm5iZiI6MTY2OTYxNjU3OCwiZXhwIjoxNzAxMTUyNTc4LCJzdWIiOiIxNyIsInNjb3BlcyI6W119.T1OnjJeDGk9TRVAnRcJLn6-NsmUg2tqfCfW6QFzhElqkDOHzHHwVNb-1JAwGLmPPP9ax5jLqWQH6DAYzqjaP1JBlg1TPIodrVvUaUbdFoeMfc_zG-3phkfreWLycWrAbEE5GTBgejO3KnQsnVsOeIVwlV_fRMlIxY9VFW49bgJIj5q2cpaqovKAZC9yEKDcvjp5X1YO4RiPW7Zjjk92NQqjooYDjq5RZzbR6K5hI8fRjs0iYfQFb5TN103GOUcRaU9LG0UXTe-5hEsqTi10zqDOSN5AA0YxIOWz3htdsxZff8KzD9l8ExD4sMpkfgbgoeZG6WiGca25r6GykQmJXNC4ueGaRYHRB_IuXJxwI-BvFuNTmMjcANSZUX8IK_6G7wkOcCLrnUnfGF2WuNzkdPuXpvQVQNtKsvGI8WlzX1QrmTEt6S2FOKvhPXojQHQmpf8ix0U61u69-hiiHDEYZPPUZEbxH4tDQisnb1r_42BtapiVppvU3iGrEWy3RDt0mMkoZcFjXJZx5dNXFVgIO8bFVnZTIxs0gZO5DPqki2yTl5AtMLYTAlJfsOxSeaJjB5acR_9gTqeLXvkPUGe-qY0e5ndCkVGcWxhhb_XxyCrQqGKp7nOC7Eqlyg23tdgAGH_sih1Jt_TMN8PGiXaCzmcyG5ZimkAIn72BtoX06kPU",
"refresh_token": "def502007a7639b3caf6b3f1a3db77cb17d96db9933591105dc1ec511501c3a2c256acd283ba0ae551f8cd3ca36772012c8dc6c27d5c6053a4c43657b21308a47334925bada126dc827f2b4172c051778ad89a01ed76d930268c0f46010dd474d6bc31656c115eb0d74299d2b3deb74829c78e8f451cefa181239b1b615549b89232b5bc577b671a194e8afca0d7752989177d8259783e7f66ce8f0b09d8308477a23212589ec82201cc965347a79f58b20a54bc1fb45c2bd813da30a8737d87b0f41e2780b064394e15d3a4e315d6d0675e8ff4897edf2c74759c79c6558c06da8b2087fddffb7b7165833db1ed6d07cd08f5e6b87fc6c8ae9edb858e435ac3dbe2a061bcd3393d3cce41d0b6022c990079d2e88b844353d3b766af366bd203cd1e699594b402bb09686950fe432fe3fd6ca7cdca0f2363ff5a7677581f25bc2f519be2daf747b04ad8d897ebc47776f2300c48df51e5c1a339320b0469256095ce"
}
*/
