part of 'connecty_bloc.dart';

abstract class ConnectyEvent extends Equatable {
  const ConnectyEvent();

  @override
  List<Object> get props => [];
}

class ConnectyPermissionEvent extends ConnectyEvent{

   final bool isConnectyEnable;

  const ConnectyPermissionEvent({
    required this.isConnectyEnable,
    });
    
}
