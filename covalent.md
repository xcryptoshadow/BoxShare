
## Covalent : [click here to see the code}(https://github.com/xcryptoshadow/BoxShare/blob/d648d8d3d93096a474fdeb03db66490450f0ed77/lib/services/covalenthq_service.dart)



```
 import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO use interface to decouple dio package

// COVALENT API
final covalentDioProvider = Provider<Dio>((ref) {
  const key = String.fromEnvironment('COVALENT_API_KEY');

  return Dio(
    BaseOptions(
      baseUrl: "https://api.covalenthq.com/v1/",
      queryParameters: {"key": key},
    ),
  )..interceptors.add(
      LogInterceptor(
        requestHeader: false,
        // responseHeader: false,
      ),
    );
});

// Blockdaemon API
final blockdaemonDioProvider = Provider<Dio>((ref) {
  const key = String.fromEnvironment('BLOCKDAEMON_API_KEY');
  return Dio(
    BaseOptions(
      baseUrl: "https://ubiquity.api.blockdaemon.com/v1/",
      headers: {
        HttpHeaders.authorizationHeader: key,
      },
    ),
  )..interceptors.add(
      LogInterceptor(
        requestHeader: false,
        // responseHeader: false,
      ),
    );
});
```


