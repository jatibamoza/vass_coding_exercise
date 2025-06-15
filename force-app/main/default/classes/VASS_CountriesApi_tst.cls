/**********************************************************************************
 * @author: Javier Armando Tibamoza Cubillos
 * @email: javier.tibamoza.cubillos@gmail.com
 * @description:    Class type Test for the clases VASS_CountriesApi_bch and VASS_CountriesApi_sch

 * Changes (version)
---------------------------------------------------------------------------------
No.     Date				Autor                           Description
---------------------------------------------------------------------------------
1.0     14/06/2025			Javier Tibamoza Cubillos(JATC)  Class creation.
***********************************************************************************/
@isTest
private class VASS_CountriesApi_tst {

    @isTest
    static void test_executeQueueable() {
        // Mock para evitar callout real
        Test.setMock(HttpCalloutMock.class, new VASS_CountriesMock(200, null));
        // Seteo del nombre del callout
        VASS_CallOutManager.sCallOutName = 'countries';
        Test.startTest();
        ID jobID = System.enqueueJob(new VASS_CountriesApi_bch());
        Test.stopTest();
        // Verificar que el país se haya insertado correctamente
        List<AsyncApexJob> jobInfo = [SELECT Status,NumberOfErrors FROM AsyncApexJob WHERE Id=:jobID];
        Assert.areEqual(1, jobInfo.size(), 'Expected job process.');
    }

    @isTest
    static void test_execute_schedulable() {
        // Establecer el mock y parámetros esperados
        Test.setMock(HttpCalloutMock.class, new VASS_CountriesMock(200, null));
        VASS_CallOutManager.sCallOutName = 'countries';
        // Instanciar la clase schedulable y ejecutarla directamente
        VASS_CountriesApi_sch job = new VASS_CountriesApi_sch();
        Test.startTest();
        String CRON_EXP = '0 0 6 * * ?';
        String jobID = System.schedule('VASS_CountriesApi_sch',
            CRON_EXP, 
            new VASS_CountriesApi_sch());
        Test.stopTest();
        // Verificar que el país fue insertado
        List<CronTrigger> ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        Assert.areEqual(1, ct.size(), 'Expected programmed job.');
    }
}