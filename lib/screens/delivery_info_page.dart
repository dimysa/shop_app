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
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _MyTabs(),
              SizedBox(height: 20),
              Expanded(child: _MyTabView()),
              _ConfirmPurchaseButton(),
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
      labelPadding: EdgeInsets.symmetric(horizontal: 5),
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
              border: Border.all(color: Colors.yellow),
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

class _MyTabView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyTabViewState();
}

class _MyTabViewState extends State<_MyTabView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 5),
              TextFormField(
                validator: (value) => value.isEmpty ? 'Enter address' : null,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'Address',
                ),
              ),
              SizedBox(height: 25),
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 12,
                    child: TextFormField(
                      validator: (value) => value.isEmpty ? 'Enter name' : null,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Name',
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
                  Flexible(
                    flex: 12,
                    child: TextFormField(
                      validator: (value) =>
                          value.isEmpty ? 'Enter phone' : null,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Phone',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'Comment',
                ),
              ),
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

class _ConfirmPurchaseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: RaisedButton(
        child: Text('Confirm purchase', style: const TextStyle(fontSize: 20)),
        color: Colors.yellow,
        textColor: Colors.black,
        onPressed: () => Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Purchase confirmed'))),
      ),
      height: 50,
    );
  }
}
