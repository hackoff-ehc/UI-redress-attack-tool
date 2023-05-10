# Clickjacking Vulnerability Scanner :mag_right: :lock:

Welcome to the Clickjacking Vulnerability Scanner! This powerful and easy-to-use Bash script is designed to help web security enthusiasts, developers, and researchers quickly identify websites with potential clickjacking vulnerabilities. By scanning a single URL or a list of domains, our scanner can detect the presence or absence of critical headers, such as ``` X-Frame-Options```  and ``` Content-Security-Policy``` , which are essential for protecting against clickjacking attacks. Let's make the web a safer place, one website at a time! :earth_asia: :shield:

## :star2: Exciting Features

- :mag: Scan a single URL or a list of domains for clickjacking vulnerabilities
- :wrench: Choose between checking for ``` X-Frame-Options```  or ``` Content-Security-Policy```
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
git clone https://github.com/hackoff-ehc/UI-redress-attack-tool.git
``` 

2. Navigate to the extracted directory:

``` bash
cd UI-redress-attack-tool
``` 

3. Make the script executable:

``` bash
chmod +x clickjacking_scanner.sh
``` 
#### Ubuntu/Debian

```bash
sudo apt-get update
sudo apt-get install wkhtmltopdf
```
### macOS
```bash
brew install wkhtmltopdf
```

## :book: Usage

``` bash
./clickjacking_scanner.sh -t <url> | -l domain_list> [-a] [-f <frame_header>] [ -o <output_file> ]
``` 
### :pushpin: Options:

- `-h`: Show help message
- `-t url`: Single URL to scan for clickjacking vulnerability
- `-l domain_list`: File containing a list of domains to scan for clickjacking vulnerability
- `-f frame_header`: Specify the header to check for clickjacking vulnerability (X-Frame-Options or Content-Security-Policy). Default: X-Frame-Options
- `-a`: Ask user if they want to save the result to a file
- `-o output_file`: Save output to file

### :bulb: Examples

1. Scan a single URL:

```bash
./clickjacking_scanner.sh -t https://example.com
```

2. Scan a list of domains:

```bash
./clickjacking_scanner.sh -l domain_list.txt
```

3. Scan a single URL and ask to save the result:

```bash
./clickjacking_scanner.sh -t https://example.com -a
```

4. Scan a list of domains and save the results to a specified file:

```bash
./clickjacking_scanner.sh -l domain_list.txt -o output.txt
```

5. Ask to save the result to a file (PDF or text format):

```bash
./clickjacking_scanner.sh -t https://example.com -a
```

6. Scan a single URL, checking for the Content-Security-Policy header:

```bash
./clickjacking_scanner.sh -t https://example.com -f Content-Security-Policy
```

## :handshake: Contributing

We'd love for you to join us in making the Clickjacking Vulnerability Scanner even better! :heart_eyes: Feel free to submit a pull request or open an issue to discuss any proposed changes or report bugs.  Your valuable contributions help make the web a safer place for everyone! :earth_asia: :shield:

## :page_with_curl: License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
