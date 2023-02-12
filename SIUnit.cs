public static class SIUnit {

    #region Constants
    public const float LIGHTSPEED = 3.0e8f; // meters/second

    // length measures, in meters
    public const float LIGHTSECOND = LIGHTSPEED;
    public const float LIGHTMINUTE = LIGHTSECOND * 60;
    public const float LIGHTHOUR   = LIGHTMINUTE * 60;
    public const float LIGHTDAY    = LIGHTHOUR   * 24;
    public const float LIGHTYEAR = LIGHTDAY * 365;
    #endregion

    #region Base Units
    public static string GetUnitName(this SIUnit.Base.Type type) { return SIUnit.Base.GetUnitName(type); }
    public static string GetUnitSymbol(this SIUnit.Base.Type type) { return SIUnit.Base.GetUnitSymbol(type); }
    public static string GetDimensionName(this SIUnit.Base.Type type) { return SIUnit.Base.GetDimensionName(type); }
    public static string GetDimensionSymbol(this SIUnit.Base.Type type) { return SIUnit.Base.GetDimensionSymbol(type); }

    public static class Base {
        public enum Type : int { Length, Mass, Time, Current, Temperature, Substance, Luminosity }

        private struct BaseUnitEntry {
            public string unitName;
            public string unitSymbol;
            public string dimensionSymbol;
        }

        private static readonly Dictionary<Type, BaseUnitEntry> table = new Dictionary<Type, BaseUnitEntry>() {
                { Type.Length,      new BaseUnitEntry { unitName = "Metre",   unitSymbol = "m",   dimensionSymbol = "L" } }
            ,{ Type.Mass,        new BaseUnitEntry { unitName = "Gram",    unitSymbol = "g",   dimensionSymbol = "M" } }
            ,{ Type.Time,        new BaseUnitEntry { unitName = "Second",  unitSymbol = "s",   dimensionSymbol = "T" } }
            ,{ Type.Current,     new BaseUnitEntry { unitName = "Ampere",  unitSymbol = "A",   dimensionSymbol = "I" } }
            ,{ Type.Temperature, new BaseUnitEntry { unitName = "Kelvin",  unitSymbol = "K",   dimensionSymbol = "Θ" } }
            ,{ Type.Substance,   new BaseUnitEntry { unitName = "Mole",    unitSymbol = "mol", dimensionSymbol = "N" } }
            ,{ Type.Luminosity,  new BaseUnitEntry { unitName = "Candela", unitSymbol = "cd",  dimensionSymbol = "J" } }
        };

        public static string GetUnitName(Type type) { return table[type].unitName; }
        public static string GetUnitSymbol(Type type) { return table[type].unitSymbol; }
        public static string GetDimensionName(Type type) { return type.ToString(); }
        public static string GetDimensionSymbol(Type type) { return table[type].dimensionSymbol; }
    }
    #endregion

    #region Prefix
    public static int GetPower(this SIUnit.Prefix.Type type) { return SIUnit.Prefix.GetPower(type); }
    public static string GetPrefix(this SIUnit.Prefix.Type type) { return SIUnit.Prefix.GetPrefix(type); }
    public static string GetSymbol(this SIUnit.Prefix.Type type) { return SIUnit.Prefix.GetSymbol(type); }
    public static string GetQuantity(this SIUnit.Prefix.Type type) { return SIUnit.Prefix.GetQuantity(type); }

    public static float GetScale(this SIUnit.Prefix.Type type) { return SIUnit.Prefix.GetScale(type); }

    public static class Prefix {
        public enum Type : int {
            Yocto = -24
            , Zepto = -21
            , Atto = -18
            , Femto = -15
            , Pico = -12
            , Nano = -09
            , Micro = -06
            , Milli = -03
            , Centi = -02
            , Deci = -01
            , Base = 00
            , Deca = +01
            , Hecto = +02
            , Kilo = +03
            , Mega = +06
            , Giga = +09
            , Tera = +12
            , Peta = +15
            , Exa = +18
            , Zetta = +21
            , Yotta = +24
        }

        private struct PrefixEntry {
            public string prefix;
            public string symbol;
            public string quantity;
        }

        private static readonly Dictionary<Type, PrefixEntry> table = new Dictionary<Type, PrefixEntry> {
                 { Type.Yocto, new PrefixEntry { prefix = "Yocto", symbol = "y",  quantity = "Septillionth"  } }
                ,{ Type.Zepto, new PrefixEntry { prefix = "Zepto", symbol = "z",  quantity = "Sextillionth"  } }
                ,{ Type.Atto,  new PrefixEntry { prefix = "Atto",  symbol = "a",  quantity = "Quintillionth" } }
                ,{ Type.Femto, new PrefixEntry { prefix = "Femto", symbol = "f",  quantity = "Quadrillionth" } }
                ,{ Type.Pico,  new PrefixEntry { prefix = "Pico",  symbol = "p",  quantity = "Trillionth"    } }
                ,{ Type.Nano,  new PrefixEntry { prefix = "Nano",  symbol = "n",  quantity = "Billionth"     } }
                ,{ Type.Micro, new PrefixEntry { prefix = "Micro", symbol = "μ",  quantity = "Millionth"     } }
                ,{ Type.Milli, new PrefixEntry { prefix = "Milli", symbol = "m",  quantity = "Thousandth"    } }
                ,{ Type.Centi, new PrefixEntry { prefix = "Centi", symbol = "c",  quantity = "Hundredth"     } }
                ,{ Type.Deci,  new PrefixEntry { prefix = "Deci",  symbol = "d",  quantity = "Tenth"         } }
                ,{ Type.Base,  new PrefixEntry { prefix = "",      symbol = "",   quantity = "One"           } }
                ,{ Type.Deca,  new PrefixEntry { prefix = "Deca",  symbol = "da", quantity = "Ten"           } }
                ,{ Type.Hecto, new PrefixEntry { prefix = "Hecto", symbol = "h",  quantity = "Hundred"       } }
                ,{ Type.Kilo,  new PrefixEntry { prefix = "Kilo",  symbol = "k",  quantity = "Thousand"      } }
                ,{ Type.Mega,  new PrefixEntry { prefix = "Mega",  symbol = "M",  quantity = "Million"       } }
                ,{ Type.Giga,  new PrefixEntry { prefix = "Giga",  symbol = "G",  quantity = "Billion"       } }
                ,{ Type.Tera,  new PrefixEntry { prefix = "Tera",  symbol = "T",  quantity = "Trillion"      } }
                ,{ Type.Peta,  new PrefixEntry { prefix = "Peta",  symbol = "P",  quantity = "Quadrillion"   } }
                ,{ Type.Exa,   new PrefixEntry { prefix = "Exa",   symbol = "E",  quantity = "Quintillion"   } }
                ,{ Type.Zetta, new PrefixEntry { prefix = "Zetta", symbol = "Z",  quantity = "Sextillion"    } }
                ,{ Type.Yotta, new PrefixEntry { prefix = "Yotta", symbol = "Y",  quantity = "Septillion"    } }
            };

        public static int GetPower(Type type) { return (int)type; }
        public static string GetPrefix(Type type) { return table[type].prefix; }
        public static string GetSymbol(Type type) { return table[type].symbol; }
        public static string GetQuantity(Type type) { return table[type].quantity; }

        public static float GetScale(Type type) { return Mathf.Pow(10, type.GetPower()); } // todo: optimize

    }
    #endregion
}