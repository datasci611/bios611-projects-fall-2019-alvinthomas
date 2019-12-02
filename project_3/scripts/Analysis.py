#!/usr/bin/env python
# coding: utf-8

# The purpose of this script is to read in and process data from the Urban Ministries of Durham (UMD) shelter.

# In[1]:


import numpy as np
import pandas as pd
import os


# In[2]:


c = os.getcwd()
c


# In[3]:


if os.path.exists(c + '/scripts') :
    # Change the current working Directory    
    os.chdir(c + '/scripts')
else:
    print("Can't change the Current Working Directory")   


# In[4]:


os.getcwd()


# In[5]:


c2 = os.getcwd()


# First, read in a dataset that contains demographic information on clients

# In[6]:


client = pd.read_csv('../data/CLIENT_191102.tsv', sep='\t')
list(client.columns) 


# Drop columns we do not intend to use.

# In[7]:


client.drop(['EE Provider ID', 'EE UID'], axis=1)


# Next, read in data about client history.

# In[8]:


entry = pd.read_csv('../data/EE_UDES_191102.tsv', sep='\t')
list(entry.columns) 


# In[9]:


entry = entry.filter(items=['Client Unique ID', 'Zip Code (of Last Permanent Address, if known)(1932)', 'Housing Status(2703)', 'Does the client have a disabling condition?(1935)', 'Covered by Health Insurance(4376)', 'Date of Birth(893)'])


# Merge client demographics and history.

# In[10]:


new_df = client.merge(entry, left_on='Client Unique ID', right_on='Client Unique ID')
new_df.head()


# The next dataset contains information on the current visit.

# In[11]:


visit = pd.read_csv('../data/ENTRY_EXIT_191102.tsv',sep='\t')
list(visit.columns) 


# In[12]:


visit = visit.drop(['Client ID','EE Provider ID', 'EE UID','Entry Exit Group Id','Entry Exit Household Id', 'Unnamed: 6','Housing Move-in Date(5584)','Destination','Entry Exit Type','Entry Exit Date Added','Entry Exit Date Updated'], axis=1)
list(visit.columns) 


# We will use date times to estimate the length of the visit

# In[13]:


visit['Entry'] =  pd.to_datetime(visit['Entry Date'], format='%m/%d/%Y')
visit['Exit'] =  pd.to_datetime(visit['Exit Date'], format='%m/%d/%Y')
visit['Total Nights'] = visit['Exit'] - visit['Entry']  # in days


# In[14]:


visit["Total Nights"] = visit["Total Nights"].apply(lambda row: row.days)
visit["Total Nights"]


# In[15]:


visit = visit.drop(['Entry Date','Exit Date'], axis=1)


# In[16]:


new_df = new_df.merge(visit, left_on='Client Unique ID', right_on='Client Unique ID')
new_df.head()


# This is our final product, ready for R.

# In[17]:


new_df.to_csv('../data/for_r.csv', encoding='utf-8', index=False)


# In[18]:


c3 = c2[:-8]
c3


# In[19]:


os.chdir(c3)

