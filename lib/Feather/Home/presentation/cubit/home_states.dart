
sealed class HomeState{}

final class HomeInitial extends HomeState {}

class GetCategoriesLoading extends HomeState{}
class GetCategoriesSuccess extends HomeState{}
class GetCategoriesFailed extends HomeState{}
class GetCategoriesError extends HomeState{}