#!/bin/sh

WAIT_GPIO() {
    sleep 0.1
}
#如果echo 17 > /sys/class/gpio/export报错，说明已经export过了，不需要再export
if [ ! -d /sys/class/gpio/gpio17 ]; then
    echo "17" > /sys/class/gpio/export; WAIT_GPIO
fi
echo "out" > /sys/class/gpio/gpio17/direction; WAIT_GPIO
echo "1" > /sys/class/gpio/gpio17/value; WAIT_GPIO
echo "0" > /sys/class/gpio/gpio17/value; WAIT_GPIO
#重启名字为lora_pkt_fwd的进程
killall lora_pkt_fwd; WAIT_GPIO
#开启名字为lora_pkt_fwd的进程
sudo /home/pi/sx1302_hal/packet_forwarder/lora_pkt_fwd -c /home/pi/sx1302_hal/packet_forwarder/global_conf.json.sx1250.EU868; WAIT_GPIO
echo "reset lr1302 success"
