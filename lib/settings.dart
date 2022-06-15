import 'package:flutter/material.dart';
import 'uvvisspec.dart';

class SettingsPage extends StatefulWidget {
  //const SettingsPage({Key? key}) : super(key: key);
  SettingsPage(this.settings);
  Settings settings;
  @override
  State<StatefulWidget> createState() {
    return SettingsPageState();
  }}

class SettingsPageState extends State<SettingsPage> {

  var _wlSumMin = "";
  var _wlSumMax = "";
  var _wlRangeValues = const RangeValues(0.33, 0.8);
  var _exposuretime = "";
  var _measureModeSel = MeasureMode.irradiance;
  var _filterSel = FilterSpectralIntensityType.chlorophyllA;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final settings = widget.settings;
    _wlSumMin = settings.sumRangeMin.toInt().toString();
    _wlSumMax = settings.sumRangeMax.toInt().toString();
    _wlRangeValues = RangeValues(settings.sumRangeMin / 1000.0, settings.sumRangeMax / 1000.0);
    setState(() {
      _exposuretime = settings.deviceExposureTime;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Settings s = Settings();
        s.sumRangeMin = double.parse(_wlSumMin);
        s.sumRangeMax = double.parse(_wlSumMax);
        s.deviceExposureTime = _exposuretime;
        Navigator.of(context).pop(s);

        return Future.value(false);
      },
      child : Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => {
              
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
        children: <Widget>[
          Column(
            children: [
              Card(
                    child: Column(
                      children: <Widget>[
                        const Text("測定モード"),
                        RadioListTile(
                            title: const Text("放射照度"),
                            value: MeasureMode.irradiance,
                            groupValue: _measureModeSel,
                            onChanged: (value) => {
                                  setState(() {
                                    _measureModeSel = MeasureMode.irradiance;
                                    _filterSel =
                                        FilterSpectralIntensityType.none;
                                  })
                                }),
                        RadioListTile(
                            title: const Text("PPFD"),
                            value: MeasureMode.ppfd,
                            groupValue: _measureModeSel,
                            onChanged: (value) => {
                                  setState(() {
                                    _measureModeSel = MeasureMode.ppfd;
                                    _filterSel =
                                        FilterSpectralIntensityType.none;
                                  })
                                }),
                      ],
                    ),
                  ),
              Card(
                child: Column(
                children: <Widget>[
                  const Text("測定波長囲"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text("短波長端"),
                          Text(_wlSumMin, style: const TextStyle(fontSize: 20),),
                        ],
                    
                      ),
                      ElevatedButton(
                        child: const Text('リセット'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey,
                          onPrimary: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                              _wlRangeValues = const RangeValues(0.31, 0.8);
                              _wlSumMin = (_wlRangeValues.start * 1000).toInt().toString();
                              _wlSumMax = (_wlRangeValues.end * 1000).toInt().toString();
                            });
                        },
                      ),
                      Column(
                        children: [
                          const Text("長波長端"),
                          Text(_wlSumMax, style: const TextStyle(fontSize: 20),),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: RangeSlider(values: _wlRangeValues,
                      activeColor: Colors.blueGrey,
                      inactiveColor: Colors.blueGrey.shade800,
                      onChanged: (values) {
                        setState(() {
                          _wlRangeValues = values;
                          _wlSumMin = (_wlRangeValues.start * 1000).toInt().toString();
                          _wlSumMax = (_wlRangeValues.end * 1000).toInt().toString();
                        });
                      },
                      min: 0.33,
                      max: 0.8,
                      divisions: 47,
                    ),
                  ),
                ],
              ),
              ),
              Card(
                child: Column(
                children: <Widget>[
                  const Text("露光時間"),
              RadioListTile(title: const Text("AUTO"), value: "AUTO", groupValue: _exposuretime, onChanged: (value) => { setState(()=>{_exposuretime = value.toString()})}),
              RadioListTile(title: const Text("100us"), value: "100us", groupValue: _exposuretime, onChanged: (value) => { setState(()=>{_exposuretime = value.toString()})}),
              RadioListTile(title: const Text("1ms"), value: "1ms", groupValue: _exposuretime, onChanged: (value) => { setState(()=>{_exposuretime = value.toString()})}),
              RadioListTile(title: const Text("10ms"), value: "10ms", groupValue: _exposuretime, onChanged: (value) => { setState(()=>{_exposuretime = value.toString()})}),
              RadioListTile(title: const Text("100ms"), value: "100ms", groupValue: _exposuretime, onChanged: (value) => { setState(()=>{_exposuretime = value.toString()})}),
                ],
              ),
              ),
              ],
          )
        ],
      ),
      ),
    ),
    );
  }
}