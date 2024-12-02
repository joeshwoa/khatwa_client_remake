
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}


final class GetClientProfileLoading extends ProfileState{}
final class GetClientProfileSuccess extends ProfileState{}
final class GetClientProfileFailed extends ProfileState{}
final class GetClientProfileError extends ProfileState{}

final class UpdateProfileAvatarLoading extends ProfileState{}
final class UpdateProfileAvatarSuccess extends ProfileState{}
final class UpdateProfileAvatarFailed extends ProfileState{}
final class UpdateProfileAvatarError extends ProfileState{}

final class UpdateProfileNameLoading extends ProfileState{}
final class UpdateProfileNameSuccess extends ProfileState{}
final class UpdateProfileNameFailed extends ProfileState{}
final class UpdateProfileNameError extends ProfileState{}

final class UpdateProfilePhoneLoading extends ProfileState{}
final class UpdateProfilePhoneSuccess extends ProfileState{}
final class UpdateProfilePhoneFailed extends ProfileState{}
final class UpdateProfilePhoneError extends ProfileState{}


