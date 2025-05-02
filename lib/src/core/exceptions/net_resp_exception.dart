// coverage:ignore-file
part of 'app_exception.dart';

class BadRequestException extends AppException {
  const BadRequestException() : super(400, 'bad_request_error');
}

class UnauthorizedException extends AppException {
  const UnauthorizedException() : super(401, 'unauthorized_error');
}

class PaymentRequiredException extends AppException {
  const PaymentRequiredException() : super(402, 'payment_required_error');
}

class ForbiddenException extends AppException {
  const ForbiddenException() : super(403, 'forbidden_error');
}

class NotFoundException extends AppException {
  const NotFoundException() : super(404, 'not_found_error');
}

class MethodNotAllowedException extends AppException {
  const MethodNotAllowedException() : super(405, 'method_not_allowed_error');
}

class NotAcceptableException extends AppException {
  const NotAcceptableException() : super(406, 'not_acceptable_error');
}

class ProxyAuthenticationRequiredException extends AppException {
  const ProxyAuthenticationRequiredException() : super(407, 'proxy_authentication_required_error');
}

class RequestTimeoutException extends AppException {
  const RequestTimeoutException() : super(408, 'request_timeout_error');
}

class ConflictException extends AppException {
  const ConflictException() : super(409, 'conflict_error');
}

class GoneException extends AppException {
  const GoneException() : super(410, 'gone_error');
}

class LengthRequiredException extends AppException {
  const LengthRequiredException() : super(411, 'length_required_error');
}

class PreconditionFailedException extends AppException {
  const PreconditionFailedException() : super(412, 'precondition_failed_error');
}

class PayloadTooLargeException extends AppException {
  const PayloadTooLargeException() : super(413, 'payload_too_large_error');
}

class UriTooLongException extends AppException {
  const UriTooLongException() : super(414, 'uri_too_long_error');
}

class UnsupportedMediaTypeException extends AppException {
  const UnsupportedMediaTypeException() : super(415, 'unsupported_media_type_error');
}

class RangeNotSatisfiableException extends AppException {
  const RangeNotSatisfiableException() : super(416, 'range_not_satisfiable_error');
}

class ExpectationFailedException extends AppException {
  const ExpectationFailedException() : super(417, 'expectation_failed_error');
}

class MisdirectedRequestException extends AppException {
  const MisdirectedRequestException() : super(421, 'misdirected_request_error');
}

class UnprocessableEntityException extends AppException {
  const UnprocessableEntityException() : super(422, 'unprocessable_entity_error');
}

class LockedException extends AppException {
  const LockedException() : super(423, 'locked_error');
}

class FailedDependencyException extends AppException {
  const FailedDependencyException() : super(424, 'failed_dependency_error');
}

class UpgradeRequiredException extends AppException {
  const UpgradeRequiredException() : super(426, 'upgrade_required_error');
}

class PreconditionRequiredException extends AppException {
  const PreconditionRequiredException() : super(428, 'precondition_required_error');
}

class TooManyRequestsException extends AppException {
  const TooManyRequestsException() : super(429, 'too_many_requests_error');
}

class RequestHeaderFieldsTooLargeException extends AppException {
  const RequestHeaderFieldsTooLargeException() : super(431, 'request_header_fields_too_large_error');
}

class UnavailableForLegalReasonsException extends AppException {
  const UnavailableForLegalReasonsException() : super(451, 'unavailable_for_legal_reasons_error');
}

class InternalServerErrorException extends AppException {
  const InternalServerErrorException() : super(500, 'internal_server_error');
}

class NotImplementedException extends AppException {
  const NotImplementedException() : super(501, 'not_implemented_error');
}

class BadGatewayException extends AppException {
  const BadGatewayException() : super(502, 'bad_gateway_error');
}

class ServiceUnavailableException extends AppException {
  const ServiceUnavailableException() : super(503, 'service_unavailable_error');
}

class GatewayTimeoutException extends AppException {
  const GatewayTimeoutException() : super(504, 'gateway_timeout_error');
}

class HttpVersionNotSupportedException extends AppException {
  const HttpVersionNotSupportedException() : super(505, 'http_version_not_supported_error');
}

class VariantAlsoNegotiatesException extends AppException {
  const VariantAlsoNegotiatesException() : super(506, 'variant_also_negotiates_error');
}

class InsufficientStorageException extends AppException {
  const InsufficientStorageException() : super(507, 'insufficient_storage_error');
}

class LoopDetectedException extends AppException {
  const LoopDetectedException() : super(508, 'loop_detected_error');
}

class NotExtendedException extends AppException {
  const NotExtendedException() : super(510, 'not_extended_error');
}

class NetworkAuthenticationRequiredException extends AppException {
  const NetworkAuthenticationRequiredException() : super(511, 'network_authentication_required_error');
}
