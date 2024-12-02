
sealed class SettingState {}

final class SettingInitial extends SettingState {}

final class GetBannersLoading extends SettingState{}
final class GetBannersSuccess extends SettingState{}
final class GetBannersFailed extends SettingState{}
final class GetBannersError extends SettingState{}
