# NZCrashSatistics-PowerBI
A dashboard based on the New Zealand crash statistics from 2000-2023 using SQL and PowerBI. Data is recorded by the NZ Police Department and then handed to the Ministry of Transport. Public access to data collected can be found on the official Ministry of transport website for public viewing. 

Project Limitations: Although there was more than a sufficient amount of data, the data set only contained the year of the crash (no month or standardised date). Additionally, no data on civilians was available like other global public crash datasets. Therefore, I found data was quite limited in creating a comprehensive dashboard.
 

Prepare:
- Data used downloaded from https://www.transport.govt.nz/statistics-and-insights/safety-annual-statistics/
- Data was imported into Microsoft SQL Server


Process:
Data that was needed for visualisation was extracted and processed using Microsoft SQL Server (please refer to attached script for more details)


Analyse/Share:
- Synoptic panel by Okviz was used to create a regional map of New Zealand for visualization
- Finally, an interactive dashboard was made using Power BI. 

Link to final product: https://app.powerbi.com/view?r=eyJrIjoiOGMwN2M3OGMtOWI1Yy00ZWU1LTk2MmUtMTg2NWJhM2FiZmJkIiwidCI6ImJiMDc1YzM5LWIyMjItNGNhMy05MjMzLWZmYjUwYjY5NGFjOCJ9


Improvements/Changes needed (when time permits):
- The map on Pg1 could have a drill-down function that could show the data within each district of New Zealand rather than just the region. This can be achieved by continuing to use the Synoptic panel by Okviz.
- Clearer map image could be used on Pg1 as it, unfortunately, looks a little pixelated once published
- Dataset on New Zealand car registration drivers could be downloaded and compared to each region/district which could produce some interesting results
- Buttons to be added to transportation vehicles. 
- The map on Pg2 could show information on each crash rather than just it's coordinates


