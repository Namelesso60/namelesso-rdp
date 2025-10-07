#!/usr/bin/env bash
# XFCE + fond NAYDEN + Xpra + VS Code + NoMachine

# Démarrer dbus
if ! pgrep -x "dbus-daemon" > /dev/null; then
  /usr/bin/dbus-launch --exit-with-session /bin/bash -c "true"
fi

# Fond d'écran personnalisé
mkdir -p /home/dev/.local/share/backgrounds
convert -size 1920x1080 -gravity center -background '#101820' -fill '#f5f5f5' \
  -pointsize 40 label:'NAYDEN • Créé par Namelesso 🇳🇪' \
  /home/dev/.local/share/backgrounds/wall.png

# Bannière bienvenue
figlet -f slant "Bienvenue" > /home/dev/welcome.txt

# Lancer NoMachine
sudo /usr/NX/bin/nxserver --startup

# Démarrer XFCE via Xpra
XPRA_DISPLAY=":100"
xpra start $XPRA_DISPLAY --start-child="startxfce4" \
  --bind-tcp=0.0.0.0:14500 --html=on --daemon=no &

# Attendre et ouvrir terminal avec message de bienvenue
sleep 5
DISPLAY=$XPRA_DISPLAY xfce4-terminal --command="bash -lc 'clear; cat ~/welcome.txt; echo; neofetch; bash'" &

# Lancer VS Code
DISPLAY=$XPRA_DISPLAY code &

wait
