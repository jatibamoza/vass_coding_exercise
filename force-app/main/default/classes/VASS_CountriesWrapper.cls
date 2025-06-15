/**********************************************************************************
 * @author: Javier Armando Tibamoza Cubillos
 * @email: javier.tibamoza.cubillos@gmail.com
 * @description		Class type Wrapper of the Web Services of Countries

 * Changes (version)
---------------------------------------------------------------------------------
No.     Date				Autor                           Description
---------------------------------------------------------------------------------
1.0     14/06/2025			Javier Tibamoza Cubillos(JATC)  Class creation.
***********************************************************************************/
public class VASS_CountriesWrapper {
    public String name;
    public String alpha2Code;
    public String alpha3Code;
    public String capital;
    public String region;
    public List<RegionalBloc> regionalBlocs;

    public class RegionalBloc {
        public String acronym;
    }

    public static List<VASS_CountriesWrapper> parse(String sJson) {
        return (List<VASS_CountriesWrapper>) JSON.deserialize(sJson, List<VASS_CountriesWrapper>.class);
    }
}