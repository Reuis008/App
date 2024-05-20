import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnitConverter extends StatefulWidget {
  final String containerName;
  const UnitConverter({super.key, required this.containerName});

  @override
  State<UnitConverter> createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  String _property = '';
  String _sourceUnit = 'Select a value';
  String _targetUnit = 'Select a value';
  double _sourceValue = 0.0;
  double _convertedValue = 0.0;

  @override
  void initState() {
    super.initState();
    _property = widget
        .containerName; // Set _property to the containerName passed from the UnitConverter widget
  }

  final Map<String, Map<String, double>> _conversionFactors = {
    "Acceleration": {
      "Meter/sq.sec (m/sec^2)": 1,
      "Foot/sq.sec (ft/sec^2)": 0.3048,
      "G (g)": 9.806650,
      "Galileo (gal)": 0.01,
      "Inch/sq.sec (in/sec^2)": 0.0254,
    },
    "Area": {
      "Square meter (m^2)": 1,
      "Acre (acre)": 4046.856,
      "Are (are)": 100,
      "Barn (barn)": 1E-28,
      "Hectare (hec)": 10000,
      "Rood (rood)": 1011.71413184285,
      "Square centimeter (cm^2)": 0.0001,
      "Square kilometer (km)": 1000000,
      "Circular mil (cm)": 5.067075E-10,
      "Square foot (ft^2)": 9.290304E-02,
      "Square inch (in^2)": 2.54E-02,
      "Square mile (mi^2)": 6.4516E-04,
      "Square yard (yd^2)": 8.361274,
    },
    "Torque": {
      "Newton-meter (N m)": 1,
      "Dyne-centimeter(dy cm)": 0.0000001,
      "Kgrf-meter (kgf m)": 9.806650,
      "lbf-inch (lbf in)": 0.1129848,
      "lbf-foot (lbf ft)": 1.355818,
    },
    "Electricity": {
      "Coulomb (Cb)": 1,
      "Abcoulomb (aC)": 10,
      "Ampere hour (A hr)": 3600,
      "Faraday (F)": 96521.8999999997,
      "Statcoulomb (stC)": 0.000000000333564,
      "Millifaraday (mF)": 96.5219,
      "Microfaraday (mu-F)": 9.65219E-02,
      "Picofaraday (pF)": 9.65219E-05,
    },
    "Energy": {
      "Joule (J)": 1,
      "BTU (mean)": 1055.87,
      "BTU (thermochemical)": 1054.35,
      "Calorie (SI) (cal)": 4.1868,
      "Calorie (mean)(cal)": 4.19002,
      "Calorie (thermo)": 4.184,
      "Electron volt (eV)": 1.6021E-19,
      "Erg (erg)": 0.0000001,
      "Foot-pound force (ft.lb)": 1.355818,
      "Foot-poundal (ft-pdl)": 4.214011E-02,
      "Horsepower-hour (HPH)": 2684077.3,
      "Kilocalorie (SI)(kcal)": 4186.8,
      "Kilocalorie (mean)(kcal)": 4190.02,
      "Kilowatt-hour (kW hr)": 3600000,
      "Ton of TNT (TNT)": 4.2E9,
      "Volt-coulomb (V Cb)": 1,
      "Watt-hour (W hr)": 3600,
      "Watt-second (W sec)": 1,
    },
    "Force": {
      "Newton (N)": 1,
      "Dyne (dy)": 0.00001,
      "Kilogram force (kgf)": 9.806650,
      "Kilopond force (kpf)": 9.806650,
      "Kip (k)": 4448.222,
      "Ounce force (ozf)": 0.2780139,
      "Pound force (lbf)": 0.4535924,
      "Poundal (lb)": 0.138255,
    },
    "Force / Length": {
      "Newton/meter (N/m)": 1,
      "Pound force/inch (lbf/in)": 175.1268,
      "Pound force/foot (lbf/ft)": 14.5939,
    },
    "Length": {
      "Meter (m)": 1,
      "Angstrom (A')": 1E-10,
      "Astronomical unit (AU)": 1.49598E11,
      "Caliber (cal)": 0.000254,
      "Centimeter (cm)": 0.01,
      "Kilometer (km)": 1000,
      "Ell (Ell)": 1.143,
      "Em (Em)": 4.2323E-03,
      "Fathom (Fathom)": 1.8288,
      "Furlong (Furlong)": 201.168,
      "Fermi (fm)": 1E-15,
      "Foot (ft)": 0.3048,
      "Inch (in)": 0.0254,
      "League (int'l)": 5556,
      "League (UK)": 5556,
      "Light year (LY)": 9.46055E+15,
      "Micrometer (mu-m)": 0.000001,
      "Mil (Mil)": 0.000001,
      "Millimeter (mm)": 0.001,
      "Nanometer (nm)": 1E-9,
      "Mile (int'l nautical)": 1852,
      "Mile (UK nautical)": 1853.184,
      "Mile (US nautical)": 1852,
      "Mile (US statute)": 1609.344,
      "Parsec (Parsec)": 3.08374E+16,
      "Pica (printer)": 4.217518E-03,
      "Picometer (pm)": 1E-12,
      "Point (pt)": 0.0003514598,
      "Rod (Rod)": 5.0292,
      "Yard (yd)": 0.9144,
    },
    "Light": {
      "Lumen/sq.meter (Lu/m^2)": 1,
      "Lumen/sq.centimeter (Lu/cm^2)": 10000,
      "Lumen/sq.foot (Lu/ft^2)": 10.76391,
      "Foot-candle (ft-cdl)": 10.76391,
      "Foot-lambert (ft-L)": 3.14159250538575,
      "Candela/sq.meter (Cd/m^2)": 1,
      "Candela/sq.centimeter (Cd/cm^2)": 31415.9250538576,
      "Lux (lux)": 1,
      "Phot (Phot)": 10000,
    },
    "Mass": {
      "Kilogram (kgr)": 1,
      "Gram (gr)": 0.001,
      "Milligram (mgr)": 1e-6,
      "Microgram (mu-gr)": 0.000000001,
      "Carat (metric)(ct)": 0.0002,
      "Hundredweight (long)": 50.80235,
      "Hundredweight (short)": 45.35924,
      "Pound mass (lbm)": 0.4535924,
      "Pound mass (troy)": 0.02834952,
      "Ounce mass (ozm)": 0.02834952,
      "Ounce mass (troy)": 0.03110348,
      "Slug (slug)": 14.5939,
      "Ton (assay)": 0.02916667,
      "Ton (long)": 1016.047,
      "Ton (short)": 907.1847,
      "Ton (metric)": 1000,
      "Tonne (Tonne)": 1000,
    },
    "Density & Mass capacity": {
      "Kilogram/cub.meter (kg/m^3)": 1,
      "Grain/galon (Grain/gal)": 0.01711806,
      "Grams/cm^3 (gr/cc)": 1000,
      "Pound mass/cubic foot (lb/ft3)": 16.01846,
      "Pound mass/cubic-inch (lbm/in^3)": 27679.91,
      "Ounces/gallon (UK,liq)": 6.236027,
      "Ounces/gallon (US,liq)": 7.489152,
      "Ounces (mass)/inch": 1729.994,
      "Pound mass/gal (UK,liq)": 99.77644,
      "Pound mass/gal (US,liq)": 119.8264,
      "Slug/cubic foot (slug/ft3)": 515.379,
      "Tons (long,mass)/cub.yard": 1328.939,
    },
    "Mass Flow": {
      "Kilogram/second (kgr/sec)": 1,
      "Pound mass/sec (lbm/sec)": 0.4535924,
      "Pound mass/min (lbm/min)": 0.007559873,
    },
    "Power": {
      "Watt (W)": 1,
      "Kilowatt (kW)": 1000,
      "Megawatt (MW)": 1000000,
      "Milliwatt (mW)": 0.001,
      "BTU (SI)/hour": 0.2930667,
      "BTU (thermo)/second": 1054.35,
      "BTU (thermo)/minute": 17.5725,
      "BTU (thermo)/hour": 4.184,
      "Calorie (thermo)/second": 6.973333E-02,
      "Calorie (thermo)/minute": 0.06973333,
      "Erg/second (Erg/second)": 0.0000001,
      "Foot-pound force/hour (lb.ft/hour)": 0.02259697,
      "Foot-pound force/minute (lb.ft/min)": 0.01355818,
      "Foot-pound force/second (lb.ft/sec)": 0.001355818,
      "Horsepower(550 ft lbf/s)": 745.7,
      "Horsepower (electric)": 746,
      "Horsepower (boiler)": 9809.5,
      "Horsepower (metric)": 735.499,
      "Horsepower (UK)": 745.7,
      "Kilocalorie (thermo)/min": 0.06973333,
      "Kilocalorie (thermo)/sec": 0.0006973333,
    },
    "Pressure & Stress": {
      "Newton/sq.meter (N/m^2)": 1,
      "Atmosphere (normal)": 101325,
      "Atmosphere (techinical)": 98066.5,
      "Bar (bar)": 100000,
      "Centimeter mercury(cmHg)": 1333.22,
      "Centimeter water (4'C)": 98.0638,
      "Decibar (Decibar)": 10000,
      "Kgr force/sq.centimeter (kgr force/cm^2)": 98066.5,
      "Kgr force/sq.meter (kgr force/m^2)": 9.80665,
      "Kip/square inch (kip sq inch)": 6894757,
      "Millibar (Millibar)": 100,
      "Millimeter mercury(mmHg)": 133.3224,
      "Pascal (Pa)": 1,
      "Kilopascal (kPa)": 1000,
      "Megapascal (Mpa)": 1000000,
      "Poundal/sq.foot (lb/sq.foot)": 47.88026,
      "Pound-force/sq.foot (lb-f/sq.foot)": 47.88026,
      "Pound-force/sq.inch (psi)": 6894.757,
      "Torr (mmHg,0'C)": 133.322,
    },
    "Temperature": {
      "Degrees Celsius ('C)": 1,
      "Degrees Fahrenheit ('F)": 0.555555555555,
      "Degrees Kelvin ('K)": 1,
      "Degrees Rankine ('R)": 0.555555555555,
    },
    "Time": {
      "Second (sec)": 1,
      "Day (mean solar)": 8.640E4,
      "Day (sidereal)": 86164.09,
      "Hour (mean solar)": 3600,
      "Hour (sidereal)": 3590.17,
      "Minute (mean solar)": 60,
      "Minute (sidereal)": 60,
      "Month (mean calendar)": 2628000,
      "Second (sidereal)": 0.9972696,
      "Year (calendar)": 31536000,
      "Year (tropical)": 31556930,
      "Year (sidereal)": 31558150,
    },
    "Velocity & Speed": {
      "Meter/second (m/sec)": 1,
      "Foot/minute (ft/min)": 5.08E-03,
      "Foot/second (ft/sec)": 0.3048,
      "Kilometer/hour (kph)": 0.5144444,
      "Knot (int'l)": 0.44707,
      "Mile (US)/hour (mph)": 0.44707,
      "Mile (nautical)/hour": 0.5144444,
      "Mile (US)/minute": 26.8224,
      "Mile (US)/second": 1609.344,
      "Speed of light (c)": 299792458,
      "Mach (STP)(a)": 340.0068750,
    },
    "Viscosity": {
      "Newton-second/meter (Ns/meter)": 1,
      "Centipoise (Centipoise)": 0.001,
      "Centistoke (Centistoke)": 0.000001,
      "Sq.foot/second (sq.foot/sec)": 9.290304E-02,
      "Poise (Poise)": 0.1,
      "Poundal-second/sq.foot (lb-sec/sq.foot)": 1.488164,
      "Pound mass/foot-second (lb.mass/foot-sec)": 1.488164,
      "Pound force-second/sq.foot (lb force-sec/sq.foot)": 47.88026,
      "Rhe (rhe)": 10,
      "Slug/foot-second (slug/foot-sec)": 10,
      "Stoke (Stoke)": 0.0001,
    },
    "Volume & Capacity": {
      "Cubic Meter (m^3)": 1,
      "Cubic centimeter (cubic cm)": 0.000001,
      "Cubic millimeter (cubic m)": 0.000000001,
      "Acre-foot (Acer-foot)": 1233.482,
      "Barrel (oil)": 0.1589873,
      "Board foot (Board foot)": 0.002359737,
      "Bushel (US)": 0.03523907,
      "Cup (cup)": 0.0002365882,
      "Fluid ounce (US)": 0.00002957353,
      "Cubic foot (Cubic foot)": 0.02831685,
      "Gallon (UK)": 0.004546087,
      "Gallon (US,dry)": 0.004404884,
      "Gallon (US,liq)": 0.003785412,
      "Gill (UK)": 0.0001420652,
      "Gill (US)": 0.0001182941,
      "Cubic inch (in^3)": 0.00001638706,
      "Liter (new)": 0.001,
      "Liter (old)": 0.001000028,
      "Ounce (UK,fluid)": 0.00002841305,
      "Ounce (US,fluid)": 0.00002957353,
      "Peck (US)": 0.0088097680E-03,
      "Pint (US,dry)": 0.0005506105,
      "Pint (US,liq)": 0.00047317650E-04,
      "Quart (US,dry)": 0.0022024094,
      "Quart (US,liq)": 0.0011365853,
      "Stere (Stere)": 1,
      "Tablespoon (tablespoon)": 0.00001478676,
      "Teaspoon (teaspoon)": 0.000004928922,
      "Ton (register)": 0.001101221,
      "Cubic yard (cubic yard)": 0.7645549,
    },
    "Volume Flow": {
      "Cubic meter/second (cubic m/sec)": 1,
      "Cubic foot/second (cubic foot/sec)": 0.02831685,
      "Cubic foot/minute (cubic foot/min)": 0.0004719474,
      "Cubic inches/minute (cubic inch/min)": 2.731177E-7,
      "Gallons (US,liq)/minute)": 6.309020E-05,
    },
    // Add more properties and their units here, following the same structure
  };

  void _convert() {
    setState(() {
      _convertedValue = _sourceValue *
          _conversionFactors[_property]![_sourceUnit]! /
          _conversionFactors[_property]![_targetUnit]!;
    });
  }

  String _extractBracketPart(String unitName) {
    int startIndex = unitName.indexOf('(');
    int endIndex = unitName.indexOf(')') + 1;
    return unitName.substring(startIndex, endIndex);
  }

  void _showDropdownList(String dropdownType) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.grey.shade900,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Select a unit',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500),
                ),
                ..._conversionFactors[_property]!.keys.map((String unit) {
                  return ListTile(
                    title: Text(
                      unit,
                      style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      setState(() {
                        if (dropdownType == 'source') {
                          _sourceUnit = unit;
                        } else {
                          _targetUnit = unit;
                        }
                      });
                      Navigator.pop(context); // Close the bottom sheet
                    },
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.outline,
            size: 32.sp,
          ), // Set the icon size here
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50.h,
              ),
              Text(
                '$_property Converter',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50.h),
              if (_property.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => _showDropdownList('source'),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.transparent),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.arrow_drop_down,
                                    color: Colors.deepOrangeAccent),
                                Text(
                                  _sourceUnit.isNotEmpty &&
                                          _sourceUnit != 'Select a value'
                                      ? _extractBracketPart(_sourceUnit)
                                      : _sourceUnit,
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                // Example icon
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () => _showDropdownList('target'),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _targetUnit.isNotEmpty &&
                                          _targetUnit != 'Select a value'
                                      ? _extractBracketPart(_targetUnit)
                                      : _targetUnit,
                                  style: TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down,
                                    color: Colors
                                        .deepOrangeAccent), // Example icon
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 150.h,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.5,
                        child: TextField(
                          style: TextStyle(
                              color: Colors.deepOrangeAccent,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              _sourceValue = double.tryParse(value) ?? 0.0;
                            });
                          },
                          decoration: const InputDecoration(
                              labelText: 'Enter value',
                              labelStyle:
                                  TextStyle(color: Colors.deepOrangeAccent)),
                          maxLength: 20,
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      ElevatedButton(
                        onPressed: (_sourceUnit.isNotEmpty &&
                                _sourceUnit != 'Select a value' &&
                                _targetUnit.isNotEmpty &&
                                _targetUnit != 'Select a value')
                            ? _convert
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .deepOrangeAccent, // Set the background color
                          foregroundColor: Colors.white, // Set the text color
                          elevation:
                              0, // Remove elevation for a flat appearance
                          shadowColor: Colors
                              .transparent, // Remove shadow for a flat appearance
                        ),
                        child: Text(
                          'Convert',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.outline,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Converted Value: $_convertedValue',
                        style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
