#!/usr/bin/env sh
SCRIPTVERSION=0.0.3
# Function to display information about the script
show_about() {
    clear
    echo "This script installs gaming-related software and allows you to choose a kernel for supported distributions."
    echo "Author: eggplanredrage,znukem,suonabera"
    echo "Version: $SCRIPTVERSION"
    read -p "Press Enter to return to the main menu..."
}

# Function to install Liquorix kernel on Ubuntu
install_liquorix_kernel_ubuntu() {
    sudo add-apt-repository ppa:damentz/liquorix
    sudo apt-get update
    sudo apt-get install linux-image-liquorix-amd64 linux-headers-liquorix-amd64
}

# Function to install XanMod kernel on Ubuntu
install_xanmod_kernel_ubuntu() {
    # Add installation commands for XanMod kernel on Ubuntu
    echo "XanMod kernel installation on Ubuntu is not implemented in this example."
}

# Function to install gaming software on Ubuntu
install_gaming_software_ubuntu() {
    sudo apt-get install steam lutris
    # Add other gaming software installation commands as needed
}

# Function to install gaming software on Fedora
install_gaming_software_fedora() {
    sudo dnf install steam lutris
    # Add other gaming software installation commands as needed
}

# Function to display kernel submenu
kernel_submenu() {
    clear
    echo "Kernel Options"
    echo "1. Liquorix"
    echo "2. XanMod"
    read -p "Enter your choice: " kernel_choice

    case $kernel_choice in
        1) install_liquorix_kernel ;;
        2) install_xanmod_kernel ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
}

# Main function to display the main menu
main_menu() {
    clear
    echo "Main Menu"
    echo "1. About"
    echo "2. Run Script"
    echo "3. Exit"
    read -p "Enter your choice: " main_choice

    case $main_choice in
        1) show_about ;;
        2) main ;;
        3) exit ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
}

# Main function to determine the distribution and execute the installation
# this code author is suonabera
main() {

    # /etc/os-release grants us to check which OS this is.
    # It was originally implemented by freedesktop.org[1] to
    # let programs check what kind of distribution or OS
    # the system is running. Neofetch uses this to detect
    # the current system.
    # [1]: https://www.freedesktop.org/software/systemd/man/latest/os-release.html

    # Behavior description: If the file is found, the script
    # checks $NAME against other if conditions for the supported
    # systems. If none of them are there, well, the script exists.
    # If the file is not found, the script exits.
    # return numbers:
    # 1: /etc/os-release not found
    # 2: system unsupported

    if [ -f /etc/os-release ]; then
        . /etc/os-release
    else
        echo "ERROR: Cannot detect current system. The script will now exit"
        exit 1
    fi

    # Here follow the conditions which are checked against $NAME.
    if [ "$NAME" = "Fedora Linux" ]; then
        echo "Fedora Linux detected!"
        install_gaming_software_fedora
        exit 0
    fi

    if [ "$NAME" = "Ubuntu Linux" ]; then
        echo "Ubuntu detected!"
        kernel_submenu
            install_gaming_software_ubuntu
        exit 0
    fi
    
    # If it ever reaches this point, the distribution in $NAME
    # is not in any if conditions, therefore it is not supported.
    
    echo "ERROR: Distribution not supported."
    exit 2
}
# Execute the main menu function
main_menu
