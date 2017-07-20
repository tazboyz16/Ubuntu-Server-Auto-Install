sudo adduser --disabled-password --system --home /opt/ProgramData/LazyLibrarian --gecos "LazyLibrarian Service" --group LazyLibrarian

cd /opt &&  git clone https://github.com/DobyTang/LazyLibrarian.git

sudo chown -R LazyLibrarian:LazyLibrarian /opt/LazyLibrarian
sudo chmod -R 0777 /opt/LazyLibrarian

echo "Creating Startup Script" 
cp /opt/install/Lazylibrarian/LazyLibrarian.service /etc/systemd/system/
chmod 644 /etc/systemd/system/LazyLibrarian.service
systemctl enable LazyLibrarian.service
systemctl restart LazyLibrarian.service
