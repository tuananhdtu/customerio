import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'customerio_method_channel.dart';

abstract class CustomerioPlatform extends PlatformInterface {
  /// Constructs a CustomerioPlatform.
  CustomerioPlatform() : super(token: _token);

  static final Object _token = Object();

  static CustomerioPlatform _instance = MethodChannelCustomerio();

  /// The default instance of [CustomerioPlatform] to use.
  ///
  /// Defaults to [MethodChannelCustomerio].
  static CustomerioPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CustomerioPlatform] when
  /// they register themselves.
  static set instance(CustomerioPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> initCustomerIO(String jsonEncode) {
    throw UnimplementedError('initCustomerIO() has not been implemented.');
  }

  Future<String?> setIdentifier(String identifier) {
    throw UnimplementedError('setIdentifier() has not been implemented.');
  }
}
