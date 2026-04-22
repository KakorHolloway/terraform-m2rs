# terraform-m2rs

## Préparation de la plateforme 

Créez une machine virtuelle basée sur Ubuntu 24.04 (https://ubuntu.com/download/server) avec dans l'idéal 4 vcpu, 8gb de ram et 40 gb de disk (attention lors de l'installation à ne pas partitionner votre disque en lvm)

Attention lors du déploiement à bien décocher la case lvm pour tout avoir dans une seule partition et installez openssh :

![Alt text](image.png)

![Alt text](ssh.png)

## Installation de devstack

Pour installer devstack, on va créer un utilisateur dédié nommé stack (facultatif)

```
sudo useradd -s /bin/bash -d /opt/stack -m stack
sudo chmod +x /opt/stack
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
```

Connectez vous avec l'utilisateur stack 

```
sudo -u stack -i
```

Téléchargez la source devstack 

```
git clone https://opendev.org/openstack/devstack
cd devstack
```

Créez le fichier dans le répertoire courant nommé local.conf

```local.conf
[[local|localrc]]
ADMIN_PASSWORD=secret
DATABASE_PASSWORD=$ADMIN_PASSWORD
RABBIT_PASSWORD=$ADMIN_PASSWORD
SERVICE_PASSWORD=$ADMIN_PASSWORD
```

Modifiez ADMIN_PASSWORD par le mot de passe de votre choix

**Faites un snapshot avant !**

lancez l'installation (temps estimé d'environ 15 minutes)

```
./stack.sh
```