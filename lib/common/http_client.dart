import 'package:dio/dio.dart';
import 'package:flutter_online_shop/data/repo/auth_repository.dart';

/*
* در زبان دارت .. یعنی میخوام روی این dio یک فانکشن دیگه صدا بزنم
* زمانی که instance dio برمیگرده روی اون instance یک فانکشن دیگه کال میکنم
*
* interceptors:
* کانسپتیه که به تغییراتی که روی http request اعمال میکنیم اطلاق میشه
*
* onRequest :
* زمانی که میخوایم قبل ارسال ریکوعست یک تغییری روی http request خودتون بدید از این فیلد استفاده میکنید
*
* onResponse :
* زمانی که میخواید وقتی response برگشت یک تغییری روی ریسپانس بدید از این فیلد استفاده میکنید
*
* onError :
* احتمالا برای تغییر دادن ارورهاست
*
* این onRequest یک متد میده بمون
*
* پارامتر اول options هست
* هر ریکوعستی یک سری تنظیمات داره که توی این options بهشون دسترسی داریم
* مثلا به فیلد headers دسترسی داریم
*
* پارامتر دوم handler هست
* اینجوریه که میگی اوکی من تغییراتمو دادم حالا میتونی بقیه کارهای خودتو انجام بدی
*
*
* */


final httpClient =
Dio(BaseOptions(baseUrl: 'http://expertdevelopers.ir/api/v1/'))
  ..interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      final authInfo = AuthRepository.authChangeNotifier.value;
      if (authInfo != null && authInfo.accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer ${authInfo.accessToken}';
      }

      handler.next(options);
    },
  ));
