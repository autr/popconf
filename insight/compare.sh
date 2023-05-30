#!/bin/zsh

# Store the path to the initial_packages.txt file
initial_packages_file="initial_packages.txt"

# Generate a list of currently installed packages
dpkg --get-selections | awk '{print $1}' > installed_packages.txt

# Compare the installed packages with the initial_packages.txt file and store the differences
comm -23 <(sort installed_packages.txt) <(sort $initial_packages_file) > installed_packages_diff.txt

# Rename installed_packages_diff.txt to installed_packages.txt
mv installed_packages_diff.txt installed_packages.txt

# Echo the list of installed packages
echo "The following packages are installed:"
cat installed_packages.txt

# Display a message indicating the process is complete
echo "The installed packages have been compared to $initial_packages_file. The list of installed packages has been saved to installed_packages.txt."
