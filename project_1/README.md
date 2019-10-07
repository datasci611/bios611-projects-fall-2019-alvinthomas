# Projects 1: Data Analysis with the Tidyverse
Author: Alvin Thomas, MSPH
Class: UNC BIOS 611, Fall 2019
github: @alvinthomas

# Background: Urban Ministries of Durham
![alt text](http://www.umdurham.org/assets/images/logo-new1.png "Urban Ministries Logo")

The Urban Ministries of Durham (UMD) fights poverty and homeless by offering food, shelter, and a future to neighbors in need. During the 2017-2018 fiscal year, UMD provided 54,378 nights of shelter to homeless neighbors (792 unique individuals), served 248,028 meals through the community cafe, and provided clothing and groceries to over 500 households per month. They ended homelessness for 243 individuals.

The three primary arms of UMD are the community shelter, community cafe, and food pantry/clothing closet. UMD is also engaged in community outreach and enrichment. About 80% of UMD's contributions (excluding in-kind donations) come from gifts and grants from foundations, the government, and communities of faith.

# Research Question
1) How have UMD's core services changed over time?
* We focus on the distribution of food, bus tickets, school kits, hygiene kits, and financial support.
* This aim will also inform future use of these variables.

# Approach

We will use data provided by UMD and plot trends over calendar time. Given the need for UMD to present data for annual reports, we will also provide numbers using a fiscal calendar.


# Organization

This project repo is divided into three subdirectories.
* `data` houses the data for the analysis.
* `results` contains two documents: a client-facing report and a analyst-facing report. Figures are also stored here.
* `scripts` contain the raw scripts for processing the data and producing the files found in Results.

# Data

The dataset was provided by UMD and can be found under the `data` repository. The original datasets are TSV files

## Filename: UMD_Services_Provided_20190719.tsv

This dataset contains 18 variables over 79838 observations.

Variable | Description | Used in Analysis
---|---|---
Date | Date service was provided | Yes
Client File Number | Family/Individual identifier | No
Client File Merge | Separate files created for family and then merged | No
Bus Tickets | Bus tickets provided, service discontinued | No
Notes of Service | Text notes of service | No
Food Provided For | Number of people provided food | Yes
Food Pounds | Food weight in pounds | Yes
Clothing Items | Articles of clothing provided | Yes
Diapers | Number of diapers | Yes
School Kits | Number of school kits | Yes
Hygiene Kits | Number of hygiene kits | Yes
Referrals | Referrals to outside organizations | No
Financial Support | Amount of money | No
Type of Bill Paid | Type of bill paid | No
Payer of Support | Payer of bill/financial support | No
Field1 | Empty Variable | No
Field2 | Empty Variable | No
Field3 | Empty Variable | No

## Filename: UMD_Services_Provided_metadata_20190719.tsv

The purpose of this dataset is to provide the analyst with descriptions of the primary dataset. When possible (7/13), there is a description of a variable found in the primary dataset. This dataset contains 2 variables over 13 observations.

Variable | Description
---|---
Var1 | Name of Variable
Var2 | Description of variable, NA indicates no information available
