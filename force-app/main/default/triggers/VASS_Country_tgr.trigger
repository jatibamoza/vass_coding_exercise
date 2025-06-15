trigger VASS_Country_tgr on VASS_Country__c (after insert, after update) {
    new VASS_CountryTriggerHandler().run();
}