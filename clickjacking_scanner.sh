#!/bin/bash

# Function to print usage information
print_usage() {
  echo -e "\e[33mUsage: $0 -u <url> | -d domain_list> [ -o <output_file> ]"
  echo ""
  echo "Options:"
  echo "  -h              Show this help message"
  echo "  -u url          Single URL to scan for clickjacking vulnerability."
  echo "  -d domain_list  File containing a list of domains to scan for clickjacking vulnerability."
  echo "  -s output_file  Save output to file"
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
                                                                                                         
  _ | o  _ |  o  _.  _ |  o  _           | ._   _   _. |_  o | o _|_       _  _  _. ._  ._   _  ._   _|_  _   _  | 
 (_ | | (_ |< | (_| (_ |< | (_|   \/ |_| | | | (/_ (_| |_) | | |  |_ \/   _> (_ (_| | | | | (/_ |     |_ (_) (_) | 
             _|              _|                                      /                                                                                  

EOF
echo -e "${NC}"

# Parse command-line arguments
while getopts "hu:d:s:" opt; do
  case ${opt} in
    h )
      print_usage
      exit 0
      ;;
    u )
      # Check a single domain
      url=$OPTARG
      ;;
    d )
      # Check a list of domains
      domain_list=$OPTARG
      ;;
    s )
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

# Check if the user wants to scan a single target or a list of domains
if [[ -n $url ]]; then
  # Scan a single domain
  echo -e "${BLUE}\nChecking $url for clickjacking vulnerability...${NC}\n"
  if curl -s -L -i "$url" -o /dev/null -w '%{http_code}\n' -H "X-Frame-Options: DENY" | grep -q -e "20[0-9]\{1\}"; then
    echo -e "\e[1m\e[31mClickjacking-found\e[0m $url"
  else
    echo -e "\e[1m\e[32mclickjacking-not-found\e[0m $url"
  fi
elif [[ -n $domain_list ]]; then
  # Scan a list of domains
  echo -e "${BLUE}\nChecking clickjacking vulnerability for all domains in $domain_list...${NC}\n"
  if [ ! -f "$domain_list" ]; then
    echo "File $domain_list does not exist."
    exit 1
  fi
  while read -r domain; do
    echo -e "${BLUE}\nChecking $domain for clickjacking vulnerability...${NC}\n"
    if curl -s -L -i "$domain" -o /dev/null -w '%{http_code}\n' -H "X-Frame-Options: DENY" | grep -q -e "20[0-9]\{1\}"; then
      echo -e "\e[1m\e[31mclickjacking-found\e[0m $domain"
    else
      echo -e "\e[1m\e[32mclickjacking-not-found\e[0m $domain"
    fi
  done < "$domain_list"
else
  # No input provided
  echo "Please provide either a single URL (-u) or a file containing a list of domains (-d)."
  print_usage
  exit 1
fi

# Save output to file if specified
if [[ -n $output_file ]]; then
  exec > "$output_file"
  echo "Output saved to $output_file."
fi
