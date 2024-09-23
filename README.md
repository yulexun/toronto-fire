# Analysis of Toronto's Fire Incidents

## Overview

This paper analyzes fire incidents in Toronto between 2013 and 2023, focusing on the response times of the Toronto Fire Service (TFS) and the impact of fire protection systems. The study finds that TFS usually responds within 5 to 10 minutes, but the correlation between response time and financial losses is weak, and other factors like fire protection equipment play a larger role in mitigating damage. Fire alarms and sprinkler systems in present and operational reduce losses significantly. This research the importance of maintaining fire protection systems and improving fire service efficiency to enhance urban fire safety.

## File Structure

The repo is structured as:

-   `data/raw` contains the raw data as obtained from opendatatoronto.
-   `data/analysis` contains the cleaned dataset that was constructed.
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage

Some of the code are written with help of ChatGPT and the entire chat history is available in inputs/llms/usage.txt.

## Note

This R project is setup with Positron, which is demonstrated in Lecture 1. The properties of this project is stored in `/renv/settings.json`.
You can run 
```sh
renv::restore()
```
to restore the R project workspace. The old .Rproj file seems deprecated according to [this Github Issue](https://github.com/posit-dev/positron/discussions/3967)