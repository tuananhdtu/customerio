
import 'dart:convert';

import 'package:customerio/customer_io_model.dart';

import 'customerio_platform_interface.dart';

class Customerio {
  Future<String?> initCustomerIO(String apiKey, String siteId) {
    var customerIo = CustomerIOModel(apiKey: apiKey,siteId: siteId);
    return CustomerioPlatform.instance.initCustomerIO(jsonEncode(customerIo));
  }

  Future<String?> setIdentifier(String identifier) {
    return CustomerioPlatform.instance.setIdentifier(identifier);
  }
}
