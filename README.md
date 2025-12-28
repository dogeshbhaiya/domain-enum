# Domain & Subdomain Enumeration Script

Passive subdomain enumeration tool for bug bounty and security testing.

## Usage

## Export API Keys
```bash
export PD_API_KEY=your_key
export VT_API_KEY=your_key
```
The script securely reads these values at runtime to authenticate requests to ProjectDiscovery DNS API & VirusTotal API

## Make the Script Executable
```bash
chmod +x subdomain_enum.sh
```
This command is used to run the tool.
## Run the Enumeration
```bash
./subdomain_enum.sh example.com
```
Enter the website to perform enumeration.
## Output Structure
```bash
example.com_results/
├── projectdiscovery.txt
├── crtsh.txt
├── virustotal.txt
└── example.com_subdomains.txt
```

## Sample Bash Output
```bash
$ ./subdomain_enum.sh example.com

[*] Starting subdomain enumeration for: example.com
[*] Checking dependencies...
[✓] All required tools found

[*] Fetching subdomains from ProjectDiscovery
[*] Fetching subdomains from crt.sh
[*] Fetching subdomains from VirusTotal

[*] Combining and deduplicating results...

[✓] Subdomain enumeration complete!
[+] Total unique subdomains found: 147
[+] Results saved in: example.com_results/example.com_subdomains.txt
```

## Disclaimer
Authorized testing only.
