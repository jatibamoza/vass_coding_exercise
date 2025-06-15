/**
 * @author Javier Tibamoza
 * @email: javier.tibamoza.cubillos@gmail.com
 * Get_CallOutSettings
 * 
 * This Apex utility class is responsible for retrieving configuration records
 * from the custom metadata type 'VASS_CallOut_Setting__mdt'. It provides methods 
 * to fetch settings by developer name or to retrieve all available configurations.
 * 
 * These settings are typically used to control external callout behavior dynamically,
 * such as endpoint URLs, HTTP methods, authentication types, and timeouts.
 * 
 * Use this class to access integration parameters in a centralized, metadata-driven way,
 * promoting flexibility and reducing hardcoded values in callout logic.
 * 
 * Example usage:
 *   VASS_CallOut_Setting__mdt setting = VASS_Get_CallOutSettings.getData('GetCountries');
**/
public class VASS_Get_CallOutSettings {
    public static VASS_CallOut_Setting__mdt getData(String callOutName){
        VASS_CallOut_Setting__mdt oCallOutSetting = VASS_CallOut_Setting__mdt.getInstance(callOutName);
        return oCallOutSetting;
    }
}