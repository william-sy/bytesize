# simple script to manage a DNS 

This script manages DNS records for transip.

Note: The record must exist before you run the script.

## Running the script: 
/bin/python3 ddns.py -u username -k api.key -d example.nl -r subdomainname >> /var/log/ddns.log 2>&1

-u: username; your transip webportal username
-k: key; the api key you can generate in the transip webportal
-d: domain; your domain
-r: record; the record you want to manage (for test.example.nl this should be `test`)
