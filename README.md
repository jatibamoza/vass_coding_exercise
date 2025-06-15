# VASS Countries API Integration

This Salesforce DX project implements an integration with the [CountryLayer API](https://countrylayer.com/).  
It enables Salesforce to store, update, and associate country information with Leads automatically.

## 🔧 Key Features

- ✅ Daily scheduled callout to CountryLayer API
- ✅ Stores country details: name, ISO codes, capital, region, acronyms
- ✅ Trigger logic updates Leads based on country match (by name or Alpha-3 code)
- ✅ Validation Rule to restrict Lead Owner change unless key fields are filled
- ✅ Flow automation to track Lead Owner assignment timestamps
- ✅ Metadata-driven configuration via Custom Metadata Type (`CallOut_Settings__mdt`)
- ✅ Full test coverage and deployment-ready code

## 🧪 Technologies Used

- Apex (with `Schedulable`, `Queueable`, `Future`, `HttpCalloutMock`)
- Salesforce Custom Metadata
- Salesforce Flows and Validation Rules
- Git + VSCode + SFDX (Salesforce CLI)

## 📁 Project Structure
force-app/
├── main/
│   └── default/
│       ├── classes/
│       ├── triggers/
│       ├── flows/
│       ├── objects/
│       └── settings/
├── manifest/
├── scripts/
│   └── apex/
└── README.md

## ⏰ Schedule Execution
The daily execution of the scheduled job can be configured using the script:
VASS_Schedule_CountriesApi_Daily.apex

This script schedules the VASS_CountriesApi_sch class to run every day at 6:00 AM using Salesforce's built-in System.schedule() method and a CRON expression.

## 🧑‍💻 Developed by

**Javier Armando Tibamoza Cubillos**  
📧 [javier.tibamoza.cubillos@gmail.com](mailto:javier.tibamoza.cubillos@gmail.com)