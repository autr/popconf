sudo apt purge nvidia-legacy-340xx-driver
sudo apt autoremove
sudo rm /etc/modprobe.d/blacklist-nvidia-nouveau.conf
sudo bash -c "echo options nouveau tv_norm=PAL > /etc/modprobe.d/nouveau-kms.conf"
cat /etc/modprobe.d/nouveau-kms.conf
sudo update-initramfs -u