#!/bin/bash

# Function to install Jenkins
install_jenkins() {
    sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get install -y jenkins
}

# Check if Jenkins is already installed
if jenkins -v > /dev/null 2>&1; then
    echo "Jenkins already installed: $(jenkins -v)"
else
    install_jenkins
fi

# Enable and start Jenkins service
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins

# Install Java
sudo apt-get update
sudo apt-get install -y fontconfig openjdk-17-jre
java -version

# Display the initial Jenkins admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

