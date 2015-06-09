# peddlerproj
######Archival/geographic metadata and scripts associated with NYU Libraries' Jewish Peddler Project.

###Contents
This repo contains all the various sources of metadata that are used to populate the Jewish Peddler Project in Omeka, as well as some associated Ruby scripts for executing the Omeka import and for using the Google geocoding API.

Three main sources of metadata are being integrated before the Omeka import event:

1. Data from our Zotero library, specified in Zotero's own fields
2. Topic, subject (individual), and geographic subject data that descibes each item from the Zotero library
3. WKT geometry corresponding to the present day location of the geographic subjects, which comes from the Google API

The three sources reflect three different processes of data generation, and CSV documents that combine all three sources (kept in will be produced periodically as new data is generated.
