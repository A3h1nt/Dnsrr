# DNSrr 
DNSrr is a tool written in bash, used to enumerate all the juicy stuff from DNS records, it uses different techniques like
- DNS Forward Bruteforce
- DNS Reverse Bruteforce
- DNS Cache Snooping
- DNS Zone Transfer

To get you all the information that you can get, from a DNS server.

## Installation
Install it using git
```bash
git clone https://github.com/A3h1nt/Dnsrr
```
Get Started
```bash
./dnsrr.sh --help
```
## Usage
```bash
------------------- USAGE ------------------
-z    : Attempt Zone Transfer
        Syntax: ./dns.sh -z [Nameserver] [Domain Name]
-fb   : Forward Lookup Bruteforce
        Syntax: ./dns.sh [Domain Name]
        Syntax: ./dns.sh [Domain Name] [Wordlist]
-rb   : Reverse Lookup Bruteforce
        Syntax: ./dns.sh [Domain Name]
-cs   : Perform DNS Cache Snooping
        Syntax: ./dns.sh [Name Server] [Wordlist]
-x    : Explain A Particular Option
        Syntax: ./dns.sh -x [Option_Name]
------------------------------------------------
```
DNSrr supports five different options, including the one that explains the other four options. So just incase you don't know what a particular option is doing, you can simply use `-x` option, to understand the technique behind it.

Example:
```bash
# To explain zone transfer
./dnsrr -x z
```

## Sample Execution
### Zone Transfer
![execution](/images/1.png)

### Forward Lookup Bruteforce
![execution](/images/2.png)

## To Do
- Add new techniques that can be used to enumerate data from DNS.
- Report Bugs
- Add any new/missing feature.

## Contact Me
Ping me at [A3h1nt](https://twitter.com/A3h1nt).
