/**
 * @author Javier Tibamoza
 * @email: javier.tibamoza.cubillos@gmail.com
 * CallOutManager
 * 
 * This Apex class provides a generic and configurable mechanism to perform HTTP callouts
 * based on parameters defined in the custom metadata type 'CallOut_Settings__mdt'.
 * It centralizes the logic for preparing requests, handling authentication, setting headers,
 * managing timeouts, and processing responses.
 * 
 * Use this class to standardize external service integrations, reduce code duplication,
 * and allow for easier maintenance and updates through metadata-driven configuration.
 * 
 * Key Features:
 * - Dynamic endpoint and path resolution
 * - Configurable HTTP method and headers
 * - Timeout handling
 * 
 * Example usage:
 *   HttpResponse res = VASS_CallOutManager.callOutExecute('GetCountries');
 */
public class VASS_CallOutManager {
    private static VASS_CallOut_Setting__mdt oCallOutSetting;

    public static string sCallOutName {
        get {
            return ( sCallOutName == null ? '' : sCallOutName);
        }
        set;
    }
    
    public static HttpResponse callOutExecute(){
        oCallOutSetting = VASS_Get_CallOutSettings.getData(sCallOutName);
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:' + oCallOutSetting.VASS_Named_Credential__c + oCallOutSetting.VASS_Path__c + '?access_key=' + oCallOutSetting.VASS_ApiKey__c );
        req.setMethod(oCallOutSetting.VASS_HTTP_Method__c);
        req.setTimeout(Integer.valueOf(oCallOutSetting.VASS_Timeout__c));
        HttpResponse res = http.send(req);
        return res;
    }
}