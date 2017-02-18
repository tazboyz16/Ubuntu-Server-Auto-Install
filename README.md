# Ubuntu Server Auto Install

Credit for begining work on Creating Custom Auto Install Server ISO
https://pricklytech.wordpress.com/2013/04/21/ubuntu-server-unattended-installation-custom-cd/

Steps on Ubuntu Desktop to create a Custom ISO
1)sudo mkdir -p /mnt/iso
2)cd Downloads (or location of Ubuntu iso)
3)sudo mount -o loop UbuntuServer.iso /mnt/iso
4)sudo mkdir -p /opt/serveriso
5)sudo cp -rT /mnt/iso /opt/serveriso
6)sudo chmod -R 777 /opt/serveriso/
7)cd /opt/serveriso
8)echo en >isolinux/langlist  (to set default/only Langangue)
9)sudo apt-get install system-config-kickstart (to create ks.cfg with encrypt password)
10)save the kickstart file ks.cfg to /opt/serveriso
11)edit /opt/serveriso/isolinux/txt.cfg
  make changes on default install
  At the end of the append line add ks=cdrom:/ks.cfg. You can remove quiet — and vga=788
12)create ISO with sudo mkisofs -D -r -V "ATTENDLESS_UBUNTU" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o /opt/autoinstall.iso /opt/serveriso

Plex deb file is to big for Github place in the myapps/install folder
