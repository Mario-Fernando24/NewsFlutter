part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}


class FilterNewCountryEvent extends NewsEvent {
  final String filterNewCountry;

  FilterNewCountryEvent(this.filterNewCountry);

  @override
  List<Object?> get prop => [filterNewCountry];
}
