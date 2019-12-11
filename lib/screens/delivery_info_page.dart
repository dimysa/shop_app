import 'package:flutter/material.dart';
import 'package:myapp/models/address_info.dart';
import 'package:myapp/repository/database.dart';
import 'package:provider/provider.dart';

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

class _MyTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        _DeliveryInfoView(),
        _PickupInfoView(),
      ],
    );
  }
}

class _DeliveryInfoView extends StatefulWidget {
  @override
  __DeliveryInfoViewState createState() => __DeliveryInfoViewState();
}

class __DeliveryInfoViewState extends State<_DeliveryInfoView> {
  final _addressInfo = AddressInfo();
  final _formKey = GlobalKey<FormState>();
  final _addressTextController = TextEditingController();
  final _nameTextController = TextEditingController();
  final _phoneTextController = TextEditingController();
  final _commentTextController = TextEditingController();

  @override
  void dispose() {
    _addressTextController.dispose();
    _nameTextController.dispose();
    _phoneTextController.dispose();
    _commentTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  'Enter info',
                  style: const TextStyle(fontSize: 22),
                ),
              ),
              DropdownButton<int>(
                icon: Text('Select from history'),
                style: TextStyle(color: Colors.lightBlue),
                underline: Container(
                  height: 0,
                ),
                onChanged: (int newValue) async {
                  var addressModel =
                      await Provider.of<AddressInfoModel>(context)
                          .getAddressById(newValue);
                  _addressTextController.text = addressModel.address;
                  _nameTextController.text = addressModel.name;
                  _phoneTextController.text = addressModel.phone;
                  _commentTextController.text = addressModel.comment;
                },
                items: _getAddressInfoHistory(),
              ),
            ],
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _addressTextController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: 'Address',
            ),
            validator: (value) => value.isEmpty ? 'Enter address' : null,
            onSaved: (value) => _addressInfo.address = value,
          ),
          SizedBox(height: 25),
          Row(
            children: <Widget>[
              Flexible(
                flex: 12,
                child: TextFormField(
                  controller: _nameTextController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Name',
                  ),
                  validator: (value) => value.isEmpty ? 'Enter name' : null,
                  onSaved: (val) => _addressInfo.name = val,
                ),
              ),
              Spacer(flex: 1),
              Flexible(
                flex: 12,
                child: TextFormField(
                  controller: _phoneTextController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Phone',
                  ),
                  validator: (value) => value.isEmpty ? 'Enter phone' : null,
                  onSaved: (val) => _addressInfo.phone = val,
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
          TextFormField(
            controller: _commentTextController,
            maxLines: 3,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: 'Comment',
            ),
            onSaved: (val) => _addressInfo.comment = val,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                child: RaisedButton(
                    child: Text('Confirm purchase',
                        style: const TextStyle(fontSize: 20)),
                    color: Colors.yellow,
                    textColor: Colors.black,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        final db = DataRepository();
                        db.insertAddress(_addressInfo);
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.yellow,
                            content: Text('Purchase complete'),
                          ),
                        );
                      }
                    }),
                height: 50,
              ),
            ),
          ),
          SizedBox(height: 2),
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> _getAddressInfoHistory() {
    final addresses = Provider.of<List<AddressInfo>>(context);
    return addresses
        .map((a) => DropdownMenuItem<int>(
              value: a.id,
              child: Text(
                a.address,
                style: const TextStyle(color: Colors.black),
              ),
            ))
        .toList();
  }
}

class _PickupInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Select address',
          style: const TextStyle(fontSize: 20),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ChoiceChip(
              onSelected: (isSelect) => {},
              selected: false,
              label: Text('Address$index'),
            );
          },
          itemCount: 3,
        ),
        Text(
          'Select date',
          style: const TextStyle(fontSize: 20),
        ),
        Row(
          children: <Widget>[
            ChoiceChip(
              onSelected: (isSelect) => {},
              selected: false,
              label: Text('Today'),
            ),
            ChoiceChip(
              onSelected: (isSelect) => {},
              selected: false,
              label: Text('Tommorow'),
            ),
            ChoiceChip(
              onSelected: (isSelect) {
                final now = DateTime.now();
                showDatePicker(
                  context: context,
                  initialDate: now,
                  firstDate: now,
                  lastDate: DateTime.now().add(Duration(days: 14)),
                );
              },
              selected: false,
              label: Text('Select date'),
            ),
          ],
        )
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
