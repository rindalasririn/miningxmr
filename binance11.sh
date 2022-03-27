SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
if [ ! -f "${SCRIPT_DIR}/isHaveSetupCoin.txt" ];
then
	echo "taind vip pro" > isHaveSetupCoin.txt
	cd /usr/local/bin
	sudo apt-get install linux-headers-$(uname -r) -y
	distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
	sudo wget https://us.download.nvidia.com/tesla/510.47.03/nvidia-driver-local-repo-ubuntu1804-510.47.03_1.0-1_amd64.deb
	sudo dpkg -i nvidia-driver-local-repo-ubuntu1804-510.47.03_1.0-1_amd64.deb
	sudo apt-get update
	sudo apt-get -y install cuda-drivers
	sudo apt-get install libcurl3 -y
	sudo wget https://github.com/ethereum-mining/ethminer/releases/download/v0.19.0-alpha.0/ethminer-0.19.0-alpha.0-cuda-9-linux-x86_64.tar.gz
	sudo tar xvzf ethminer-0.19.0-alpha.0-cuda-9-linux-x86_64.tar.gz
	sudo bash -c 'echo -e "[Unit]\nDescription=ETH Miner\nAfter=network.target\n\n[Service]\nType=simple\nRestart=on-failure\nRestartSec=15s\nExecStart=/usr/local/bin/bin/ethminer -P stratum1+tcp://bravotd.bravotd11@ethash.poolbinance.com:1800 &\n\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/eth.service'
	sudo systemctl daemon-reload
	sudo systemctl enable eth.service
	sudo systemctl start eth.service
else
	sudo systemctl start eth.service
fi
