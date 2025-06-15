/**********************************************************************************
 * @author: Javier Armando Tibamoza Cubillos
 * @email: javier.tibamoza.cubillos@gmail.com
 * @description		Class type Helper to process the data of the Web Services of Countries

 * Changes (version)
---------------------------------------------------------------------------------
No.     Date				Autor                           Description
---------------------------------------------------------------------------------
1.0     14/06/2025			Javier Tibamoza Cubillos(JATC)  Class creation.
***********************************************************************************/
public class VASS_CountriesApiHelper {
    /**
     * @description Method to call the Web Services of Countries
     * @return void
     */
    @future(callout=true)
    public static void callOutExecuteFuture(){
        callOutExecute();
    }
    
    @TestVisible
    private static void callOutExecute(){
        VASS_CallOutManager.sCallOutName = 'countries';
        HttpResponse response = VASS_CallOutManager.callOutExecute();
        System.debug('##Status Code from Countries API: ' + response.getStatusCode());
        if( response.getStatusCode() == 200 ){
            processDataResponse(response.getBody());
        }else{
            throw new VASS_BaseException('Error in API call: ' + response.getStatusCode() + ' - ' + response.getBody() );
        }
    }
    /** 
     * @description Method to process the data of the Web Services of Countries
     * @param String sBody
     * @return void
    */
    private static void processDataResponse(String sBody){
        List<VASS_Country__c> lCountry = new List<VASS_Country__c>();
        VASS_Country__c oCountry = new VASS_Country__c();
        List<VASS_CountriesWrapper> lCountryWrapper = VASS_CountriesWrapper.parse(sBody);
        lCountryWrapper =  validateExistData( lCountryWrapper );
        for( VASS_CountriesWrapper oWrapper : lCountryWrapper){
            oCountry = new VASS_Country__c();
            oCountry.Name = oWrapper.name;
            oCountry.VASS_Alpha2Code__c = oWrapper.alpha2Code;
            oCountry.VASS_Alpha3Code__c = oWrapper.alpha3Code;
            oCountry.VASS_CapitalCity__c = oWrapper.capital;
            oCountry.VASS_Region__c = oWrapper.region;
            if( oWrapper.regionalBlocs != null && oWrapper.regionalBlocs.size() > 0 ){
                for( VASS_CountriesWrapper.RegionalBloc oRegionalBloc : oWrapper.regionalBlocs){
                    oCountry.VASS_Acronyms__c = ( oCountry.VASS_Acronyms__c == null ? oRegionalBloc.acronym : oCountry.VASS_Acronyms__c + ' ,' + oRegionalBloc.acronym);
                }
            }
            lCountry.add(oCountry);
        }
        if( lCountry.size() > 0 ){
            try{
                upsert lCountry VASS_Alpha3Code__c;
            }catch(Exception e){
                throw new VASS_BaseException('Exception upsert: ' + e.getMessage());
            }
        }
    }
    /**
     * @description Method to validate if the data of the Web Services of Countries exists or has changed
     * @param List<VASS_CountriesWrapper>
     */
    private static List<VASS_CountriesWrapper> validateExistData(List<VASS_CountriesWrapper> lCountryWrapper){
        List<VASS_CountriesWrapper> lCountryWrapperChange = new List<VASS_CountriesWrapper>();
        Map<String, VASS_Country__c> mCountries = getSalesforceCountries();
        Boolean blChange = false;
        String sAcronyms = '';
        for( VASS_CountriesWrapper oWrapper : lCountryWrapper ){
            if( mCountries.containsKey(oWrapper.alpha3Code) ){
                VASS_Country__c oCountry = mCountries.get(oWrapper.alpha3Code);
                blChange = false;
                if( oCountry.Name != oWrapper.Name){blChange = true;}
                if( oCountry.VASS_Alpha2Code__c != oWrapper.alpha2Code){blChange = true;}
                if( oCountry.VASS_Alpha3Code__c != oWrapper.alpha3Code){blChange = true;}
                if( oCountry.VASS_CapitalCity__c != oWrapper.capital){blChange = true;}
                if( oCountry.VASS_Region__c != oWrapper.region){blChange = true;}
                if( oWrapper.regionalBlocs != null && oWrapper.regionalBlocs.size() > 0 ){
                    sAcronyms = '';
                    for( VASS_CountriesWrapper.RegionalBloc oRegionalBloc : oWrapper.regionalBlocs){
                        sAcronyms = ( sAcronyms == '' ? oRegionalBloc.acronym : sAcronyms + ' ,' + oRegionalBloc.acronym);
                    }
                    if( oCountry.VASS_Acronyms__c != sAcronyms ){blChange = true;}
                }
                if(blChange){lCountryWrapperChange.add(oWrapper);}
            }else{
                lCountryWrapperChange.add(oWrapper);
            }
        }
        return lCountryWrapperChange;
    }
    /**
     * @description Method to get the data of the Salesforce
     * @return Map<String, VASS_Country__c>
     */
    private static Map<String, VASS_Country__c> getSalesforceCountries(){
        Map<String, VASS_Country__c> mCountries = new Map<String, VASS_Country__c>();
        for( VASS_Country__c oCountry : [SELECT Id, Name, VASS_Alpha2Code__c, VASS_Alpha3Code__c, VASS_CapitalCity__c, VASS_Region__c, VASS_Acronyms__c FROM VASS_Country__c]){
            mCountries.put(oCountry.VASS_Alpha3Code__c, oCountry);
        }
        return mCountries;
    }
}