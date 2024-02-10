#!/bin/bash

# Function to install Liquorix kernel on Ubuntu
install_liquorix_kernel_ubuntu() {
    sudo add-apt-repository ppa:damentz/liquorix
    sudo apt-get update
    sudo apt-get install linux-image-liquorix-amd64 linux-headers-liquorix-amd64
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

# Main function to determine the distribution and execute the installation
main() {
    if [ -f /etc/lsb-release ]; then
        # Ubuntu
        install_liquorix_kernel_ubuntu
        install_gaming_software_ubuntu
    elif [ -f /etc/fedora-release ]; then
        # Fedora
        install_gaming_software_fedora
    else
        echo "Unsupported distribution. Exiting."
        exit 1
    fi
}

# Execute the main function
main