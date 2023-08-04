
#Installation des prérequis
echo "Installation des prérequis"
sudo sed -i "s/ALL=(ALL:ALL) ALL/ALL=(ALL:ALL) NOPASSWD:ALL/g" /etc/sudoers
sudo apt update && sudo apt upgrade -y
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common


#Installation de Docker
echo "Installation de Docker"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -y
sudo apt-get install -y docker-ce
sudo usermod -aG docker $USER && newgrp docker <<END

	#Installation de Minikube
	echo "Installation de Minikube"
	curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
	chmod +x ./minikube
	sudo mv ./minikube /usr/local/bin/
	minikube config set driver docker


	#Installation de la commande kubectl
	echo "Installation de la commande kubectl"
	curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	chmod +x ./kubectl
	sudo mv ./kubectl /usr/local/bin/

	#Démarrage de Minikube
	echo "Démarrage de Minikube"

	minikube start

	kubectl get namespaces 2>/dev/null >/dev/null
	if [ $? -eq 0 ]
	then
	  echo "Minukube est installé et foncitonne correctement"
	  echo "Installation OK"
	else  
	  echo "Il y a un soucis dans l'installation de Minikube"
	  echo "Installation KO"
	fi

END


