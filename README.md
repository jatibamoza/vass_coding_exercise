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
```plaintext
force-app/
├── main/
│   └── default/
│       ├── classes/           # Apex classes (logic, helpers, exceptions)
│       ├── triggers/          # Trigger and trigger handlers
│       ├── flows/             # Flow metadata
│       ├── objects/           # Custom objects and fields (e.g., VASS_Country__c)
│       └── settings/          # Custom metadata types (e.g., CallOut_Settings__mdt)
├── manifest/                  # Package.xml for deployment or retrieval
├── scripts/
│   └── apex/                  # Automation scripts (e.g., VASS_Schedule_CountriesApi_Daily.apex)
└── README.md                  # Project documentation 
```

## ⏰ Schedule Execution
The daily execution of the scheduled job can be configured using the script:
VASS_Schedule_CountriesApi_Daily.apex

This script schedules the VASS_CountriesApi_sch class to run every day at 6:00 AM using Salesforce's built-in System.schedule() method and a CRON expression.

## 🧑‍💻 Developed by

**Javier Armando Tibamoza Cubillos**  
📧 [javier.tibamoza.cubillos@gmail.com](mailto:javier.tibamoza.cubillos@gmail.com)
