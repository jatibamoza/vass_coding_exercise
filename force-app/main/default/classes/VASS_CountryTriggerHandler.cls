/**********************************************************************************
 * @author: Javier Armando Tibamoza Cubillos
 * @email: javier.tibamoza.cubillos@gmail.com
 * @description		Class to manage trigger of the object VASS_Country__c

 * Changes (version)
---------------------------------------------------------------------------------
No.     Date				Autor                           Description
---------------------------------------------------------------------------------
1.0     14/06/2025			Javier Tibamoza Cubillos(JATC)  Class creation.
***********************************************************************************/
public class VASS_CountryTriggerHandler extends TriggerHandler{
    private Map<String,VASS_Country__c> mCountries3Code;
    private Map<String,VASS_Country__c> mCountriesName;

    public VASS_CountryTriggerHandler() {
        mCountries3Code = new Map<String,VASS_Country__c>();
        mCountriesName = new Map<String,VASS_Country__c>();
    }

    public override void afterInsert() {
        setMapCountries((List<VASS_Country__c>) Trigger.new);
        updateLeadCountryField();
    }

    public override void afterUpdate() {
        setMapCountries((List<VASS_Country__c>) Trigger.new);
        updateLeadCountryField();
    }

    public void setMapCountries(List<VASS_Country__c> lCountry){
        for(VASS_Country__c oCountry : lCountry ) {
            mCountries3Code.put(oCountry.VASS_Alpha3Code__c, oCountry);
            mCountriesName.put(oCountry.Name, oCountry);
        }
    }

    private List<Lead> getLeadByCountry(){
        return [
            SELECT Id, Name, Country, VASS_Country__c
            FROM Lead
            WHERE Country IN: mCountries3Code.keySet() or Country IN: mCountriesName.keySet() ];
    }

    private void updateLeadCountryField(){
        List<Lead> lLead = getLeadByCountry();
        List<Lead> lLeadUpdate = new List<Lead>();
        for( Lead oLead : lLead ){
            if( mCountries3Code.containsKey(oLead.Country) ) {
                oLead.VASS_Country__c = mCountries3Code.get(oLead.Country).Id;
                lLeadUpdate.add(oLead);
            }else if( mCountriesName.containsKey(oLead.Country) ){
                oLead.VASS_Country__c = mCountriesName.get(oLead.Country).Id;
                lLeadUpdate.add(oLead);
            }
        }
        if(lLeadUpdate.size() > 0){
            try{
                update lLeadUpdate;
            }catch(Exception e){	
                throw new VASS_BaseException('Exception update: ' + e.getMessage());
            }
        }
    }
}