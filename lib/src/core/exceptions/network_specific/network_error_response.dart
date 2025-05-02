// ignore_for_file: constant_identifier_names, non_constant_identifier_names
import '../_exceptions.dart';

/// A set of network exceptions for network response status code to be matched.
/// Does not include other app exceptions, and is constant.
const List<AppException> NET_RESPONSE_ERROR = [
  // * 4xx Client Errors
  BadRequestException(),
  UnauthorizedException(),
  ForbiddenException(),
  PaymentRequiredException(),
  NotFoundException(),
  MethodNotAllowedException(),
  NotAcceptableException(),
  ProxyAuthenticationRequiredException(),
  RequestTimeoutException(),
  ConflictException(),
  GoneException(),
  LengthRequiredException(),
  PreconditionFailedException(),
  PayloadTooLargeException(),
  UriTooLongException(),
  UnsupportedMediaTypeException(),
  RangeNotSatisfiableException(),
  ExpectationFailedException(),
  MisdirectedRequestException(),
  UnprocessableEntityException(),
  LockedException(),
  FailedDependencyException(),
  UpgradeRequiredException(),
  PreconditionRequiredException(),
  TooManyRequestsException(),
  RequestHeaderFieldsTooLargeException(),
  UnavailableForLegalReasonsException(),

  // * 5xx Server Errors
  InternalServerErrorException(),
  NotImplementedException(),
  BadGatewayException(),
  ServiceUnavailableException(),
  GatewayTimeoutException(),
  HttpVersionNotSupportedException(),
  VariantAlsoNegotiatesException(),
  InsufficientStorageException(),
  LoopDetectedException(),
  NotExtendedException(),
  NetworkAuthenticationRequiredException(),

  // * App-side (not server response, but still included as a countermeasure)
  NoConnectionException()
];
