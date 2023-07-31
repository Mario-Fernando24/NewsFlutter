part of 'connecty_bloc.dart';



 class ConnectyState extends Equatable {
  
  final bool isConnectyEnable;

  bool get isAllGranted => isConnectyEnable==true;

  const ConnectyState({
   required this.isConnectyEnable,
  });

  ConnectyState copyWith({
    bool? isConnectyEnable,
  }) => ConnectyState(
    isConnectyEnable: isConnectyEnable ?? this.isConnectyEnable,
   );
  
  
  @override
  List<Object> get props => [
  ];

  @override
  String toString() => '{isConnectyEnable : $isConnectyEnable}';
}

