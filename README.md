# Clickjacking Vulnerability Scanner :mag_right: :lock:

Welcome to the Clickjacking Vulnerability Scanner! This powerful and easy-to-use Bash script is designed to help web security enthusiasts, developers, and researchers quickly identify websites with potential clickjacking vulnerabilities. By scanning a single URL or a list of domains, our scanner can detect the presence or absence of critical headers, such as X-Frame-Options and Content-Security-Policy, which are essential for protecting against clickjacking attacks. Let's make the web a safer place, one website at a time! :earth_asia: :shield:

## :star2: Exciting Features

- :mag: Scan a single URL or a list of domains for clickjacking vulnerabilities
- :wrench: Choose between checking for X-Frame-Options or Content-Security-Policy headers
- :art: Color-coded output for easy identification of vulnerable and secure websites
- :floppy_disk: Save the results to a file in text or PDF format (optional)
- :computer: User-friendly command-line options for better control and flexibility
- :hourglass: Displays scan progress for a list of domains

## :hammer: Requirements

- Bash shell
- curl

## :rocket: Installation

1. Clone the repository or download the ZIP file and extract it:

``` bash
git clone https://github.com/yourusername/clickjacking-scanner.git
``` 

2. Navigate to the extracted directory:

``` bash
cd clickjacking-scanner
``` 

3. Make the script executable:

``` bash
chmod +x clickjacking_scanner.sh
``` 

## :book: Usage

``` bash
./clickjacking_scanner.sh -t <url> | -l domain_list> [-a] [-f <frame_header>] [ -o <output_file> ]
``` 
