part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class PhoneLoginLoading extends AuthState {}
class PhoneLoginSuccess extends AuthState {}
class PhoneLoginFailed extends AuthState {}
class PhoneLoginError extends AuthState {}

class PhoneSignUpLoading extends AuthState {}
class PhoneSignUpSuccess extends AuthState {}
class PhoneSignUpFailed extends AuthState {}
class PhoneSignUpError extends AuthState {}

class PhoneVerifyLoading extends AuthState {}
class PhoneVerifySuccess extends AuthState {}
class PhoneVerifyFailed extends AuthState {}
class PhoneVerifyError extends AuthState {}

class ResendOTPLoading extends AuthState {}
class ResendOTPSuccess extends AuthState {}
class ResendOTPFailed extends AuthState {}
class ResendOTPError extends AuthState {}
