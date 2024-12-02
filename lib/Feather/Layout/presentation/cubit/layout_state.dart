part of 'layout_cubit.dart';

@immutable
sealed class LayoutState {}

final class LayoutInitial extends LayoutState {}

final class ChangePageState extends LayoutState {}

final class ShowBottomSheetState extends LayoutState {}
final class CloseBottomSheetState extends LayoutState {}
