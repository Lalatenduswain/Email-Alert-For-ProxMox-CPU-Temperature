#!/bin/bash
# Mentor : Lalatendu Swain
# Email details
email1="user1@lalatendu.info"
email3="user2@lalatendu.info"
email4="user3@lalatendu.info"
bcc_email="user4@lalatendu.info"
subject="Server ROOM CPU Overheat Temperature Alert"
message="One of the Server CPU temperatures has exceeded 75°C. We need to turn on the AC and maintain a cool temperature in the Server room."

while true; do
    # Get the temperatures
    core_temps=$(sensors | grep 'Core' | awk '{print $3}' | sed 's/+//g' | sed 's/°C//g')
    
    # Check each core temperature
    for temp in $core_temps; do
        if (( $(echo "$temp > 75" | bc -l) )); then
            (
                echo "To: $email1"
                echo "Cc: $email3, $email4"
                echo "Bcc: $bcc_email"
                echo "Subject: $subject"
                echo
                echo "$message"
            ) | sendmail -t
            break
        fi
    done
    
    # Wait for 1 second
    sleep 1
done
