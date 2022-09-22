import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'customerio_platform_interface.dart';

/// An implementation of [CustomerioPlatform] that uses method channels.
class MethodChannelCustomerio extends CustomerioPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('customerio');

  @override
  Future<String?> initCustomerIO(String jsonEncode) async {
    final version = await methodChannel.invokeMethod<String>('initCustomerIO',jsonEncode);
    return version;
  }

  @override
  Future<String?> setIdentifier(String identifier) async {
    final version = await methodChannel.invokeMethod<String>('setIdentifier',identifier);
    return version;
  }

}
