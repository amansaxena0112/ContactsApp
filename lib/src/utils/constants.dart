class Constants {
  static final Constants _constants = Constants._();
  factory Constants() => _constants;
  Constants._();

  static const int PORT = 8080;
  static const PROTOCOL_PROD = 'http';
  static const String HOST_PROD = '167.172.6.138';

  static const String CONTACTS = "/contacts";
}
