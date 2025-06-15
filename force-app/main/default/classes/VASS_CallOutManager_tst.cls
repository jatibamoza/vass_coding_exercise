/**
 * @author: Javier Armando Tibamoza Cubillos
 * @email: javier.tibamoza.cubillos@gmail.com
 * @description: Clase de prueba unitaria para la clase VASS_CallOutManager
*/
@IsTest(SeeAllData=true)
private class VASS_CallOutManager_tst {
    // Mock que simula la respuesta del callout
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('[{"name":"Germany","alpha2Code":"DE","alpha3Code":"DEU"}]');
            res.setStatusCode(200);
            return res;
        }
    }
    @isTest
    static void testCallOutExecute() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Test.startTest();
        VASS_CallOutManager.sCallOutName = 'countries';
        HttpResponse response = VASS_CallOutManager.callOutExecute();
        Test.stopTest();
        Assert.areEqual(200, response.getStatusCode(), 'Expected HTTP 200 status code');
        Assert.isTrue(response.getBody().contains('Germany'), 'Expected Germany in response body');
    }
}