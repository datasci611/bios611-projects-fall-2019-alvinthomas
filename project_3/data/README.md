# Data for Project 3
Author: Alvin Thomas, MSPH
Class: UNC BIOS 611, Fall 2019
github: @alvinthomas

# Data

## Source

The dataset was provided by Urban Ministries of Durham. The original datasets are TSV files and was originally downloaded from [https://github.com/biodatascience/datasci611/tree/gh-pages/data/project2_2019](here).

## Filename: CLIENT_191102.tsv

Variable | Type | Used in analysis
---|---|---
EE Provider ID | String | Yes
EE UID | Numeric | Yes
Client Unique ID | String | Yes
Client ID | Numeric  | Yes
Client Age at Entry | Numeric | No
Client Age at Exit | Numeric | No
Client Gender | String | No
Client Primary Race | String | No
Client Ethnicity | String | No
Client Veteran Status | String | No

## Filename: DISABILITY_ENTRY_191102.tsv

Variable | Description | Used in analysis
---|---|---
EE Provider ID | String | Yes
EE UID | Numeric | Yes
Client Unique ID | String | Yes
Client ID | Numeric  | Yes
Disability Type (Entry) | String | No
Disability Start Date (Entry) | Date | No
Disability End Date (Entry) | Date | No
Provider (417-provider) | String | No
Recordset ID (417-recordset_id) | Numeric | No
Date Added (417-date_added) | Numeric | No

## Filename: DISABILITY_EXIT_191102.tsv

Variable | Description | Used in analysis
---|---|---
EE Provider ID | String | Yes
EE UID | Numeric | Yes
Client Unique ID | String | Yes
Client ID | Numeric  | Yes
Disability Determination (Exit) | String | No
Disability Type (Exit) | String | No
Disability Start Date (Exit) | Date | No
Disability End Date (Exit) | Date | No
Provider (417-provider) | String | No
Recordset ID (417-recordset_id) | Numeric | No
Date Added (417-date_added) | Numeric | No

## Filename: EE_REVIEWS_191102.tsv

Variable | Description | Used in analysis
---|---|---
EE Provider ID | String | Yes
EE UID | Numeric | Yes
Client Unique ID | String | Yes
Client ID | Numeric  | Yes
Entry Exit Review Uid | Numeric | No
Entry Exit Review Point in Time Type | String | No
Entry Exit Review Date | Date | No
Entry Exit Review Date Updated | Date | No
Entry Exit Review Provider Updating | String | No

## Filename: EE_UDES_191102.tsv

Variable | Description | Used in analysis
---|---|---
EE Provider ID | String | Yes
EE UID | Numeric | Yes
Client Unique ID | String | Yes
Client ID | Numeric  | Yes
Client Location(4378) | String | No
Zip Code (of Last Permanent Address, if known)(1932) | Numeric | No
Relationship to Head of Household(4374) | String | No
Prior Living Situation(43) | String | No
Length of Stay in Previous Place(1934) | String | No
Did you stay less than 7 nights?(5164) | String | No
Did you stay less than 90 days?(5163) | String | No
On the night before did you stay on the streets, ES or SH?(5165) | String | No
Regardless of where they stayed last night - Number of times the client has been on the streets, in ES, or SH in the past three years including today(5167) | String | No
Total number of months homeless on the street, in ES or SH in the past three years(5168) | String | No
Housing Status(2703) | String | No
Does the client have a disabling condition?(1935) | String | No
Covered by Health Insurance(4376) | String | No
Domestic violence victim/survivor(341) | String | No
If yes for Domestic violence victim/survivor, when experience occurred(1917) | String | No
Date of Birth(893) | Date | No

## Filename: ENTRY_EXIT_191102.tsv

Variable | Description | Used in analysis
---|---|---
EE Provider ID | String | Yes
EE UID | Numeric | Yes
Client Unique ID | String | Yes
Client ID | Numeric  | Yes
Entry Exit Group Id | Numeric | No
Entry Exit Household Id | Numeric | No
Blank | Numeric | No
Entry Date | Date | No
Housing Move-in Date(5584) | Date | No
Exit Date | Date | No
Destination | String | No
Reason for Leaving | String | No
Entry Exit Type | String | No
Entry Exit Date Added | Date | No
Entry Exit Date Updated | Date | No

## Filename: HEALTH_INS_ENTRY_191102.tsv

Variable | Description | Used in analysis
---|---|---
EE Provider ID | String | Yes
EE UID | Numeric | Yes
Client Unique ID | String | Yes
Client ID | Numeric  | Yes
Covered (Entry) | String | No
Health Insurance Type (Entry) | String | No
Health Insurance Start Date (Entry) | Date | No
Health Insurance End Date (Entry) | Date | No
Provider (4307-provider) | String | No
Recordset ID (4307-recordset_id) | Numeric | No
Date Added (4307-date_added) | Date | No

## Filename: HEALTH_INS_EXIT_191102.tsv

Variable | Description | Used in analysis
---|---|---
EE Provider ID | String | Yes
EE UID | Numeric | Yes
Client Unique ID | String | Yes
Client ID | Numeric  | Yes
Covered (Exit) | String | No
Health Insurance Type (Exit) | String | No
Health Insurance Start Date (Exit) | Date | No
Health Insurance End Date (Exit) | Date | No
Recordset ID (4307-recordset_id) | Numeric | No
Provider (4307-provider) | String | No
Date Added (4307-date_added) | Date | No

## Filename: INCOME_ENTRY_191102.tsv

Variable | Description | Used in analysis
---|---|---
EE Provider ID | String | Yes
EE UID | Numeric | Yes
Client Unique ID | String | Yes
Client ID | Numeric  | Yes
Receiving Income (Entry) | String | No
Income Source (Entry) | String | No
Monthly Amount (Entry) | String | No
Income Start Date (Entry) | Date | No
Income End Date (Entry) | Date | No
Recordset ID (140-recordset_id) | Numeric | No
Provider (140-provider) | String | No
Date Added (140-date_added) | Date | No

## Filename: INCOME_EXIT_191102.tsv

Variable | Description | Used in analysis
---|---|---
EE Provider ID | String | Yes
EE UID | Numeric | Yes
Client Unique ID | String | Yes
Client ID | Numeric  | Yes
ReceivingIncome (Exit) | String | No
Source of Income (Exit) | String | No
Monthly Amount (Exit) | String | No
Income Start Date (Exit) | Date | No
Income End Date (Exit) | Date | No
Recordset ID (140-recordset_id) | Numeric | No
Provider (140-provider) | String | No
Date Added (140-date_added) | Date | No

## Filename: NONCASH_ENTRY_191102.tsv

Variable | Description | Used in analysis
---|---|---
EE Provider ID | String | Yes
EE UID | Numeric | Yes
Client Unique ID | String | Yes
Client ID | Numeric  | Yes
Receiving Benefit (Entry) | String | No
Non-Cash Source (Entry) | String | No
Non-Cash Start Date (Entry) | Date | No
Non-Cash End Date (Entry) | Date | No
Recordset ID (2704-recordset_id) | Numeric | No
Provider (2704-provider) | String | No
Date Added (2704-date_added) | Date | No

## Filename: NONCASH_EXIT_191102.tsv

Variable | Description | Used in analysis
---|---|---
EE Provider ID | String | Yes
EE UID | Numeric | Yes
Client Unique ID | String | Yes
Client ID | Numeric  | Yes
Receiving Benefit (Exit) | String | No
Non-Cash Source (Exit) | String | No
Non-Cash Start Date (Exit) | Date | No
Non-Cash End Date (Exit) | Date | No
Recordset ID (2704-recordset_id) | Numeric | No
Provider (2704-provider) | String | No
Date Added (2704-date_added) | Date | No

## Filename: PROVIDER_191102.tsv

Variable | Description | Used in analysis
---|---|---
EE Provider ID | String | Yes
EE UID | Numeric | Yes
CoC Code | String | No
Program Type Code | String | No
Provider County | String | No
Entry Exit Provider Area | String | No

## Filename: VI_SPDAT_FAM_V2_191102.tsv

Variable | Description | Used in analysis
---|---|---
Entry Exit Provider Id | String | Yes
EE UID | Numeric | Yes
Client Unique ID | String | Yes
Client ID | Numeric  | Yes
Recordset ID (4749-recordset_id) | Numeric | No
Start Date(4750) | Date | No
A. HISTORY OF HOUSING AND HOMELESSNESS(4824) | Numeric | No
B. RISKS(4825) | Numeric | No
C. SOCIALIZATION & DAILY FUNCTIONS(4826) | Numeric | No
D. WELLNESS(4827) | Numeric | No
E. FAMILY UNIT(4828) | Numeric | No
PRE-SURVEY(4823) | Numeric | No
GRAND TOTAL(4829) | Numeric | No
Provider (4749-provider) | String | No
Date Added (4749-date_added) | Date | No

## Filename: VI_SPDAT_IND_V2_191102.tsv

Variable | Description | Used in analysis
---|---|---
EE Provider ID | String | Yes
EE UID | Numeric | Yes
Client Unique ID | String | Yes
Client ID | Numeric  | Yes
Recordset ID (4621-recordset_id) | Numeric | No
Start Date(4622) | Date | No
A. HISTORY OF HOUSING AND HOMELESSNESS(4666) | Numeric | No
B. RISKS(4667) | Numeric | No
C. SOCIALIZATION & DAILY FUNCTIONS(4668) | Numeric | No
D. WELLNESS(4669) | Numeric | No
PRE-SURVEY(4665) | Numeric | No
GRAND TOTAL(4670) | Numeric | No
Provider (4621-provider) | String | No
Date Added (4621-date_added) | Date | No

## Filename: VI_SPDAT_V1_191102.tsv

Variable | Description | Used in analysis
---|---|---
EE Provider ID | String | Yes
EE UID | Numeric | Yes
Client Unique ID | String | Yes
Client ID | Numeric  | Yes
Recordset ID (4110-recordset_id) | Numeric | No
Start Date(4111) | Date | No
A. HISTORY OF HOUSING AND HOMELESSNESS(4177) | Numeric | No
B. RISKS(4178) | Numeric | No
C. SOCIALIZATION & DAILY FUNCTIONING(4179) | Numeric | No
D. WELLNESS(4180) | Numeric | No
GENERAL INFORMATION(4176) | Numeric | No
PRE-SCREEN TOTAL(4181) | Numeric | No
GRAND TOTAL (ADJUSTED FOR v2.0)(4671) | Numeric | No
Provider (4110-provider) | String | No
Date Added (4110-date_added) | Date | No
