#!/bin/bash

# Function to print usage information
print_usage() {
  echo -e "\e[33mUsage: $0 -t <url> | -l domain_list> [-a] [ -o <output_file> ]"
  echo ""
  echo "Options:"
  echo "  -h              Show this help message"
  echo "  -t url          Single URL to scan for clickjacking vulnerability."
  echo "  -l domain_list  File containing a list of domains to scan for clickjacking vulnerability."
  echo "  -a              Ask user if they want to save the result to a file"
  echo "  -o output_file  Save output to file"
}

# Color codes
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
NC='\e[0m'

echo -e "${RED}"
cat << "EOF"

      ██╗  ██╗ █████╗  ██████╗██╗  ██╗ ██████╗ ███████╗███████╗              ███████╗██╗  ██╗ ██████╗
      ██║  ██║██╔══██╗██╔════╝██║ ██╔╝██╔═══██╗██╔════╝██╔════╝              ██╔════╝██║  ██║██╔════╝
      ███████║███████║██║     █████╔╝ ██║   ██║█████╗  █████╗      █████╗    █████╗  ███████║██║     
      ██╔══██║██╔══██║██║     ██╔═██╗ ██║   ██║██╔══╝  ██╔══╝      ╚════╝    ██╔══╝  ██╔══██║██║     
      ██║  ██║██║  ██║╚██████╗██║  ██╗╚██████╔╝██║     ██║                   ███████╗██║  ██║╚██████╗
      ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝                   ╚══════╝╚═╝  ╚═╝ ╚═════╝
                                                                                               

  _                                                                               __                       
 /  | o  _ |  o  _.  _ |  o ._   _    \  /    | ._   _  ._ _. |_  o | o _|_      (_   _  _. ._  ._   _  ._ 
 \_ | | (_ |< | (_| (_ |< | | | (_|    \/ |_| | | | (/_ | (_| |_) | | |  |_ \/   __) (_ (_| | | | | (/_ |  
             _|                  _|                                         /                              

EOF
echo -e "${NC}"

# Parse command-line arguments
ask_save=false
while getopts "ht:l:ao:" opt; do
  case ${opt} in
    h )
      print_usage
      exit 0
      ;;
    t )
      # Check a single domain
      url=$OPTARG
      ;;
    l )
      # Check a list of domains
      domain_list=$OPTARG
      ;;
    a )
      # Ask user if they want to save the result
      ask_save=true
      ;;
    o )
      # Save output to file
      output_file=$OPTARG
      ;;
    \? )
      # Invalid option
      echo -e "\e[31mInvalid option: -$OPTARG\e[0m" 1>&2
      print_usage
      exit 1
      ;;
    : )
      # Missing argument
      echo -e "\e[31mOption -$OPTARG requires an argument\e[0m" 1>&2
      print_usage
      exit 1
      ;;
  esac
done

temp_dir=$(mktemp -d)
temp_file="$temp_dir/temp_output.txt"

save_output() {
  if [[ $ask_save == true ]]; then
    read -p "Do you want to save the result? (y/n): " save_resp
    if [[ $save_resp == "y" ]]; then
      read -p "Enter the output file name: " output_file
      read -p "Enter the output file format (PDF or text): " format
      if [[ $format == "PDF" ]]; then
        output_file="$output_file.pdf"
        wkhtmltopdf "file://$temp_file" "$output_file"
      else
        output_file="$output_file.txt"
        cat "$temp_file" > "$output_file"
      fi
      echo "Output saved to $output_file."
    fi
  fi
  rm -rf "$temp_dir"
}

check_domain() {
  domain=$1
  echo -e "${BLUE}\nChecking $domain for clickjacking vulnerability...${NC}\n" | tee -a "$temp_file"
  if curl -s -L -i "$domain" -o /dev/null -w '%{http_code}\n' -H "X-Frame-Options: DENY" | grep -q -e "20[0-9]\{1\}"; then
    echo -e "\e[1m\e[31mclickjacking-found\e[0m $domain" | tee -a "$temp_file"
  else
    echo -e "\e[1m\e[32mclickjacking-not-found\e[0m $domain" | tee -a "$temp_file"
  fi
}

# Check if the user wants to scan a single target or a list of domains
if [[ -n $url ]]; then
  # Scan a single domain
  check_domain "$url"
  save_output
elif [[ -n $domain_list ]]; then
  # Scan a list of domains
  echo -e "${BLUE}\nChecking clickjacking vulnerability for all domains in $domain_list...${NC}\n"
  if [ ! -f "$domain_list" ]; then
    echo "File $domain_list does not exist."
    exit 1
  fi
  while read -r domain; do
    check_domain "$domain"
  done < "$domain_list"
  save_output
else
  # No input provided
  echo "Please provide either a single URL (-t) or a file containing a list of domains (-l)."
  print_usage
  exit 1
fi
