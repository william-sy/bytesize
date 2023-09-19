import transip, argparse
import urllib.request
from datetime import datetime
now = datetime.now()
date = now.strftime("%Y-%m-%d - %H:%M:%S")

def main():
    parser = argparse.ArgumentParser(
        description='Check your external IP and send to transip as DYDNS'
    )
    parser.add_argument('-u','--username', required=True,
                    help='Username you login to transip webinterface',
                    dest='username')
    parser.add_argument('-k','--key', required=True,
                    help='keyfile (use full path)',
                    dest='key')
    parser.add_argument('-d','--domain', required=True,
                    help='The TLD you own you want to manage',
                    dest='domain')
    parser.add_argument('-r','--record', required=True,
                    help='The record we want to adjust (subdomain for example)',
                    dest='record')
    args = parser.parse_args()
    # /opt/stelling19-1/transip/stelling19.key
    client = transip.TransIP(login=args.username, private_key_file=args.key, global_key= True)
    external_ip = urllib.request.urlopen('https://api.ipify.org').read().decode('utf8')
    print(f"D-DNS - Current date: {date}")
    print(f"D-DNS - IP is: {external_ip}")
    # The domain we want to D-DNS
    domain = client.domains.get(args.domain)
    # Get all the records of the domain
    records = domain.dns.list()
    print("D-DNS - Check Start")
    # If the record matches the subdomain then check if it needs changing
    for record in records:
        if record.name == args.record:
            if record.content == external_ip:
                print("D-DNS - Nothing to do")
            elif record.content != external_ip:
                print("D-DNS - External IP has changed, updating record")
                dns_entry_data = {"name": args.record, "expire": 60 ,"type": "A", "content": external_ip }
                domain.dns.update(dns_entry_data)
            else:
                print("D-DNS - Whoops")
        else:
            pass

    print("D-DNS - Check Done")

if __name__ == "__main__":
    main()
