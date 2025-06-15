@isTest
private class VASS_CountryTriggerHandler_tst {
    @isTest
    static void test_afterInsert_updatesLead_byAlpha3Code() {
        // Crear Lead que coincida por alpha3Code
        Lead lead = new Lead(
            LastName = 'Alpha3 Test',
            Company = 'TestCo',
            Country = 'DEU' // Alpha3Code que vamos a insertar
        );
        insert lead;
        // Insertar país con Alpha3Code = 'DEU'
        VASS_Country__c country = new VASS_Country__c(
            Name = 'Germany',
            VASS_Alpha2Code__c = 'DE',
            VASS_Alpha3Code__c = 'DEU',
            VASS_CapitalCity__c = 'Berlin',
            VASS_Region__c = 'Europe'
        );
        insert country;
        // Verificar que el Lead fue actualizado
        Lead updatedLead = [SELECT Id, VASS_Country__c FROM Lead WHERE Id = :lead.Id];
        Assert.areEqual(country.Id, updatedLead.VASS_Country__c, 'El campo VASS_Country__c debería haberse actualizado por Alpha3Code');
    }

    @isTest
    static void test_afterInsert_updatesLead_byName() {
        // Crear Lead que coincida por nombre del país
        Lead lead = new Lead(
            LastName = 'ByName Test',
            Company = 'TestCo',
            Country = 'Spain'
        );
        insert lead;
        // Insertar país con Name = 'Spain'
        VASS_Country__c country = new VASS_Country__c(
            Name = 'Spain',
            VASS_Alpha2Code__c = 'ES',
            VASS_Alpha3Code__c = 'ESP',
            VASS_CapitalCity__c = 'Madrid',
            VASS_Region__c = 'Europe'
        );
        insert country;
        // Verificar que el Lead fue actualizado
        Lead updatedLead = [SELECT Id, VASS_Country__c FROM Lead WHERE Id = :lead.Id];
        Assert.areEqual(country.Id, updatedLead.VASS_Country__c, 'El campo VASS_Country__c debería haberse actualizado por nombre');
    }

    @isTest
    static void test_noMatch_doesNotUpdateLead() {
        Lead lead = new Lead(
            LastName = 'NoMatch Test',
            Company = 'TestCo',
            Country = 'Narnia'
        );
        insert lead;
        VASS_Country__c country = new VASS_Country__c(
            Name = 'Germany',
            VASS_Alpha2Code__c = 'DE',
            VASS_Alpha3Code__c = 'DEU'
        );
        insert country;
        Lead unchangedLead = [SELECT Id, VASS_Country__c FROM Lead WHERE Id = :lead.Id];
        Assert.areEqual(null, unchangedLead.VASS_Country__c, 'El campo VASS_Country__c no debería haberse actualizado porque no hay coincidencia');
    }
}