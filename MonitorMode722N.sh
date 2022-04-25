#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"



function banner(){
clear
echo -e "\n${redColour}███╗   ███╗ ██████╗ ███╗   ██╗██╗████████╗ ██████╗ ██████╗     ███╗   ███╗ ██████╗ ██████╗ ███████╗"
sleep 0.05
echo -e "██╔████╔██║██║   ██║██╔██╗ ██║██║   ██║   ██║   ██║██████╔╝    ██╔████╔██║██║   ██║██║  ██║█████╗  "
sleep 0.05
echo -e "██║╚██╔╝██║██║   ██║██║╚██╗██║██║   ██║   ██║   ██║██╔══██╗    ██║╚██╔╝██║██║   ██║██║  ██║██╔══╝  "
sleep 0.05
echo -e "██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██║   ██║   ╚██████╔╝██║  ██║    ██║ ╚═╝ ██║╚██████╔╝██████╔╝███████╗"
sleep 0.05
echo -e "██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██║   ██║   ╚██████╔╝██║  ██║    ██║ ╚═╝ ██║╚██████╔╝██████╔╝███████╗"
sleep 0.05
echo -e "╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝    ╚═╝     ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝${endColour}"
sleep 0.05
echo -e "\n${purpleColour}[!] Ejecutar en modo root!"
}
function trueusb(){
comprobacion=$(lsusb | grep "TP-Link TL-WN722N" | cut -d " " -f 7,8)

if [[ $comprobacion == "TP-Link TL-WN722N" ]]; then
sleep 0.5
echo -e "\n${redColour}[+]${endColour}La tarjeta de red esta conectada"
return
else
echo -e "\n${redColour}[+]${endColour}La tarjeta de red no esta conectada"
fi
echo -e "\n${greenColour}> Cuando tengas conectada la tarjeta de red presiona: 1${endColour}"
read op
if [[ $op == 1 ]]; then
trueusb
fi
return
}

function monitor(){
echo -e "\n${greenColour}Configurando...${endColour}"
sleep 1
rmmod r8188eu.ko
modprobe 8188eu
echo -e "\n${redColour}[+]${endColour}${blueColour}Desconecta y conecta la tarjeta de red(Presiona 1 cuando lo hayas hecho): ${endColour}"
read op2
if [[ $op2 == 1 ]]; then
sleep 0.7
echo -e "\n${redColour}[+]Configurando antena en modo automatico...${endColour}"
iwconfig wlan0 mode auto
sleep 0.7
echo -e "\n${redColour}[+]Apagando antena...${endColour}"
ifconfig wlan0 down
sleep 0.7
echo -e "\n${redColour}[+]Configurando antena en modo monitor...${endColour}"
iwconfig wlan0 mode monitor
echo "La antena esta en modo monitor"
estado=$(iwconfig | grep "Monitor" | awk '{print $1}' | cut -d ':' -f2)
if [[ $estado == "Monitor" ]]; then
echo "La antena esta en modo monitor"
else
echo "La antena no esta en modo monitor o ocurrio un error"
fi
fi
return
}

#Main Program
banner
trueusb
monitor



