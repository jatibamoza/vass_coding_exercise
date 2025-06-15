/** 
 * @author: Javier Armando Tibamoza Cubillos
 * @email: javier.tibamoza.cubillos@gmail.com
 * @description: Class type Mock for the Web Services of Countries
 **/
public class VASS_CountriesMock implements HttpCalloutMock {
    public integer statusCode;
    public string message;
    
    public VASS_CountriesMock(Integer iStatusCode, String sMessage) {
        this.statusCode = iStatusCode;
        this.message = (sMessage== null ? '[' +
            '{' +
            '"name": "Germany",' +
            '"alpha2Code": "DE",' +
            '"alpha3Code": "DEU",' +
            '"capital": "Berlin",' +
            '"region": "Europe",' +
            '"regionalBlocs": [{' +
                '"acronym": "EU",' +
                '"name": "European Union"' +
            '}]' +
            '}' +
        ']' : sMessage);
    }

    public HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(message);
        res.setStatusCode(statusCode);
        return res;
    }
}