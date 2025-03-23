#################   For E5Plus wiyh SKRat
########################################
  
  GNU nano 5.4 
  /home/kev/update_klipper.sh 
  
read -p "Abort and Initiate Katapult mode on SKRat by double tap reset button,Check if in Katapult? Run ls /dev/serial/by-id, Press [Enter] to continue, or [Ctrl+C] to abort"

sudo service klipper stop
cd ~/klipper
git pull

make clean KCONFIG_CONFIG=config.skrat
make menuconfig KCONFIG_CONFIG=config.skrat
make KCONFIG_CONFIG=config.skrat
read -p "SKRat firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"
python3 ~/katapult/scripts/flashtool.py -f ~/klipper/out/klipper.bin -d /dev/serial/by-id/usb-Klipper_stm32g0b1xx_48003F000C504B4633373520-if00
read -p "SKRat firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"

make clean KCONFIG_CONFIG=config.ebb42
make menuconfig KCONFIG_CONFIG=config.ebb42
make KCONFIG_CONFIG=config.ebb42
read -p "EBB42 firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"

python3 ~/katapult/scripts/flash_can.py -i can0 -u 04690d648b91 -r
python3 ~/katapult/scripts/flash_can.py -i can0 -u 04690d648b91 -f ~/klipper/out/klipper.bin
read -p "EBB42 firmware flashed, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"

make clean KCONFIG_CONFIG=config.rpi
make menuconfig KCONFIG_CONFIG=config.rpi
make KCONFIG_CONFIG=config.rpi
read -p "RPi firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"

make flash KCONFIG_CONFIG=config.rpi
read -p "RPi firmware flashed, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"

read -p "Flashing complete, now restarting Klipper"

sudo service klipper start