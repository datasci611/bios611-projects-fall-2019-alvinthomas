# Projects 3: Polyglot Analysis with Make, Docker, Python, and R
Author: Alvin Thomas, MSPH
Class: UNC BIOS 611, Fall 2019
github: @alvinthomas

# Background: Urban Ministries of Durham
![alt text](http://www.umdurham.org/assets/images/logo-new1.png "Urban Ministries Logo")

The Urban Ministries of Durham (UMD) fights poverty and homeless by offering food, shelter, and a future to neighbors in need. During the 2017-2018 fiscal year, UMD provided 54,378 nights of shelter to homeless neighbors (792 unique individuals), served 248,028 meals through the community cafe, and provided clothing and groceries to over 500 households per month. They ended homelessness for 243 individuals.

The three primary arms of UMD are the community shelter, community cafe, and food pantry/clothing closet. UMD is also engaged in community outreach and enrichment. About 80% of UMD's contributions (excluding in-kind donations) come from gifts and grants from foundations, the government, and communities of faith.

# Objective

Our objective is describe and contextualize UMD's emergency shelter services. In order to accomplish this aim, we will use Python and R scripts to clean and visualize the data. In order to establish reproducibility, we will employ Docker and Make to ensure future users can replicate our results.

# Audience

The report is meant for the staff of UMD. The scripts are meant for data scientists that will work with UMD in the future and build on our work.

# How to Run

This package uses Docker containerization.

If Docker is installed on your system, then simply `make project3` using the terminal.

# Data

## Source

The data can be found in the `data` repository. The datasets were provided by Urban Ministries of Durham. The original datasets are TSV files and were originally downloaded from [here](https://github.com/biodatascience/datasci611/tree/gh-pages/data/project2_2019).

## Contents

The contents of each dataset can be found at `data/README.md`.
