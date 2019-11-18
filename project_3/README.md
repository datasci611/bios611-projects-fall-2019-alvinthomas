# Projects 3: Polyglot Analysis with Make, Docker, Python, and R
Author: Alvin Thomas, MSPH
Class: UNC BIOS 611, Fall 2019
github: @alvinthomas

# Background: Urban Ministries of Durham
![alt text](http://www.umdurham.org/assets/images/logo-new1.png "Urban Ministries Logo")

The Urban Ministries of Durham (UMD) fights poverty and homeless by offering food, shelter, and a future to neighbors in need. During the 2017-2018 fiscal year, UMD provided 54,378 nights of shelter to homeless neighbors (792 unique individuals), served 248,028 meals through the community cafe, and provided clothing and groceries to over 500 households per month. They ended homelessness for 243 individuals.

The three primary arms of UMD are the community shelter, community cafe, and food pantry/clothing closet. UMD is also engaged in community outreach and enrichment. About 80% of UMD's contributions (excluding in-kind donations) come from gifts and grants from foundations, the government, and communities of faith.

# Objective

Our objective is to create an interactive tool that will help UMD access some of their data on food pantry/clothing closet services. The tool will allow for user-driven analytic choices (e.g. how to handle outliers) and present data in a clean, attractive format appropriate for reports.

Our objective is describe and contextualize UMD's emergency shelter services. In order to accomplish this aim, we will use Python and R scripts to clean and visualize the data. In order to establish reproducibility, we will employ Docker and Make to ensure future users can replicate our results.

# Audience

The tool is meant for the staff of UMD. We will also incorporate information that could be useful for a data scientist that may want to expand or modify our tool. Our reproducible tools will be useful to data scientists that would like to build on our work.

# Data

## Source

The dataset was provided by UMD and can be found under the `data` repository. The original datasets are TSV files.
