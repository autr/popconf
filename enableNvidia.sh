sudo rm /etc/modprobe.d/nouveau-kms.conf
sudo bash -c "echo blacklist nouveau > /etc/modprobe.d/blacklist-nvidia-nouveau.conf"
sudo bash -c "echo options nouveau modeset=0 >> /etc/modprobe.d/blacklist-nvidia-nouveau.conf"
cat /etc/modprobe.d/blacklist-nvidia-nouveau.conf
sudo apt install nvidia-340
sudo update-initramfs -u
sudo reboot
