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
                            RadioListTile(
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
                            ),
                            RadioListTile(
                              title: const Text("400-700nm (VIS・PAR・PPFD)"),
                              value: IntegrateLigthIntensityRange.vis,
                              groupValue: _integrateRangeSel,
                              onChanged: (value) {
                                setState(() {
                                  _wlRangeValues = const RangeValues(0.4, 0.7);
                                  _wlSumMin = (_wlRangeValues.start * 1000)
                                      .toInt()
                                      .toString();
                                  _wlSumMax = (_wlRangeValues.end * 1000)
                                      .toInt()
                                      .toString();
                                  _integrateRangeSel =
                                      IntegrateLigthIntensityRange.vis;
                                });
                              },
                            ),
                            RadioListTile(
                              title: const Text("330-400nm (UV)"),
                              value: IntegrateLigthIntensityRange.uv,
                              groupValue: _integrateRangeSel,
                              onChanged: (value) {
                                setState(() {
                                  _wlRangeValues = const RangeValues(0.33, 0.4);
                                  _wlSumMin = (_wlRangeValues.start * 1000)
                                      .toInt()
                                      .toString();
                                  _wlSumMax = (_wlRangeValues.end * 1000)
                                      .toInt()
                                      .toString();
                                  _integrateRangeSel =
                                      IntegrateLigthIntensityRange.uv;
                                });
                              },
                            ),
                            RadioListTile(
                              title: const Text("400-500nm (B)"),
                              value: IntegrateLigthIntensityRange.b,
                              groupValue: _integrateRangeSel,
                              onChanged: (value) {
                                setState(() {
                                  _wlRangeValues = const RangeValues(0.4, 0.5);
                                  _wlSumMin = (_wlRangeValues.start * 1000)
                                      .toInt()
                                      .toString();
                                  _wlSumMax = (_wlRangeValues.end * 1000)
                                      .toInt()
                                      .toString();
                                  _integrateRangeSel =
                                      IntegrateLigthIntensityRange.b;
                                });
                              },
                            ),
                            RadioListTile(
                              title: const Text("500-600nm (G)"),
                              value: IntegrateLigthIntensityRange.g,
                              groupValue: _integrateRangeSel,
                              onChanged: (value) {
                                setState(() {
                                  _wlRangeValues = const RangeValues(0.5, 0.6);
                                  _wlSumMin = (_wlRangeValues.start * 1000)
                                      .toInt()
                                      .toString();
                                  _wlSumMax = (_wlRangeValues.end * 1000)
                                      .toInt()
                                      .toString();
                                  _integrateRangeSel =
                                      IntegrateLigthIntensityRange.g;
                                });
                              },
                            ),
                            RadioListTile(
                              title: const Text("600-700nm (R)"),
                              value: IntegrateLigthIntensityRange.r,
                              groupValue: _integrateRangeSel,
                              onChanged: (value) {
                                setState(() {
                                  _wlRangeValues = const RangeValues(0.6, 0.7);
                                  _wlSumMin = (_wlRangeValues.start * 1000)
                                      .toInt()
                                      .toString();
                                  _wlSumMax = (_wlRangeValues.end * 1000)
                                      .toInt()
                                      .toString();
                                  _integrateRangeSel =
                                      IntegrateLigthIntensityRange.r;
                                });
                              },
                            ),
                            RadioListTile(
                              title: const Text("700-800nm（FR)"),
                              value: IntegrateLigthIntensityRange.fr,
                              groupValue: _integrateRangeSel,
                              onChanged: (value) {
                                setState(() {
                                  _wlRangeValues = const RangeValues(0.7, 0.8);
                                  _wlSumMin = (_wlRangeValues.start * 1000)
                                      .toInt()
                                      .toString();
                                  _wlSumMax = (_wlRangeValues.end * 1000)
                                      .toInt()
                                      .toString();
                                  _integrateRangeSel =
                                      IntegrateLigthIntensityRange.fr;
                                });
                              },
                            ),
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
                                                  const RangeValues(0.31, 0.8);
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
                                        activeColor: Colors.blueGrey,
                                        inactiveColor: Colors.blueGrey.shade800,
                                        onChanged: (values) {
                                          if (_integrateRangeSel !=
                                              IntegrateLigthIntensityRange
                                                  .custom) {
                                            return;
                                          }
                                          setState(() {
                                            _wlRangeValues = values;
                                            _wlSumMin =
                                                (_wlRangeValues.start * 1000)
                                                    .toInt()
                                                    .toString();
                                            _wlSumMax =
                                                (_wlRangeValues.end * 1000)
                                                    .toInt()
                                                    .toString();
                                          });
                                        },
                                        min: 0.31,
                                        max: 0.8,
                                        divisions: 49,
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        )
                      ],
                    ),
                  ),

                  // Card(
                  //   child: Column(
                  //   children: <Widget>[
                  //     const Text("露光時間"),
                  // RadioListTile(title: const Text("AUTO"), value: "AUTO", groupValue: _exposuretime, onChanged: (value) => { setState(()=>{_exposuretime = value.toString()})}),
                  // RadioListTile(title: const Text("100us"), value: "100us", groupValue: _exposuretime, onChanged: (value) => { setState(()=>{_exposuretime = value.toString()})}),
                  // RadioListTile(title: const Text("1ms"), value: "1ms", groupValue: _exposuretime, onChanged: (value) => { setState(()=>{_exposuretime = value.toString()})}),
                  // RadioListTile(title: const Text("10ms"), value: "10ms", groupValue: _exposuretime, onChanged: (value) => { setState(()=>{_exposuretime = value.toString()})}),
                  // RadioListTile(title: const Text("100ms"), value: "100ms", groupValue: _exposuretime, onChanged: (value) => { setState(()=>{_exposuretime = value.toString()})}),
                  //   ],
                  // ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
