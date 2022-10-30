import 'package:flutter/material.dart';
import 'dart:async';

class CoalAmount extends ValueNotifier<int> {
  CoalAmount() : super(0);
  String toString() => "$value pcs Coal";
}

class AutoMiner extends ValueNotifier<int> {
  AutoMiner() : super(0);
  String toString() => "Auto-miner: generates $value pcs Coal per second";

  void autoMine(CoalAmount coal) {
    coal.value += value;
  }
}

class Mine extends ValueNotifier<int> {
  int get autoMineLevel => autoMiner.value;

  Mine(this.coal, this.autoMiner) : super(1) {
    Timer.periodic(Duration(seconds: 1), autoMine);
  }
  String toString() => "Level $level Mine with $coal";

  void autoMine(Timer timer) {
    autoMiner.autoMine(coal);
  }

  int get level {
    return value;
  }

  final CoalAmount coal;
  final AutoMiner autoMiner;
  void mine() {
    coal.value += level;
  }

  int get upgradeMDCost => value * 2;

  bool get canUpgradeMD => coal.value > upgradeMDCost - 1;

  void upgradeAllMD() {
    while (upgradeMD()) {}
  }

  bool upgradeMD() {
    if (canUpgradeMD) {
      coal.value -= upgradeMDCost;
      value++;
      return true;
    }
    return false;
  }

  int get upgradeADCost => value * 20;

  bool get canUpgradeAD => coal.value > upgradeADCost - 1;

  void upgradeAllAD() {
    while (upgradeAD()) {}
  }

  bool upgradeAD() {
    if (canUpgradeAD) {
      coal.value -= upgradeADCost;
      autoMiner.value++;
      notifyListeners();
      return true;
    }
    return false;
  }
}
