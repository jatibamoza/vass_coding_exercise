/**********************************************************************************
 * @author: Javier Armando Tibamoza Cubillos
 * @email: javier.tibamoza.cubillos@gmail.com
 * @description		Class type Schedulable to program and process the data of the Web Services of Countries

 * Changes (version)
---------------------------------------------------------------------------------
No.     Date				Autor                           Description
---------------------------------------------------------------------------------
1.0     14/06/2025			Javier Tibamoza Cubillos(JATC)  Class creation.
***********************************************************************************/
global class VASS_CountriesApi_sch implements Schedulable{

    global void execute(SchedulableContext sc) {
        VASS_CountriesApi_bch batch = new VASS_CountriesApi_bch(); 
        System.enqueueJob(batch);
    }
}