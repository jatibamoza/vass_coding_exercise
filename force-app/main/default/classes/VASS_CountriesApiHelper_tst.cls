@isTest
private class VASS_CountriesApiHelper_tst {

    @isTest
    static void test_callOutExecuteFuture_insert() {
        // Set mock
        Test.setMock(HttpCalloutMock.class, new VASS_CountriesMock(200,null));
        Test.startTest();
        VASS_CallOutManager.sCallOutName = 'countries';
        VASS_CountriesApiHelper.callOutExecuteFuture();
        Test.stopTest();
        List<VASS_Country__c> countries = [
            SELECT Name, VASS_Alpha2Code__c, VASS_Alpha3Code__c, VASS_CapitalCity__c, VASS_Region__c, VASS_Acronyms__c 
            FROM VASS_Country__c 
            WHERE VASS_Alpha3Code__c = 'DEU'];
        Assert.areEqual(1, countries.size(), 'Expected one country to be inserted');
        Assert.areEqual('Germany', countries[0].Name, 'Expected country data to match Germany');
        Assert.areEqual('EU', countries[0].VASS_Acronyms__c, 'Expected country data to match EU');
    }

    @isTest
    static void test_callOutExecuteFuture_update() {
        // Pre-insertar país para forzar validación y update
        insert new VASS_Country__c(
            Name = 'Alemania',
            VASS_Alpha2Code__c = 'XX',
            VASS_Alpha3Code__c = 'DEU',
            VASS_CapitalCity__c = 'Old',
            VASS_Region__c = 'Other',
            VASS_Acronyms__c = 'OLD'
        );
        Test.setMock(HttpCalloutMock.class, new VASS_CountriesMock(200,null));
        Test.startTest();
        VASS_CallOutManager.sCallOutName = 'countries';
        VASS_CountriesApiHelper.callOutExecuteFuture();
        Test.stopTest();
        VASS_Country__c updated = [SELECT Name, VASS_Alpha2Code__c, VASS_CapitalCity__c, VASS_Region__c, VASS_Acronyms__c FROM VASS_Country__c WHERE VASS_Alpha3Code__c = 'DEU'];
        Assert.areEqual('Germany', updated.Name, 'Expected country name to be updated to Germany');
        Assert.areEqual('DE', updated.VASS_Alpha2Code__c, 'Expected Alpha2Code to be DE');
        Assert.areEqual('Berlin', updated.VASS_CapitalCity__c, 'Expected capital city to be Berlin');
        Assert.areEqual('Europe', updated.VASS_Region__c, 'Expected region to be Europe');
        Assert.areEqual('EU', updated.VASS_Acronyms__c, 'Expected acronyms to include EU');
    }

    @isTest
    static void test_callOutExecute_error() {
        // Mock con error 500
        Test.setMock(HttpCalloutMock.class, new VASS_CountriesMock(500,'Internal Server Error'));
        Test.startTest();
        VASS_CallOutManager.sCallOutName = 'countries';
        try {
            VASS_CountriesApiHelper.callOutExecute();
            Assert.fail('Expected exception not thrown');
        } catch (VASS_BaseException ex) {
            Assert.isTrue(ex.getMessage().contains('Error in API call'), 'Expected error message in exception');
        }
        Test.stopTest();
    }
}