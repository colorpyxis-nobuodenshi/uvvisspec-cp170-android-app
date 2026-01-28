import 'uvvisspec.dart';

class PlantsSpecResult {
  List<double> sp = [];
  List<double> wl = [];
  double ppfd = 0.0; //400-700
  double pfdUv = 0.0; //310-400
  double pfdR = 0.0; //600-700
  double pfdG = 0.0; //500-600
  double pfdB = 0.0; //400-500
  double pfdIr = 0.0; //700-800
  double pfd = 0.0;
  double brRatio = 0.0; //B/R
  double rfrRatio = 0.0; // R/FR
}

class UVVisSpecResultConverterForPlants {
  Future<PlantsSpecResult> convert(UVVisSpecDeviceResult uvsr) async {
    double ppfd = 0.0; //400-700
    double pfdUv = 0.0; //310-400
    double pfdR = 0.0; //600-700
    double pfdG = 0.0; //500-600
    double pfdB = 0.0; //400-500
    double pfdIr = 0.0; //700-800
    double pfd = 0.0;
    double brRatio = 0.0; //B/R
    double rfrRatio = 0.0; // R/FR

    var wl = [...uvsr.wl];
    var sp = [...uvsr.sp];
    var sp2 = List.generate(sp.length, (index) => 0.0);

    for (var i = 0; i < wl.length; i++) {
      var p = sp[i] * wl[i] * 8.36E-3;
      sp2[i] = p;
      pfd += p;
      if (wl[i] >= 400 && wl[i] <= 700) {
        ppfd += p;
      }
      if (wl[i] >= 310 && wl[i] <= 400) {
        pfdUv += p;
      }
      if (wl[i] >= 400 && wl[i] <= 500) {
        pfdB += p;
      }
      if (wl[i] >= 500 && wl[i] <= 600) {
        pfdG += p;
      }
      if (wl[i] >= 600 && wl[i] <= 700) {
        pfdR += p;
      }
      if (wl[i] >= 700 && wl[i] <= 800) {
        pfdIr += p;
      }
    }

    brRatio = pfdR == 0 ? 0 : pfdB / pfdR;
    rfrRatio = pfdIr == 0 ? 0 : pfdR / pfdIr;

    PlantsSpecResult psr = PlantsSpecResult();
    psr.ppfd = ppfd;
    psr.pfd = pfd;
    psr.pfdUv = pfdUv;
    psr.pfdR = pfdR;
    psr.pfdG = pfdG;
    psr.pfdB = pfdB;
    psr.pfdIr = pfdIr;
    psr.sp = sp2;
    psr.wl = wl;
    psr.brRatio = brRatio;
    psr.rfrRatio = rfrRatio;

    return psr;
  }
}
