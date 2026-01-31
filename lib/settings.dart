import 'package:flutter/material.dart';
import 'uvvisspec.dart';

class SettingsPage extends StatefulWidget {
  //const SettingsPage({Key? key}) : super(key: key);
  SettingsPage(this.settings);
  Settings settings;
  @override
  State<StatefulWidget> createState() {
    return SettingsPageState();
  }
}

class SettingsPageState extends State<SettingsPage> {
  var _wlSumMin = "";
  var _wlSumMax = "";
  var _wlRangeValues = const RangeValues(0.33, 0.8);
  var _exposuretime = "";
  var _measureModeSel = MeasureMode.irradiance;
  //var _filterSel = FilterSpectralIntensityType.chlorophyllA;
  var _integrateRangeSel = IntegrateLigthIntensityRange.all;
  var _unitSel = Unit.w;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final settings = widget.settings;
    _wlSumMin = settings.sumRangeMin.toInt().toString();
    _wlSumMax = settings.sumRangeMax.toInt().toString();
    _wlRangeValues = RangeValues(
        settings.sumRangeMin / 1000.0, settings.sumRangeMax / 1000.0);
    setState(() {
      _exposuretime = settings.deviceExposureTime;
      _measureModeSel = settings.measureMode;
      _integrateRangeSel = settings.integrateLigthIntensityRange;
      _unitSel = settings.unit;
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
        s.measureMode = _measureModeSel;
        s.integrateLigthIntensityRange = _integrateRangeSel;
        s.unit = _unitSel;
        Navigator.of(context).pop(s);

        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('設定'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => {},
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
                                    _unitSel = Unit.w;
                                    _integrateRangeSel = IntegrateLigthIntensityRange.all;
                                    _wlRangeValues = const RangeValues(0.33, 0.8);
                                    _wlSumMin = (_wlRangeValues.start * 1000)
                                        .toInt()
                                        .toString();
                                    _wlSumMax = (_wlRangeValues.end * 1000)
                                        .toInt()
                                        .toString();
                                    // _filterSel =
                                    //     FilterSpectralIntensityType.none;
                                  })
                                }),
                        RadioListTile(
                            title: const Text("PPFD"),
                            value: MeasureMode.ppfd,
                            groupValue: _measureModeSel,
                            onChanged: (value) => {
                                  setState(() {
                                    _measureModeSel = MeasureMode.ppfd;
                                    _unitSel = Unit.mol;
                                    _integrateRangeSel = IntegrateLigthIntensityRange.custom;
                                    _wlRangeValues =
                                                  const RangeValues(0.33, 0.8);
                                    _wlSumMin =
                                        (_wlRangeValues.start * 1000)
                                            .toInt()
                                            .toString();
                                    _wlSumMax =
                                        (_wlRangeValues.end * 1000)
                                            .toInt()
                                            .toString();
                                    // _filterSel =
                                    //     FilterSpectralIntensityType.none;
                                  })
                                }),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: <Widget>[
                        const Text("測定波長範囲"),
                        Column(
                          children: <Widget>[
                             Visibility(
                                visible: _measureModeSel == MeasureMode.irradiance,
                            child : RadioListTile(
                              title: const Text("330-800nm"),
                              value: IntegrateLigthIntensityRange.all,
                              groupValue: _integrateRangeSel,
                              onChanged: (value) {
                                setState(() {
                                  _wlRangeValues = const RangeValues(0.33, 0.8);
                                  _wlSumMin = (_wlRangeValues.start * 1000)
                                      .toInt()
                                      .toString();
                                  _wlSumMax = (_wlRangeValues.end * 1000)
                                      .toInt()
                                      .toString();
                                  _integrateRangeSel =
                                      IntegrateLigthIntensityRange.all;
                                });
                              },
                            )),
                            RadioListTile(
                              title: const Text("カスタム"),
                              value: IntegrateLigthIntensityRange.custom,
                              groupValue: _integrateRangeSel,
                              onChanged: (value) {
                                setState(() {
                                  _integrateRangeSel =
                                      IntegrateLigthIntensityRange.custom;
                                });
                              },
                            ),
                            Visibility(
                                visible: _integrateRangeSel ==
                                    IntegrateLigthIntensityRange.custom,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            const Text("短波長端"),
                                            Text(
                                              _wlSumMin,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        ElevatedButton(
                                          child: const Text('Reset'),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.blueGrey,
                                            onPrimary: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _wlRangeValues =
                                                  const RangeValues(0.33, 0.8);
                                              _wlSumMin =
                                                  (_wlRangeValues.start * 1000)
                                                      .toInt()
                                                      .toString();
                                              _wlSumMax =
                                                  (_wlRangeValues.end * 1000)
                                                      .toInt()
                                                      .toString();
                                              // _integrateRangeSel =
                                              //     IntegrateLigthIntensityRange
                                              //         .all;
                                            });
                                          },
                                        ),
                                        Column(
                                          children: [
                                            const Text("長波長端"),
                                            Text(
                                              _wlSumMax,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Center(
                                      //width: 230,
                                      child: RangeSlider(
                                        values: _wlRangeValues,
                                        min: 330,
                                        max: 800,
                                        divisions: ((800 - 330) ~/ 10), // 10nm刻み
                                        labels: RangeLabels(
                                          _wlRangeValues.start.round().toString(),
                                          _wlRangeValues.end.round().toString(),
                                        ),
                                        onChanged: (values) {
                                          setState(() {
                                            _wlRangeValues = values;
                                            _wlSumMin = _wlRangeValues.start.round().toString();
                                            _wlSumMax = _wlRangeValues.end.round().toString();
                                          });
                                        },
                                        activeColor: Colors.blueGrey,
                                        inactiveColor: Colors.blueGrey.shade800,
                                      )
                                    ),
                                  ],
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                   Card(
                child: ListTile(
                  title: const Text("このアプリの情報について"),
                  onTap: (){
                    showLicensePage(
                      context: context,
                      applicationName: "植物用分光放射照度計CP170",
                      applicationVersion: "1.0.0",
                      // applicationIcon: MyAppIcon(),
                      applicationLegalese:
                          "\u{a9} 2023 NOBUO ELECTRONICS CO., LTD.",
                    );
                },
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