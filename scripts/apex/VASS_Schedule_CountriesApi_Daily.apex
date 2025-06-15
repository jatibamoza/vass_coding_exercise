/** 
 * @author: Javier Armando Tibamoza Cubillos
 * @date: 2023-10-30
 * @version: 1.0
 * @email: javier.tibamoza.cubillos@gmail.com
 * @decription:
 * Schedules a job to run the VASS_CountriesApi_sch class every day at 6:00 AM.
 * The job will execute the logic defined in the VASS_CountriesApi_sch class.
 * cronExp defines the schedule in a cron-like format.
 * Seconds Minutes Hours Day_of_month Month Day_of_week Year(optional)
    0        0       6     *            *     ?         (sin año = todos)
*/
String cronExp = '0 0 6 * * ?'; // 6:00 AM todos los días
String jobName = 'VASS_CountriesApiJob';

VASS_CountriesApi_sch job = new VASS_CountriesApi_sch();
System.schedule(jobName, cronExp, job);