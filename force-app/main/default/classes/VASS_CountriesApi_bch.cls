/**********************************************************************************
 * @author: Javier Armando Tibamoza Cubillos
 * @email: javier.tibamoza.cubillos@gmail.com
 * @description		Class type Queueable to process the data of the Web Services of Countries

 * Changes (version)
---------------------------------------------------------------------------------
No.     Date				Autor                           Description
---------------------------------------------------------------------------------
1.0     14/06/2025			Javier Tibamoza Cubillos(JATC)  Class creation.
***********************************************************************************/
public class VASS_CountriesApi_bch implements Queueable, Database.AllowsCallouts {
    public VASS_CountriesApi_bch() {

    }

    public void execute(QueueableContext context){
        VASS_CountriesApiHelper.callOutExecuteFuture();
    }
}