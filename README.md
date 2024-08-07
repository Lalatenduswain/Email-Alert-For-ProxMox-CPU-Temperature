# Server CPU Overheat Temperature Alert Script

This script continuously monitors the CPU temperature of a server and sends email alerts if any core temperature exceeds 35°C. This can help ensure timely actions to prevent overheating and maintain server room conditions.

## Prerequisites

Before running the script, ensure the following:

1. **Operating System**: This script is designed for Unix-like operating systems.
2. **sensors Command**: Install the `lm-sensors` package to get the CPU temperature readings.
   ```bash
   sudo apt-get install lm-sensors
   ```
   After installation, detect the sensors by running:
   ```bash
   sudo sensors-detect
   ```
   Follow the on-screen instructions and allow the script to add the necessary modules.

3. **mail Command**: Ensure you have a mail utility installed and configured to send emails.
   ```bash
   sudo apt-get install mailutils
   ```
   Configure your mail system as per your requirements. For example, you might need to set up `postfix` or any other Mail Transfer Agent (MTA).

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Lalatenduswain/list_domains_master.git
   ```
2. Navigate to the cloned directory:
   ```bash
   cd list_domains_master
   ```

## Usage

1. Open the script `backup_lxc.sh` in a text editor:
   ```bash
   nano backup_lxc.sh
   ```
2. Update the email addresses and temperature threshold if needed.

3. Make the script executable:
   ```bash
   chmod +x backup_lxc.sh
   ```

4. Run the script:
   ```bash
   ./backup_lxc.sh
   ```

The script will continuously monitor the CPU temperature and send an email alert if any core temperature exceeds the defined threshold.

## Script Details

### Script Name: backup_lxc.sh

```bash
#!/bin/bash

# Email details
email1="lalatendu@ceruleaninfotech.com"
email2="lalatendu.swain@gmail.com"
subject="Server ROOM CPU Overheat Temperature Alert"
message="One of the Server CPU temperatures has exceeded 45°C. We need to turn on the AC and maintain a cool temperature in the Server room."

while true; do
    # Get the temperatures
    core_temps=$(sensors | grep 'Core' | awk '{print $3}' | sed 's/+//g' | sed 's/°C//g')
    
    # Check each core temperature
    for temp in $core_temps; do
        if (( $(echo "$temp > 35" | bc -l) )); then
            echo "$message" | mail -s "$subject" "$email1"
            echo "$message" | mail -s "$subject" "$email2"
            break
        fi
    done
    
    # Wait for 1 second
    sleep 1
done
```

## Disclaimer | Running the Script

**Author:** Lalatendu Swain | [GitHub](https://github.com/Lalatenduswain) | [Website](https://blog.lalatendu.info/)

This script is provided as-is and may require modifications or updates based on your specific environment and requirements. Use it at your own risk. The authors of the script are not liable for any damages or issues caused by its usage.

## Donations

If you find this script useful and want to show your appreciation, you can donate via [Buy Me a Coffee](https://www.buymeacoffee.com/lalatendu.swain).

---

Feel free to reach out if you have any questions or need further assistance.

Happy Monitoring!
