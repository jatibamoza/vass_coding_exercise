//VASS_CallOutManager.sCallOutName = 'countries';
//HttpResponse response = VASS_CallOutManager.callOutExecute();
//System.debug( '##getStatusCode: '+response.getStatusCode() );
//System.debug( '##getBody: '+response.getBody() );

VASS_CountriesApi_bch job = new VASS_CountriesApi_bch();
System.enqueueJob(job);

//DELETE [SELECT Id FROM VASS_Country__c];