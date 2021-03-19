sudo rm /etc/modprobe.d/blacklist-nvidia-nouveau.conf
sudo bash -c "echo options nouveau tv_norm=PAL > /etc/modprobe.d/nouveau-kms.conf"
cat /etc/modprobe.d/nouveau-kms.conf
sudo apt purge nvidia-340
sudo apt autoremove
sudo update-initramfs -u
sudo reboot now
