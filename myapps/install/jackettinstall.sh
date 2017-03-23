#!/bin/bash


sudo adduser --disabled-password --system --home /opt/ProgramData/jackett --gecos "Jackett Service" --group jackett

sudo wget $(curl -s https://api.github.com/repos/Jackett/Jackett/releases/latest | grep 'Jackett.Binaries.Mono.tar.gz' | cut -d\" -f4)

sudo tar -xvf Jackett.Binaries.Mono.tar.gz && sudo rm Jackett.Binaries.Mono.tar.gz

sudo chown -R jackett:jackett /opt/Jackett


