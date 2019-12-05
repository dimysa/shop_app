import 'package:flutter/material.dart';

class DeliveryInfoPage extends StatelessWidget {
  static const routeName = '/deliveryInfo';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Delivery info',
            style: Theme.of(context).textTheme.display4,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10,10,10,0),
          child: Column(
            children: <Widget>[
              _MyTabs(),
              Expanded(child: _MyTabView()),
            ],
          ),
        ),
      ),
    );
  }
}

class _MyTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBar(      
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.yellow,
      ),
      indicatorSize: TabBarIndicatorSize.label,      
      tabs: [
        Tab(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.yellow),              
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text('Delivery'),
            ),
          ),
        ),
        Tab(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.yellow, width: 1),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text('Pickup'),
            ),
          ),
        ),
      ],
    );
  }
}

class _MyTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.directions_car),
              Text("Delivery"),
            ],
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.directions_run),
              Text("Pickup"),
            ],
          ),
        ),
      ],
    );
  }
}
