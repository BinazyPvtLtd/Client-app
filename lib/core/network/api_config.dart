class ApiConfig {
  ApiConfig._();

  static const String baseUrl = 'https://api.patgolito.com/api/v1';

  static const String health = '/health';

  static const String sendOtp = '/auth/send-otp';
  static const String verifyOtp = '/auth/verify-otp';
  static const String logout = '/auth/logout';
  static const String me = '/auth/me';
  static const String vehicleTypes = '/vehicle-types';
  static const String profile = '/profile';
  static const String addresses = '/addresses';
  static const String quotes = '/quotes';
  static const String orders = '/orders';

  // =====================================================
// ADDRESS APIs
// =====================================================

// GET - List all saved addresses
// POST - Create new address
static const String getAddresses = '/addresses';
static const String createAddress = '/addresses';

// GET - Single address details
static String getAddressById(dynamic id) => '/addresses/$id';

// PATCH - Update existing address
static String updateAddress(dynamic id) => '/addresses/$id';

// DELETE - Delete address
static String deleteAddress(dynamic id) => '/addresses/$id';
}
