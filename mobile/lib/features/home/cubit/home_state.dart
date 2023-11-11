import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class HomeState extends Equatable {
  final StatusHome statusHome;
  final int indexCurrentContentHome;
  final String titleContentCurrentWidget;
  final Widget contentCurrentWidget;

  const HomeState(
      {required this.statusHome,
      this.titleContentCurrentWidget = 'Vagas',
      this.indexCurrentContentHome = 0,
      this.contentCurrentWidget = const SizedBox.shrink()});
  @override
  List<Object?> get props => [
        statusHome,
        indexCurrentContentHome,
        contentCurrentWidget,
        titleContentCurrentWidget,
      ];

  HomeState copyWith({
    StatusHome? statusHome,
    int? indexCurrentContentHome,
    Widget? contentCurrentWidget,
    String? titleContentCurrentWidget,
    int? countToExit,
  }) {
    return HomeState(
      statusHome: statusHome ?? this.statusHome,
      indexCurrentContentHome:
          indexCurrentContentHome ?? this.indexCurrentContentHome,
      contentCurrentWidget: contentCurrentWidget ?? this.contentCurrentWidget,
      titleContentCurrentWidget:
          titleContentCurrentWidget ?? this.titleContentCurrentWidget,
    );
  }
}

enum StatusHome {
  initial,
  loadingList,
}
