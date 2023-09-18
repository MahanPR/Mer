#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color
 #Check if user is root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root"
    sleep .5 
    #su -s /bin/bash -c "$0 $*" root
   # exit 1
fi
echo "Running as root..."
sleep .5
clear
while true; do
    clear
    echo -e "${YELLOW}+--------------------------------------------------+${NC}"
    echo -e "${YELLOW}|                                                  |${NC}"
    echo -e "${YELLOW}|${GRAY}     ____  ___    ___     _____     _____  ___    ${YELLOW}|${NC}"
    echo -e "${YELLOW}|${GRAY}    ____  /   |  /   |   | ___ \   | ___ \  ___   ${YELLOW}|${NC}"
    echo -e "${YELLOW}|${GRAY}   ____  / /| | / /| |   | \_/ /   | \_/ / ____   ${YELLOW}|${NC}"
    echo -e "${YELLOW}|${GRAY}   ___  / / | |/ / | |   |  __/    |  __ \ ____   ${YELLOW}|${NC}"
    echo -e "${YELLOW}|${GRAY}   __  /_/  |___/  |_|   |_|       |_|  \_\ __    ${YELLOW}|${NC}"
    echo -e "${YELLOW}|                                        ${YELLOW}ver 2.0 ${NC}  ${YELLOW}|${NC}"
    echo -e "${YELLOW}|${NC}                       B Y                        ${YELLOW}|${NC}"
    echo -e "${YELLOW}|${NC}              P E R S I A N G U Y S               ${YELLOW}|${NC}"
    echo -e "${YELLOW}|           ---------------------------            |${NC}"
    echo -e "${YELLOW}|                    ${GRAY}Main Menu${YELLOW}                     |${NC}"
    echo -e "${YELLOW}|--------------------------------------------------|${NC}"
    echo -e "${GRAY}|                                                  |${NC}"
    echo -e "${BLUE}|${RED}      ------------ Server Tools ------------      ${BLUE}|${NC}"
    echo -e "${BLUE}|                                                  |${NC}"
    echo -e "${BLUE}|${YELLOW} 1.${NC} ${CYAN}Update server and install dependences${NC}         ${BLUE}|${NC}"
    echo -e "${BLUE}|${YELLOW} 2.${NC} ${GRAY}Change SSH port${NC}                               ${BLUE}|${NC}"
    echo -e "${BLUE}|${YELLOW} 3.${NC} ${CYAN}Add user (for SSH)${NC}                            ${BLUE}|${NC}"
    echo -e "${BLUE}|${YELLOW} 4.${NC} ${GRAY}Server Backup${NC}                                 ${BLUE}|${NC}"
    echo -e "${BLUE}|${YELLOW} 5.${NC} ${CYAN}Tunnel two server using IPtables${NC}              ${BLUE}|${NC}"      # TODO add multiplie methods
    echo -e "${BLUE}|${YELLOW} 6.${NC} ${GRAY}View system usage${NC}                             ${BLUE}|${NC}"        # update that
    echo -e "${BLUE}|${YELLOW} 7.${NC} ${CYAN}change reposiroy${NC}                              ${BLUE}|${NC}"
    echo -e "${BLUE}|${YELLOW} 8.${NC} ${GRAY}change nameserver${NC}                             ${BLUE}|${NC}"
    echo -e "${BLUE}|                                                  |${NC}"
    echo -e "${RED}|     ------------ VPN configure -----------       |${NC}"
    echo -e "${BLUE}|                                                  |${NC}"
    echo -e "${BLUE}|${YELLOW}9.${NC} ${CYAN}Cisco anyconnect${NC}                              ${BLUE}|${NC}"
    echo -e "${BLUE}|${YELLOW}10.${NC} ${GRAY}Install OpenVPN${NC}                               ${BLUE}|${NC}"
    echo -e "${BLUE}|${YELLOW}11.${NC} ${CYAN}Set up Outline${NC}                                ${BLUE}|${NC}"
    echo -e "${BLUE}|${YELLOW}12.${NC} ${GRAY}Set up wiregaurd${NC}                              ${BLUE}|${NC}"
    echo -e "${BLUE}|${YELLOW}13.${NC} ${CYAN}Set up IPsec VPN(L2TP/IKEV2)${NC}                  ${BLUE}|${NC}"
    echo -e "${BLUE}|${YELLOW}14.${NC} ${GRAY}Install Mtproto proxy${NC}                         ${BLUE}|${NC}"
    echo -e "${BLUE}|${YELLOW}15.${NC} ${GRAY}SSH panel${NC}                                     ${BLUE}|${NC}"
    echo -e "${BLUE}|                                                  |${NC}"
    echo -e "${RED}|    ----------------  other  --------------       |${NC}"
    echo -e "${BLUE}|                                                  |${NC}"
    echo -e "${BLUE}|${YELLOW}16.${NC} ${GREEN}CREDITS${NC}                                       ${BLUE}|${NC}"
    echo -e "${BLUE}|${YELLOW}0.${NC} ${RED}QUIT${NC}                                           ${BLUE}|${NC}"
    echo -e "${GREEN}|                                                  |${NC}" 
    echo -e "${YELLOW}|                                                  |${NC}" 
    echo -e "${YELLOW}+--------------------------------------------------+${NC}"
    echo -e ""
    echo -e "${GRAY}Please choose an option:${NC}"
    echo -e ""
    
    read -p "Enter option number: " choice

    case $choice in

     #UPDATE SEVER
        1)
            echo -e "${BLUE}Updating server...${NC}" 
            echo ""
            apt update && apt upgrade -y
            sudo apt install git wget curl ufw  wget  
            echo ""
            echo -e "Press ${RED}ENTER${NC} to continue"
            read -s -n 1
            ;;
        2)
            echo -e "${GREEN}Changing SSH port...${NC}"
            echo ""
            read -p "Enter a new port number: " new_port
            sed -i "s/#Port 22/Port $new_port/" /etc/ssh/sshd_config
            sed -i "s/#Port/Port/" /etc/ssh/sshd_config
            systemctl restart sshd.service
            ufw allow $new_port/tcp
            echo ""
            echo -e "Press ${RED}ENTER${NC} to continue"
            read -s -n 1
            ;; 
        3)
            echo -e "${GREEN}Adding user...${NC}"
            echo ""
            read -p "Enter username: " username
            adduser $username
            echo ""
            echo -e "Press ${RED}ENTER${NC} to continue"
            read -s -n 1
            ;;
        4)
            
            # Function to prompt user for source server details
            function get_source_details {
                read -p "Enter the hostname of the source server: " SRC_HOST
                read -p "Enter the username of the source server: " SRC_USER
                read -s -p "Enter the password of the source server: " SRC_PASS
                echo
            }

            # Function to prompt user for destination server details
            function get_destination_details {
                read -p "Enter the hostname of the destination server: " DEST_HOST
                read -p "Enter the username of the destination server: " DEST_USER
                read -s -p "Enter the password of the destination server: " DEST_PASS
                echo
            }

            # Function to prompt user for backup destination directory
            function get_backup_directory {
                read -p "Enter the backup destination directory (default: /backups): " BACKUP_DIR
                BACKUP_DIR=${BACKUP_DIR:-/backups}
            }

            # Function to transfer backup to destination server
            function transfer_backup {
                read -p "Enter the name of the backup file to transfer: " backup_file
                sshpass -p "$DEST_PASS" scp "$BACKUP_DIR/$backup_file" "$DEST_USER"@"$DEST_HOST:$BACKUP_DIR"
                read -p "Backup transferred successfully. Do you want to restore it on the destination server? (y/n): " restore_backup
                if [[ "$restore_backup" == "y" ]]; then
                    restore_backup_on_destination
                fi
            }

            # Function to restore backup on destination server
            function restore_backup_on_destination {
                read -p "Enter the name of the backup file to restore: " backup_file
                sshpass -p "$DEST_PASS" ssh "$DEST_USER"@"$DEST_HOST" "tar xzf $BACKUP_DIR/$backup_file -C /"
                echo "Backup restored successfully on the destination server."
                read -p "Press Enter to continue."
            }

            # Main menu loop
            while true; do
                clear
                echo "Menu:"
                echo "1. Enter source server details"
                echo "2. Enter destination server details"
                echo "3. Enter backup destination directory"
                echo "4. Install rsnapshot"
                echo "5. Configure rsnapshot"
                echo "6. Take snapshot"
                echo "7. Transfer backup to destination server"
                echo "8. Exit"
                read -p "Enter your choice: " choice

                case $choice in
                    1)
                        get_source_details
                        ;;
                    2)
                        get_destination_details
                        ;;
                    3)
                        get_backup_directory
                        ;;
                    4)
                        echo "Installing rsnapshot..."
                        apt-get update
                        apt-get install -y rsnapshot
                        echo "Rsnapshot installed successfully."
                        read -p "Press Enter to continue."
                        ;;
                    5)
                        echo "Configuring rsnapshot..."
                        # Backup source directories
                        echo "backup  /etc/  localhost/" >> /etc/rsnapshot.conf
                        echo "backup  /etc/x-ui  localhost/" >> /etc/rsnapshot.conf
                        echo "backup  /etc/oscerv  localhost/" >> /etc/rsnapshot.conf
                        echo "backup  /home/ localhost/" >> /etc/rsnapshot.conf
                        echo "backup  /var/log/  localhost/" >> /etc/rsnapshot.conf

                        # Backup destination directory
                        echo "snapshot_root $BACKUP_DIR/" >> /etc/rsnapshot.conf

                        # Backup intervals
                        echo "interval hourly 6" >> /etc/rsnapshot.conf
                        echo "interval daily 7" >> /etc/rsnapshot.conf
                        echo "interval weekly 4" >> /etc/rsnapshot.conf
                        echo "interval monthly 3" >> /etc/rsnapshot.conf

                        echo "Rsnapshot configured successfully."
                        read -p "Press Enter to continue."
                        ;;
                    6)
                        echo "Taking snapshot..."
                        rsnapshot hourly
                        echo "Snapshot taken successfully."
                        read -p "Press Enter to continue."
                        ;;
                    7)
                        transfer_backup
                        ;;
                    8)
                        echo "Exiting program."
                        break
                        ;;
                    *)
                        echo "Invalid choice. Please try again."
                        read -p "Press Enter to continue."
                        ;;
                esac
            done       
            ;;
        5)
            # Function to add the iptables commands to crontab
             RED='\033[0;31m'
            GREEN='\033[0;32m'
            YELLOW='\033[1;33m'
            BLUE='\033[0;34m'
            MAGENTA='\033[0;35m'
            CYAN='\033[0;36m'
            GRAY='\033[0;37m'
            NC='\033[0m' # No Color
            while true; do
             clear
            # show options to user
            echo -e "${YELLOW}1.${NC} ${YELLOW}Install iptables${NC}"
            echo -e "${YELLOW}2.${NC} ${NC}Display forwarding table${NC}"
            echo -e "${YELLOW}3.${NC} ${GREEN}Set up a tunnel${NC}"
            echo -e "${YELLOW}4.${NC} ${RED}Delete a tunnel${NC}"
            echo -e "${YELLOW}5.${NC} ${NC}1.${NC}Add commands to crontab"
            echo -e "${RED}6.${NC} ${BLUE}Back to main menu${NC}"
            echo " "
            echo "Please choose an option:"
            # read user input
            read choice
            # run appropriate function based on user choice
             case $choice in
                1)
                        sudo apt-get update
                        sudo apt-get install iptables
                        echo -e "Press ${RED}ENTER${NC} to continue"
                        read -s -n 1
                        ;;
                2)
                        # Add code to display forwarding table|
                         iptables -L -n -t nat
                         ;;
                3)
                        echo "Please enter the Iran IP for the tunnel:"
                        read iran_ip
                        echo "Please enter the Kharej IP for the tunnel:"
                        read kharej_ip
                        echo "Please enter the SSH port (default is 22):"
                        read ssh_port
                        sudo sysctl net.ipv4.ip_forward=1
                        sudo iptables -t nat -A PREROUTING -p tcp -d "$iran_ip" --dport $ssh_port -j DNAT --to-destination "$iran_ip"
                        sudo iptables -t nat -A PREROUTING -j DNAT -d "$iran_ip" --to-destination "$kharej_ip"
                        sudo iptables -t nat -A POSTROUTING -j MASQUERADE
                        echo "Do you want to add the commands to crontab for automatic execution on server reboot? (y/n)"
                        read add_to_crontab_choice
                        if [ "$add_to_crontab_choice" == "y" ] || [ "$add_to_crontab_choice" == "Y" ]; then
                        (crontab -l ; echo "@reboot sudo sysctl net.ipv4.ip_forward=1 && sudo iptables -t nat -A PREROUTING -p tcp --dport $ssh_port -j DNAT --to-destination \"$iran_ip\" && sudo iptables -t nat -A PREROUTING -j DNAT --to-destination \"$kharej_ip\" && sudo iptables -t nat -A POSTROUTING -j MASQUERADE") | crontab -
                        echo "The iptables commands have been added to the crontab for automatic execution on server reboot."
                        fi
                        echo -e "Press ${RED}ENTER${NC} to continue"
                        read -s -n 1
                        ;;
                4)
                        echo "Please enter the Iran IP for the tunnel to delete:"
                        read iran_ip
                        echo "Please enter the Kharej IP for the tunnel to delete:"
                        read kharej_ip
                        echo "Please enter the SSH port (default is 22):"
                        read ssh_port
                        sudo sysctl net.ipv4.ip_forward=1
                        sudo iptables -t nat -D PREROUTING -p tcp --dport $ssh_port -j DNAT --to-destination "$iran_ip"
                        sudo iptables -t nat -D PREROUTING -j DNAT --to-destination "$kharej_ip"
                        sudo iptables -t nat -D POSTROUTING -j MASQUERADE
                        echo -e "Press ${RED}ENTER${NC} to continue"
                        read -s -n 1
                        ;;
                5)
                        (crontab -l ; echo "@reboot sudo sysctl net.ipv4.ip_forward=1 && sudo iptables -t nat -A PREROUTING -p tcp --dport $ssh_port -j DNAT --to-destination \"$iran_ip\" && sudo iptables -t nat -A PREROUTING -j DNAT --to-destination \"$kharej_ip\" && sudo iptables -t nat -A POSTROUTING -j MASQUERADE") | crontab -
                        echo "The iptables commands have been added to the crontab for automatic execution on server reboot."
                        echo -e "Press ${RED}ENTER${NC} to continue"
                        read -s -n 1
                        ;;
                6)
                        break
                        ;;
                *)
                        echo "Invalid choice"
                        ;;
                    esac
                 done
                 
            echo -e "Press ${RED}ENTER${NC} to continue"
            read -s -n 1
            ;;
        6)
            

            # Function to wait for user input and return to menu
            function return_to_menu {
                read -n1 -r -p "Press any key to return to the menu..."
            }

            # Function to display the process table
            function display_process_table {
                # Print table header with color
                printf "${YELLOW}%-20s %-10s %-10s %-10s${NC}\n" "Program Name" "CPU Usage" "RAM Usage" "Network Usage"

                while true; do
                    # Get process information with ps command
                    ps_output=$(ps -e -o comm,%cpu,%mem --sort=-%cpu | head -n 6)

                    # Extract specific columns with awk command
                    awk_output=$(echo "$ps_output" | awk '{printf "%-20s %-10s %-10s\n", $1, $2, $3}')

                    # Get network usage with sar command
                    sar_output=$(sar -n DEV 1 1 | awk '/ens/ {printf "%-10s", $5}')

                    # Clear screen and print table header with color
                    clear
                    printf "${YELLOW}%-20s %-10s %-10s %-10s${NC}\n" "Program Name" "CPU Usage" "RAM Usage" "Network Usage"

                    # Print table with color
                    printf "${GREEN}%s${NC} ${RED}%s${NC}\n" "$awk_output" "$sar_output"

                    # Wait for 5 seconds before next iteration
                    sleep 1
                done
            }

            # Print initial menu
            while true; do
                clear
                echo "Please select an option:"
                echo "1. View process table"
                echo "2. Quit"
                read -n1 -r option

                case $option in
                    1)
                        display_process_table
                        return_to_menu
                        ;;
                    2)
                        # Quit the script
                        exit 0
                        ;;
                    *)
                        # Handle invalid input
                        echo "Invalid option selected. Please try again."
                        return_to_menu
                        ;;
                esac
            done
            echo -e "Press ${RED}ENTER${NC} to continue"
            read -s -n 1
            ;;
        7)

                # Define colors
                GREEN='\033[0;32m'
                YELLOW='\033[1;33m'
                RED='\033[0;31m'
                BLUE='\033[0;34m'
                NC='\033[0m' # No Color

                # Define menu
                menu="
                    ${GREEN}+--------------------------------------------+
                    ¦       ${BLUE}UBUNTU MIRROR SERVER SELECTOR${GREEN}        ¦
                    ¦--------------------------------------------¦
                    ¦ ${YELLOW}1${NC}. Select a mirror server               ${GREEN}   ¦
                    ¦ ${YELLOW}2${NC}. Restore default mirror servers      ${GREEN}    ¦
                    ¦ ${YELLOW}3${NC}. Display current mirror server       ${GREEN}    ¦
                    ¦ ${RED}0${NC}. Exit                                 ${GREEN}   ¦
                    +--------------------------------------------+
                "

                # Define mirror server URLs
                main_url="http://archive.ubuntu.com/ubuntu/"
                us_url="http://us.archive.ubuntu.com/ubuntu/"
                ca_url="http://ca.archive.ubuntu.com/ubuntu/"
                uk_url="http://gb.archive.ubuntu.com/ubuntu/"
                de_url="http://de.archive.ubuntu.com/ubuntu/"
                tr_url="http://ftp.linux.org.tr/ubuntu/"

                # Function to update the mirror server URLs in sources.list file
                update_mirror_server() {
                    local server_choice="$1"

                    case "$server_choice" in
                        1) sudo sed -i 's|^deb.*http://.*ubuntu.com/ubuntu/|deb '$main_url'|g' /etc/apt/sources.list ;;
                        2) sudo sed -i 's|^deb.*http://.*ubuntu.com/ubuntu/|deb '$us_url'|g' /etc/apt/sources.list ;;
                        3) sudo sed -i 's|^deb.*http://.*ubuntu.com/ubuntu/|deb '$ca_url'|g' /etc/apt/sources.list ;;
                        4) sudo sed -i 's|^deb.*http://.*ubuntu.com/ubuntu/|deb '$uk_url'|g' /etc/apt/sources.list ;;
                        5) sudo sed -i 's|^deb.*http://.*ubuntu.com/ubuntu/|deb '$de_url'|g' /etc/apt/sources.list ;;
                        6) sudo sed -i 's|^deb.*http://.*ubuntu.com/ubuntu/|deb '$tr_url'|g' /etc/apt/sources.list ;;
                    esac
                }

                # Display menu and read user's choice
                while true; do
                    clear  # Clear the screen before displaying the menu
                    echo -e "$menu"
                    read -p "Enter your choice: " choice

                    case "$choice" in
                        1)
                            echo -e "${GREEN}Select a mirror server:${NC}"
                            echo -e "   ${YELLOW}1${NC}. Main server: ${main_url}"
                            echo -e "   ${YELLOW}2${NC}. US server: ${us_url}"
                            echo -e "   ${YELLOW}3${NC}. Canada server: ${ca_url}"
                            echo -e "   ${YELLOW}4${NC}. UK server: ${uk_url}"
                            echo -e "   ${YELLOW}5${NC}. Germany server: ${de_url}"
                            echo -e "   ${YELLOW}6${NC}. Turkey server: ${tr_url}"
                            read -p "Enter your choice (0-6): " server_choice

                            # Validate user input
                            if [[ "$server_choice" =~ ^[0-6]$ ]]; then
                                echo -e "You selected ${YELLOW}${server_choice}${NC}."
                                read -p "Are you sure you want to update the mirror server? (Y/N): " confirm_choice
                                if [[ "$confirm_choice" =~ ^[Yy]$ ]]; then
                                    update_mirror_server "$server_choice"
                                    echo -e "${GREEN}Mirror server updated successfully!${NC}"
                                else
                                    echo -e "${RED}Mirror server update cancelled.${NC}"
                                fi
                            else
                                echo -e "${RED}Invalid choice. Try again.${NC}"
                            fi
                            ;;
                        2)
                            echo -e "${GREEN}Restoring default mirror server URLs...${NC}"
                            sudo sed -i 's|^deb.*http://.*ubuntu.com/ubuntu/|deb '$main_url'|g' /etc/apt/sources.list
                            echo -e "${GREEN}Default mirror server URLs restored successfully!${NC}"
                            ;;
                        3)
                            echo -e "${GREEN}Current mirror server URL:${NC}"
                            grep -oP '(?<=^deb ).*(?=/ubuntu/)' /etc/apt/sources.list
                            ;;
                        0)
                            echo -e "${RED}Exiting...${NC}"
                            exit 0
                            ;;
                        *)
                            echo -e "${RED}Invalid choice. Try again.${NC}"
                            ;;
                    esac

                    read -p "Press Enter to continue..."
                done
                echo -e "Press ${RED}ENTER${NC} to continue"
                read -s -n 1
                ;;
        8)
            # Color variables
            RED='\033[0;31m'
            GREEN='\033[0;32m'
            YELLOW='\033[1;33m'
            BLUE='\033[0;34m'
            NC='\033[0m' # No Color

            # Backup and restore original resolv.conf
            BACKUP_FILE="/etc/resolv.conf.bak"

            # Function to display the current nameservers
            function display_nameservers() {
            echo -e "${YELLOW}Current nameservers:${NC}"
            awk '/nameserver/ {printf "%-3s %s\n", NR".", $2}' /etc/resolv.conf
            }

            # Function to change nameserver
            function change_nameserver() {
            # Display current nameservers
            display_nameservers

            # Prompt for the nameserver number to change
            read -p "Enter the number of the nameserver you want to change: " number

            # Check if the entered number is valid
            if ! [[ "$number" =~ ^[0-9]+$ ]]; then
                echo -e "${RED}Invalid number. Please try again.${NC}"
                return
            fi

            # Get the existing nameserver value
            existing_nameserver=$(awk -v line_number="$number" 'NR == line_number {print $2}' /etc/resolv.conf)

            # Check if the entered number is within range
            if [ -z "$existing_nameserver" ]; then
                echo -e "${RED}Invalid number. Please try again.${NC}"
                return
            fi

            # Prompt for the new nameserver
            read -p "Enter the new nameserver: " new_nameserver

            # Validate the new nameserver format
            if ! grep -Pq '^(\d{1,3}\.){3}\d{1,3}$' <<< "$new_nameserver"; then
                echo -e "${RED}Invalid IP address format. Please try again.${NC}"
                return
            fi

            # Backup original resolv.conf
            cp /etc/resolv.conf "$BACKUP_FILE"

            # Change the nameserver in resolv.conf
            sudo sed -i "s/$existing_nameserver/$new_nameserver/" /etc/resolv.conf

            echo -e "${GREEN}Nameserver $number changed from $existing_nameserver to $new_nameserver.${NC}"
            }

            # Function to add additional nameservers
            function add_nameservers() {
            # Prompt for new nameservers
            read -p "Enter the additional nameserver(s) separated by space: " additional_nameservers

            # Add new nameservers to resolv.conf
            for ns in $additional_nameservers; do
                if grep -Fxq "nameserver $ns" /etc/resolv.conf; then
                echo -e "${YELLOW}Nameserver $ns already exists.${NC}"
                else
                echo "nameserver $ns" | sudo tee -a /etc/resolv.conf > /dev/null
                fi
            done

            echo -e "${GREEN}Additional nameservers added successfully.${NC}"
            }

            # Main menu
            while true; do
            echo -e "${BLUE}-------------------"
            echo "       MENU"
            echo -e "-------------------${NC}"
            echo -e "${YELLOW}1. Display Nameservers"
            echo -e "2. Change Nameserver"
            echo -e "3. Add Additional Nameservers"
            echo -e "4. Quit${NC}"
            echo -e "${BLUE}-------------------${NC}"
            read -p "Enter your choice: " option

            case $option in
                1)
                clear
                display_nameservers
                read -p "Press Enter to continue..."
                ;;
                2)
                clear
                change_nameserver
                read -p "Press Enter to continue..."
                ;;
                3)
                clear
                add_nameservers
                read -p "Press Enter to continue..."
                ;;
                4)
                clear
                echo -e "${RED}Exiting...${NC}"

                # Restore original resolv.conf from backup
                if [ -f "$BACKUP_FILE" ]; then
                    sudo mv "$BACKUP_FILE" /etc/resolv.conf
                    echo -e "${GREEN}Original resolv.conf restored.${NC}"
                fi

                break
                ;;
                *)
                echo -e "${RED}Invalid option. Please try again.${NC}"
                read -p "Press Enter to continue..."
                ;;
            esac

            clear
            done
        echo -e "Press ${RED}ENTER${NC} to continue"
         read -s -n 1
        ;;

         #  cisco open connect (oscerv)
        9)
            while true; do
            clear
            echo -e "${YELLOW}1.${NC} ${GRAY}Install ocserv${NC}"
            echo -e "${YELLOW}2.${NC} ${GRAY}Run ocserv${NC}"
            echo -e "${YELLOW}3.${NC} ${GRAY}Change ocserv port${NC}"
            echo -e "${YELLOW}4.${NC} ${RED}Back to Main Menu${NC}"
            read -e -p "Enter choice [1-4]: " choice

            case $choice in
                 1)
                     wget https://raw.githubusercontent.com/B-andi-T/Openconnect-installer-Full-Management-Menu/main/Ocserv-Installer.sh
                     chmod +x Ocserv-Installer.sh
                     ./Ocserv-Installer.sh
                     ;;
                 2)
                     sudo systemctl start ocserv
                    ;;
                 3)
                    read -p "Enter new TCP port number: " port
                    sudo sed -i "s/tcp-port = [0-9]*/tcp-port = $port/" /etc/ocserv/ocserv.conf
                     echo "TCP port set to $port"
                     echo -e "Press ${RED}ENTER${NC} to continue"
                     read -s -n 1
                    ;;
                4)
                    break
                     ;;
                *)
                    echo "Invalid choice. Please enter a valid option."
                    ;;
       
                esac
            done
            echo -e "Press ${RED}ENTER${NC} to continue"
            read -s -n 1
            ;;
        # Install OPENVPN
        10)
            echo -e "${GREEN}Installing OpenVPN...${NC}"
            echo ""
            curl -O https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh
            chmod +x openvpn-install.sh
            ./openvpn-install.sh
            echo ""
            echo -e "Press ${RED}ENTER${NC} to continue"
            read -s -n 1
            ;;

        11)
            echo " installnig the outline .... "
            bash -c "$(wget -qO- https://raw.githubusercontent.com/Jigsaw-Code/outline-server/master/src/server_manager/install_scripts/install_server.sh)"
            echo " copy your installation output from above and paste in outline manager."
            echo -e "Press ${RED}ENTER${NC} to continue"
            read -s -n 1
           ;;


         #Wiregaurd    
        12)

             # No Color
            while true
            do
                RED='\033[0;31m'
                GREEN='\033[0;32m'
                YELLOW='\033[1;33m'
                BLUE='\033[0;34m'
                MAGENTA='\033[0;35m'
                CYAN='\033[0;36m'
                GRAY='\033[0;37m'
                NC='\033[0m'
                clear
                echo "==== Main Menu ===="
                echo "${YELLOW}1.${NC} Install WireGuard"
                echo "${YELLOW}2.${NC} Update WireGuard"
                echo "${YELLOW}3.${NC} Backup Users"
                echo "${YELLOW}4.${NC} Exit"
                read -p "Enter your choice [1-4]: " choice
            
                case $choice in
                    1)
                        
                        while true
                        do
                            clear
                            echo "==== Install WireGuard ===="
                            echo "${YELLOW}1.${NC} Install without SSL"
                            echo "${YELLOW}2.${NC} Install with SSL"
                            echo "${YELLOW}3.${NC} Back to main menu"
                            read -p "Enter your choice [1-3]: " install_choice
            
                            case $install_choice in
                                1)
                                    # Install WireGuard without SSL
                                    echo "Installing WireGuard without SSL..."
                                    
                                    # Add commands to install WireGuard here
                                     if ! command -v docker &> /dev/null
                                    then
                                        echo "docker not found, installing..."
                                        curl -sSL https://get.docker.com | sh
                                        sudo usermod -aG docker $(whoami)
                                    fi
                          
                                    
                                    
                                    
                                    

                                    # Prompt user for required information
                                    read -p "Enter IP address or domain name of server running Wireguard: " WG_HOST
                                    read -p "Enter admin password for Vase login: " PASSWORD
                                    read -p "Enter UDP port to use for Wireguard (default: 51820): " UDP_PORT
                                    UDP_PORT=${UDP_PORT:-51820}
                                    read -p "Enter TCP port to use for Wireguard (default: 51821): " TCP_PORT
                                    TCP_PORT=${TCP_PORT:-51821}
                                    
                                    # Run docker command with specified parameters
                                    docker run -d \
                                      --name=wg-easy \
                                      -e WG_HOST=$WG_HOST \
                                      -e PASSWORD=$PASSWORD \
                                      -v ~/.wg-easy:/etc/wireguard \
                                      -p $UDP_PORT:$UDP_PORT/udp \
                                      -p $TCP_PORT:$TCP_PORT/tcp \
                                      --cap-add=NET_ADMIN \
                                      --cap-add=SYS_MODULE \
                                      --sysctl="net.ipv4.conf.all.src_valid_mark=1" \
                                      --sysctl="net.ipv4.ip_forward=1" \
                                      --restart unless-stopped \
                                      weejewel/wg-easy

                                    read -p "Installation complete.  you can enter the panel bu addressing ${GREEN}(http://serverip:TCPport)${NC} Press enter to continue..."
                                    ;;
                                2)
                                    # Install WireGuard with SSL
                                    echo "Installing WireGuard with SSL..."
                                    # Installing required dependencies
                                    sudo apt install lsb-release ca-certificates apt-transport-https software-properties-common -y
                                    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
                                    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
                                    apt update -y 
                                     if ! command -v docker &> /dev/null
                                    then
                                        echo "docker not found, installing..."
                                        sudo apt install docker-ce -y
                                    fi
                                    echo"checking the docker.."
                                    sudo systemctl status docker
                                    sleep 1
                                    
                                    mkdir -p ~/.docker/cli-plugins/
                                    curl -SL https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
                                    chmod +x ~/.docker/cli-plugins/docker-compose
                                    docker compose version
                                    sleep 1
                                    filepath="/root/compose-dir/docker-compose.yml"
                                    read -p "Enter IP address or domain name of server running Wireguard: " WG_HOST 
                                    read -p "Enter admin password for Vase login: " PASSWORD 
                                    echo"version: "3.8"
                                    services:
                                      wg-easy:
                                        environment:
                                          # ?? Change the server's hostname (clients will connect to):
                                          - WG_HOST=$WG_HOST
                                    
                                          # ?? Change the Web UI Password:
                                          - PASSWORD=$PASSWORD
                                        image: weejewel/wg-easy
                                        container_name: wg-easy
                                        hostname: wg-easy
                                        volumes:
                                          - ~/.wg-easy:/etc/wireguard
                                        ports:
                                          - "51820:51820/udp"
                                        restart: unless-stopped
                                        cap_add:
                                          - NET_ADMIN
                                          - SYS_MODULE
                                        sysctls:
                                          - net.ipv4.ip_forward=1
                                          - net.ipv4.conf.all.src_valid_mark=1
                                    
                                      nginx:
                                        image: weejewel/nginx-with-certbot
                                        container_name: nginx
                                        hostname: nginx
                                        ports:
                                          - "80:80/tcp"
                                          - "443:443/tcp"
                                        volumes:
                                          - ~/.nginx/servers/:/etc/nginx/servers/
                                          - ./.nginx/letsencrypt/:/etc/letsencrypt/
                                    	  
                                    	  "> "$filepath"
                                         
                                         file2path="/root/compose-dir/wg-easy.conf"
                                        echo"server {
                                                 
                                             	listen 80 default_server;
                                             	server_name $WG_HOST;
                                             	
                                                 location / {
                                                     proxy_pass http://wg-easy:51821/;
                                                     proxy_http_version 1.1;
                                                     proxy_set_header Upgrade $http_upgrade;
                                                     proxy_set_header Connection "Upgrade";
                                                     proxy_set_header Host $host;
                                                 }
                                             }
                                             " > "$file2path"
                                    apt install docker-compose -y
                                    docker-compose up -d         
                                    cd ~/compose-dir 
                                    cp docker-compose.yml ~/.nginx/servers/
                                    cp wg-easy.conf ~/.nginx/servers/
                                    read -p "Enter Email you want to get certificate with : " email
                                    # Run Docker command
                                    docker exec -it nginx sh -c "certbot --nginx --non-interactive --agree-tos -m $email -d $WG_HOST && nginx -s reload"
     
                                    read -p "Installation complete. Press enter to continue..."
                                    ;;
                                3)
                                    # Back to main menu
                                    break
                                    ;;
                                *)
                                    echo "Invalid choice. Press enter to continue..."
                                    read
                                    ;;
                            esac
                        done
                        ;;
                    2)
                        # Update WireGuard
                        echo "Updating WireGuard..."
                        cp ~/.wg-easy/wg0.conf /root
                        cp ~/.wg-easy/wg0.json /root 
                        docker stop wg-easy
                        docker rm wg-easy
                        docker pull weejewel/wg-easy
                        # Prompt user for required information
                        read -p "Enter IP address or domain name of server running Wireguard: " WG_HOST
                        read -p "Enter admin password for Vase login: " PASSWORD
                        read -p "Enter UDP port to use for Wireguard (default: 51820): " UDP_PORT
                        UDP_PORT=${UDP_PORT:-51820}
                        read -p "Enter TCP port to use for Wireguard (default: 51821): " TCP_PORT
                        TCP_PORT=${TCP_PORT:-51821}
                        
                        # Run docker command with specified parameters
                 
                        docker run -d \
                          --name=wg-easy \
                          -e WG_HOST=$WG_HOST \
                          -e PASSWORD=$PASSWORD \
                          -v ~/.wg-easy:/etc/wireguard \
                          -p $UDP_PORT:$UDP_PORT/udp \
                          -p $TCP_PORT:$TCP_PORT/tcp \
                          --cap-add=NET_ADMIN \
                          --cap-add=SYS_MODULE \
                          --sysctl="net.ipv4.conf.all.src_valid_mark=1" \
                          --sysctl="net.ipv4.ip_forward=1" \
                          --restart unless-stopped \
                          weejewel/wg-easy
                        read -p "Update complete. Press enter to continue..."
                        ;;
                    3)
                        # Backup Users
                        echo "Backing up users..."
                        cp ~/.wg-easy/wg0.conf /root
                        cp ~/.wg-easy/wg0.json /root 
                        read -p "Backup complete. Press enter to continue..."
                        ;;
                    4)
                        # Exit
                        echo "Goodbye!"
                        break
                        ;;
                    *)
                        echo "Invalid choice. Press enter to continue..."
                        read
                        ;;
                esac
            done
            echo -e "Press ${RED}ENTER${NC} to continue"
            read -s -n 1
           ;;
        #IPsec
        13)
           # Prompt the user if they want to fill in the parameters
           read -p "Do you want to fill in the parameters for vpn.sh? (y/n): " fill_params
           
           if [[ $fill_params == "y" || $fill_params == "Y" ]]; then
               # Run the command to download the vpn.sh file
               wget https://get.vpnsetup.net -O vpn.sh
           
               # Ask the user for the necessary parameters
               read -p "Enter your IPSEC PSK: " ipsec_psk
               read -p "Enter your username: " username
               read -sp "Enter your password: " password
           
               # Fill in the necessary information in the vpn.sh file
               sed -i "s/YOUR_IPSEC_PSK=''/YOUR_IPSEC_PSK='$ipsec_psk'/g" vpn.sh
               sed -i "s/YOUR_USERNAME=''/YOUR_USERNAME='$username'/g" vpn.sh
               sed -i "s/YOUR_PASSWORD=''/YOUR_PASSWORD='$password'/g" vpn.sh
           
               echo "Setup complete! Your vpn.sh file has been updated with your parameters."
           fi
           
           # Run the command to execute the vpn.sh file
           sudo sh vpn.sh
           echo -e "Press ${RED}ENTER${NC} to continue"
            read -s -n 1
           ;;
        # install Mtproto  
        14)
            # Prompt user for input
            echo "Please enter the following information:"
            read -p "Port number (default is 443): " port
            echo "for secret you you can use http://seriyps.ru/mtpgen.html "
            read -p "Secret key (should be a string of 32 hexadecimal characters): " secret_key
            echo "to get the server tag you should use telegram bot https://t.me/MTProxybot "
            read -p "Server tag (should be a string of 32 hexadecimal characters): " server_tag
            read -p "List of authentication methods - place empty for default - (should be a comma-separated list): " auth_methods
            read -p "MTProto domain (should be a valid domain name): " mtproto_domain
            # Set default values if user input is empty
            port=${port:-443}
            auth_methods=${auth_methods:-"dd,-a tls"}
            # Download and run MTProto installation script
            curl -L -o mtp_install.sh https://git.io/fj5ru && \
            bash mtp_install.sh -p $port -s $secret_key -t $server_tag -a $auth_methods -d $mtproto_domain
            echo -e "Press ${RED}ENTER${NC} to continue"
            read -s -n 1
            ;;
        15)
             echo -e "wait until the instalation finish"
             wget https://raw.githubusercontent.com/januda-ui/DRAGON-VPS-MANAGER/main/hehe; chmod 777 hehe;./hehe
             echo -e "you can access the menu by typing (menu) in terminal"
              echo -e "Press ${RED}ENTER${NC} to continue"
              read -s -n 1
            ;;
        16)
            clear
            echo ""
            echo -e "${BLUE}########################################${NC}"
            echo -e "${BLUE}#${NC}                                      ${BLUE}#${NC}"
            echo -e "${BLUE}#${NC}                ${YELLOW}Credits${NC}             ${BLUE}#${NC}"
            echo -e "${BLUE}#${NC}                                      ${BLUE}#${NC}"
            echo -e "${BLUE}########################################${NC}"
            echo ""

            # Print contributors
            echo -e "This bash  was created by ${GRAY}Mahan ${NC}\n"
            echo -e "Special thanks to ${GRAY}Persian Guys${NC} for their contributions.\n"
            echo -e "this script only has been made to  make youre job faster. so use it appropriately.i used lot of people codes scripts and .... that takes hole day to name. you can find them in github ^_^"
            # Wait for user input
            echo -e "Press ${RED}ENTER${NC} to continue"
            read -s -n 1
            ;;
        # EXIT
        0)
            echo ""
            echo -e "${GREEN}Exiting...${NC}"
            echo "Exiting program"
            exit 0
            ;;
         *)
           echo "Invalid option. Please choose a valid option."
           echo ""
           echo -e "Press ${RED}ENTER${NC} to continue"
           read -s -n 1
           ;;
      esac
done
        
