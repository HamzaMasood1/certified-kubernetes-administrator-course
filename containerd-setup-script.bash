#download containerd
wget https://github.com/containerd/containerd/releases/download/v1.6.10/containerd-1.6.10-linux-amd64.tar.gz
#move to path 
sudo mv ~/containerd-1.6.10-linux-amd64.tar.gz /usr/local
#unzip
sudo tar Cxzvf /usr/local /usr/local/containerd-1.6.10-linux-amd64.tar.gz
#download runc
wget https://github.com/opencontainers/runc/releases/download/v1.1.4/runc.amd64
#downlaod cni
wget https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz
#move and unzip
sudo mkdir -p /opt/cni/bin
sudo mv cni-plugins-linux-amd64-v1.1.1.tgz /opt/cni/bin/
sudo tar Cxzvf /opt/cni/bin /opt/cni/bin/cni-plugins-linux-amd64-v1.1.1.tgz
#setting up config
sudo mkdir /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
#set cgroup
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
#setting up systemd service
sudo curl -L https://raw.githubusercontent.com/containerd/containerd/main/containerd.service -o /etc/systemd/system/containerd.service
sudo systemctl daemon-reload
sudo systemctl enable --now containerd
sudo systemctl status containerd
