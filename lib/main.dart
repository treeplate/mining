import 'package:flutter/material.dart';
import 'logic.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  static final Mine mine = Mine(coal, autoMiner);
  static final CoalAmount coal = CoalAmount();
  static final AutoMiner autoMiner = AutoMiner();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MineWidget(mine),
            CoalWidget(coal),
            AutoMinerWidget(autoMiner),
            MineUpgradeWidget(coal, mine),
          ],
        ),
      ),
    );
  }
}

class MineWidget extends StatelessWidget {
  const MineWidget(this.mine);
  final Mine mine;
  Widget build(Object context) {
    return ValueListenableBuilder<int>(
      valueListenable: mine,
      builder: (BuildContext context, int value, Widget child) {
        return Text("Mine level $value");
      },
    );
  }
}

class CoalWidget extends StatelessWidget {
  const CoalWidget(this.coal);
  final CoalAmount coal;
  Widget build(Object context) {
    return ValueListenableBuilder<int>(
      valueListenable: coal,
      builder: (BuildContext context, int value, Widget child) {
        return Text("$value pcs Coal");
      },
    );
  }
}

class AutoMinerWidget extends StatelessWidget {
  const AutoMinerWidget(this.autoMiner);
  final AutoMiner autoMiner;
  Widget build(Object context) {
    return ValueListenableBuilder<int>(
      valueListenable: autoMiner,
      builder: (BuildContext context, int value, Widget child) {
        return Text("mining $value pcs Coal per second");
      },
    );
  }
}

class MineUpgradeWidget extends StatelessWidget {
  final Listenable coalAndMine;
  final CoalAmount coal;
  final Mine mine;

  MineUpgradeWidget(this.coal, this.mine)
      : this.coalAndMine = Listenable.merge([coal, mine]);
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: coalAndMine,
      builder: (BuildContext context, Widget child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text("Mine"),
              onPressed: mine.mine,
            ),
            TextButton(
              child: Text("Upgrade Automatic Dig"),
              onPressed: mine.canUpgradeAD ? mine.upgradeAD : null,
            ),
            TextButton(
              child: Text("Upgrade All Automatic Dig"),
              onPressed: mine.canUpgradeAD ? mine.upgradeAllAD : null,
            ),
            TextButton(
              child: Text("Upgrade Manual Dig"),
              onPressed: mine.canUpgradeMD ? mine.upgradeMD : null,
            ),
            TextButton(
              child: Text("Upgrade All Manual Dig"),
              onPressed: mine.canUpgradeMD ? mine.upgradeAllMD : null,
            ),
          ],
        );
      },
    );
  }
}
