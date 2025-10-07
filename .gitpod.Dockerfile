FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

# ---- Paquets de base ----
RUN apt-get update && apt-get install -y \
    xfce4 xfce4-terminal xpra xauth xfonts-base dbus-x11 \
    neofetch htop tmux screen curl wget git unzip gnupg \
    python3 python3-pip imagemagick fonts-dejavu-core figlet && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# ---- Google Chrome ----
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" \
    > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && apt-get install -y google-chrome-stable && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# ---- Python modules ----
RUN pip install --no-cache-dir requests telethon colorama

# ---- VS Code ----
RUN wget -qO /tmp/vscode.deb https://update.code.visualstudio.com/latest/linux-deb-x64/stable && \
    dpkg -i /tmp/vscode.deb || apt-get install -f -y && rm /tmp/vscode.deb

# ---- NoMachine ----
RUN wget https://download.nomachine.com/download/7.14/Linux/nomachine_7.14.2_1_amd64.deb -O /tmp/nx.deb && \
    dpkg -i /tmp/nx.deb || apt-get install -f -y && rm /tmp/nx.deb

# ---- Script & user ----
COPY start-desktop.sh /usr/local/bin/start-desktop.sh
RUN chmod +x /usr/local/bin/start-desktop.sh
RUN useradd -m dev && echo "dev:dev" | chpasswd && adduser dev sudo

USER dev
WORKDIR /home/dev
