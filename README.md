# terraform-m2rs

## Préparation de la plateforme 

Créez une machine virtuelle basée sur Ubuntu 24.04 (https://ubuntu.com/download/server) avec dans l'idéal 4 vcpu, 8gb de ram et 40 gb de disk (attention lors de l'installation à ne pas partitionner votre disque en lvm)

Attention lors du déploiement à bien décocher la case lvm pour tout avoir dans une seule partition et installez openssh :

![Alt text](image.png)

![Alt text](ssh.png)

Fixez l'adresse ip de votre vm ubuntu avec netplan :

https://oleks.ca/2024/10/05/configuration-dune-address-ip-statique-sur-ubuntu-24-04/


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

# Installation de terraform en local 

Téléchargez le zip suivant : 

https://releases.hashicorp.com/terraform/1.14.2/terraform_1.14.2_windows_amd64.zip

Mettez le binaire terraform.exe dans le dossier C:/Windows/System32

Au besoin, redémarrez votre client powershell pour voir la commande terraform remonter. 

Doc de manière générale : 
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

# Initialisation du projet :

Modifiez le fichier clouds.yaml pour que ce dernier corresponde à votre mot de passe, votre ip et l'id du projet admin que vous trouverez comme ceci :

![Alt text](openstack.png)

En vous rendant dans le dossier openstack lancez la commande ```terraform init```

Normalement, si la commande marche c'est que vous avez bien tout initié. 

Exercice 1 : 

Créez un fichier nommé project-01.tf, et à partir de ce fichier créez un nouveau projet Openstack nommé TERRAFORM

## Exo 2: 
Créez un fichier user-01.tf

Créez à partir de ce fichier un nouvel utilisateur. 

Faites en sorte que cet utilisateur possède le projet TERRAFORM en tant que projet de connexion par défaut. 

## Exo 3: Ajout d'un utilisateur existant 

Par défaut, lors de l'installation d'Openstack avec Devstack, des éléments sont générés. 

Parmis ces éléments, on retrouve un utilisateur nommé "demo". 

Afin de tester le mécanisme d'import, recréez cet utilisateur dans le fichier user-02.tf, et à l'aide de la documentation des objet user dans terraform (voir en bas de page), importez ce dernier. 

Testez avec un terraform plan que l'import c'est bien passé. 

## Exo 4 : utilisation d'un data 

Dans un fichier nommé role-03.tf, récupérez via un data le role reader en vu d'une utilisation future 

Via ce data, donnez le role reader à l'utilisateur ipi que vous aviez créé

## Exo 5 les variables :

Créez une infrastructure contenant une machine virtuelle, un réseau et ses dépendances pour tout faire fonctionner. (Le tout dans le projet que vous avez créé) Attention à prendre le plus petit gabarit de vm possible. 
Mettez un début de nom identique pour toutes vos ressources, les variables seront initiées dans un fichier variables.tf
Les variables à créer devront permettre de créer des projets vm… qui contiendrons le nom dev ou prod en fin de ressource (ex: monprojet-dev) 
A partir de là, créez deux fichiers dev.tfvars et prod.tfvars. 
Ces deux fichiers doivent permettre de déployer un environnement de production ou de développement. 
Un problème va se produire avec ce mécanisme, quel est-il ? 

## Exo 6

Via les backends déployez un projet de prod et un projet de dev avec chacun leurs propres tfstates sans utiliser terragrunt

```
terraform init -backend-config=path=prod/terraform.tfstate -var-file=prod.tfvars -reconfigure

```

## Exo 7

En fonction de la variable env, si celle-ci indique prod, faites en sorte que le gabarit de la vm soit légèrement plus grand qu'à l'acoutumé. 

## Pour la prochaine fois : voir les modules et évaluation à prévoir