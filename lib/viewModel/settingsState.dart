import 'package:flutter/material.dart';

abstract class SettingsState {
  const SettingsState();
}

class SettingsInitial extends SettingsState {

}

class SettingsLoaded extends SettingsState {
  final ThemeData theme;

  SettingsLoaded(this.theme);
}