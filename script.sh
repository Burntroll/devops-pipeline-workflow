#!/bin/bash

# Create a group called 'developers'
sudo groupadd developers

# Create two users: 'alice' and 'bob', and add them to the 'developers' group
echo "alice:password123" | sudo chpasswd
sudo chage -d 0 alice
echo "bob:password456" | sudo chpasswd
sudo chage -d 0 bob

# Create a directory called 'public' with read access for all users
sudo mkdir /var/www/public
sudo chmod 755 /var/www/public

# Create a directory called 'private' with read and write access for the 'developers' group
sudo mkdir /var/www/private
sudo chown :developers /var/www/private
sudo chmod 775 /var/www/private

# Create a directory called 'secret' with read and write access only for the 'alice' user
sudo mkdir /var/www/secret
sudo chown alice: /var/www/secret
sudo chmod 700 /var/www/secret

# Print the contents of the /etc/group file to verify that the group and users were created
echo "Contents of /etc/group:"
cat /etc/group

echo "Executing tests..."
pwd
ls
cat /etc/os-release
ls /home



# Install Apache web server
sudo apt-get update
sudo apt-get install apache2 -y

# Create a simple web page
echo "<html><body><h1>Hello World!</h1></body></html>" | sudo tee /var/www/html/index.html

# Restart Apache to apply changes
sudo systemctl restart apache2

# Print the IP address of the server
ip=$(hostname -I | awk '{print $1}')
echo "Web page available at http://${ip}"