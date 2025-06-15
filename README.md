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

Apex Classes
- TriggerHandler
- TriggerHandler_tst
- VASS_BaseException
- VASS_BaseException_tst
- VASS_CallOutManager
- VASS_CallOutManager_tst
- VASS_CountriesApiHelper
- VASS_CountriesApiHelper_tst
- VASS_CountriesApi_bch
- VASS_CountriesApi_sch
- VASS_CountriesApi_tst
- VASS_CountriesWrapper
- VASS_CountryTriggerHandler
- VASS_CountryTriggerHandler_tst
- VASS_Get_CallOutSettings
- VASS_CountriesMock

Apex Trigger
- VASS_Country_tgr

Custom Fields
- Lead → VASS_Country3Code__c
- Lead → VASS_Country__c
- Lead → VASS_OwnerSince__c
- Lead → VASS_Region__c
- VASS_CallOut_Setting__mdt → VASS_ApiKey__c
- VASS_CallOut_Setting__mdt → VASS_Domain__c
- VASS_CallOut_Setting__mdt → VASS_HTTP_Method__c
- VASS_CallOut_Setting__mdt → VASS_Is_Active__c
- VASS_CallOut_Setting__mdt → VASS_Named_Credential__c
- VASS_CallOut_Setting__mdt → VASS_Path__c
- VASS_CallOut_Setting__mdt → VASS_Timeout__c
- VASS_Country__c → VASS_Acronyms__c
- VASS_Country__c → VASS_Alpha2Code__c
- VASS_Country__c → VASS_Alpha3Code__c
- VASS_Country__c → VASS_CapitalCity__c
- VASS_Country__c → VASS_Region__c

Custom Metadata Records
- VASS_CallOut_Setting.countries

Custom Objects
- Lead
- VASS_CallOut_Setting__mdt
- VASS_Country__c

Custom Object Translations
- VASS_CallOut_Setting__mdt-es
- VASS_Country__c-es

Duplicate Rules
- Lead.Standard_Lead_Duplicate_Rule

External Credentials
- VASS_CountryLayerExternalCredential

Flows
- Lead_After_Update

Flow Definitions
- Lead_After_Update

Layouts
- Lead - Lead Layout
- Lead - Lead (Marketing) Layout
- Lead - Lead (Sales) Layout
- Lead - Lead (Support) Layout
- VASS_CallOut_Setting__mdt - Formato CallOut Setting
- VASS_Country__c - Formato Country

List Views
- Lead.AllOpenLeads
- Lead.MyUnreadLeads
- Lead.TodaysLeads
- Lead.ViewCustom1
- Lead.ViewCustom2

Matching Rules
- Lead.Standard_Lead_Match_Rule_v1_0

Matching Rules (Container)
- Lead

Named Credentials
- VASS_CountryLayerNamedCred

Profiles (includes standard, custom, partner, and community profiles)

Remote Site Settings
- countrylayer

Validation Rules
- Lead.VASS_Change_Owner
```

## ⏰ Schedule Execution
The daily execution of the scheduled job can be configured using the script:
VASS_Schedule_CountriesApi_Daily.apex

This script schedules the VASS_CountriesApi_sch class to run every day at 6:00 AM using Salesforce's built-in System.schedule() method and a CRON expression.

## 🧑‍💻 Developed by

**Javier Armando Tibamoza Cubillos**  
📧 [javier.tibamoza.cubillos@gmail.com](mailto:javier.tibamoza.cubillos@gmail.com)
