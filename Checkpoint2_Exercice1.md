# <ins>**Exercice 1 : Modification IP client serveur**</ins>     

   
## **Q.1.1**    

**Ping en IPV4**     

#### **a. Adresse IP du PC Serveur :**   

![EX1SERV_1](https://github.com/user-attachments/assets/aadeac6b-6212-434b-b906-f57d9b69686f)     



Caractéristiques IP PC Serveur obtenues avec la commande `ipconfig` :       
- L'adresse IP du serveur est **172.16.10.10**.           
- Le CIDR est **24** (masque de sous réseau 255.255.255.0).                 
- Pas de passerelle par défaut.    

#### **b. Adresse IP du PC Client : **    

![IMC_1](https://github.com/user-attachments/assets/caa98694-1f00-43ee-b7b7-a472e2748d66)     

Caractéristiques IP PC Client obtenues avec la commande `ipconfig` :     
- L'adresse IP du serveur est **172.16.100.50**.   
- Le CIDR est **24** (masque de sous réseau 255.255.255.0).   
- Pas de passerelle par défaut.     

#### **c. Ping du serveur vers le client**

**Résultat obtenu avec la commande `ping 172.16.100.50` :**     

![IMS2](https://github.com/user-attachments/assets/9551ddee-39b8-4c6f-84b7-f3fb61442dbc)



**Réponse du Ping :**    
**PING transmit failed. General failure. **

**Solution :**:   

Les deux PC ne sont pas dans le même sous-réseau :   
- Le PC Serveur appartient au réseau **172.16.10.0**.    
- Le PC Client appartient au réseau **172.16.100.0**.
- 
Pour qu'ils puissent se pinger, il faut déplacer le PC client dans le même réseau que le PC Serveur.
Pour cela, changez le troisième octet de l'adresse IP du PC Client en **10**, comme le PC Serveur.
  
**Modifications sur PC client :**   
Modification de l'adresse IP  :    

Se positionner dans les propriétés IPV4 du PC client.   
Chemin pour y accéder dans les menus :

- Cliquer avec le bouton droit de la sourie sur le logo windows en bas a gauche.   
- Cliquer sur connections réseau.   
- Cliquer sur Ethernet (menu à gauche).   
- Cliquer sur Modifier les options d'adaptateur.      
- Cliquer sur "Protocole  Internet version 4 (TCP/IPv4).     
- Cliquer sur le bouton propriété qui vient de se dégriser.


![IMC2](https://github.com/user-attachments/assets/2663ece7-7a44-4b69-b930-f8617cf72003)



Vérification de l'adresse IP du PC Client avec la commande `ipconfig` : La nouvelle adresse IP est **172.16.10.50**.

 

 
Taper la commande `ipconfig` :
la nouvelle adresse IP est bien : **172.16.10.50**     

![IMC3](https://github.com/user-attachments/assets/ad09900a-561a-4ad2-bdbb-8658e87f17a3)


### **Ping du PC client :**

Sur le PC Serveur, tapez la commande `ping 172.16.10.50`. Le ping fonctionne, les deux PC appartiennent maintenant au même réseau **172.16.10.0**.
  
![IMS3](https://github.com/user-attachments/assets/502bf406-c29d-4464-a2e4-93ddd323b34f)     


## **Q.1.2**     

### **Ping avec le nom des machines**     


Le DHCP et le DNS sont installés sur le PC Serveur.      

![IMS4](https://github.com/user-attachments/assets/610fc527-03da-4d7a-b30d-3dea3c21d9a3)       



Pour pouvoir faire un ping avec le nom des machines, les PC doivent appartenir au même domaine.


**Vérification du nom du PC Serveur :**    

1. Clic droit sur l'icône Windows en bas à gauche.     
2. Choisir "Système".
    
![IMS5](https://github.com/user-attachments/assets/228d6b5b-2a88-4f2e-ba24-0d063a19e63c)    

3. Cliquer sur "Renommer ce PC (avancé)".   

![IMS6](https://github.com/user-attachments/assets/4a022fab-a962-4634-91b6-caa7630e8919)     

Le PC Serveur s'appelle **"WINSERV"** .     

**Ping du PC Serveur depuis le PC Client :**     

Dans l'invite de commande du PC Client, tapez `ping winserv`. Le PC Serveur répond.

![IMC8](https://github.com/user-attachments/assets/6c64082e-b7c9-49ce-990b-c89411818cfd)    
  

**Nom du PC Client :**
1. Clic droit sur l'icône Windows en bas à gauche.
2. Choisir "Système".

![IMC5a](https://github.com/user-attachments/assets/b3019dde-c64d-48d2-883a-14eaf6d554a1)     


Le nom du PC Client est **"client1"**.


**Ping du PC Client depuis le PC Serveur :**     

Dans l'invite de commande du PC Serveur, tapez `ping client1`. Le PC Client répond.    

![IMS7](https://github.com/user-attachments/assets/410282fe-42aa-4e00-8bc1-5ac3064c8618)     


**Ping du pc Serveur à partir du pc client :**     

Se rendre dans la fenêtre de commande (CMD) du pc client puis faire la commande :

**`ping winserv`**   

![IMS9](https://github.com/user-attachments/assets/e01c89da-1179-44ae-8cfb-2f46918afe4f)    

Le pc Serveur repond quand on ping son nom (winserv).    


Le PC client repond bien au ping de son nom (client1) et inversement pareil le pc serveur repond bien au ping de son nom.   

Il fait partie du même réseau et du même domaine DNS.

Explications :   

Lorsque le rôle DNS est installé sur le serveur Windows Server 2022 (winserv), il agit comme un serveur DNS pour son réseau. Voici pourquoi on peut faire un ping sur le nom du PC client (client1) à partir du PC serveur :

- Résolution de noms DNS : Le rôle DNS sur winserv permet de résoudre les noms de domaine en adresses IP. Lorsqu'on exécute la commande ping client1, le serveur DNS (winserv) traduit le nom “client1” en son adresse IP correspondante. Cela permet au serveur de savoir à quelle adresse IP envoyer les paquets ICMP pour le ping.
- Enregistrement DNS : Lorsque le client (client1) obtient une adresse IP via DHCP, le serveur DHCP peut automatiquement mettre à jour le serveur DNS avec un enregistrement A (adresse) pour le client. Cela signifie que le nom “client1” est associé à une adresse IP spécifique dans la base de données DNS.

En résumé, grâce au rôle DNS installé sur winserv, le serveur peut résoudre le nom “client1” en une adresse IP, permettant ainsi de pinger le PC client par son nom.    


## **Q.1.3**    

Pour désactiver le protocole IPV6 :

Il faut retourner comme effectué déjà auparavant dans les propriétés "Ethernet".

     
![IMC6](https://github.com/user-attachments/assets/8172407d-704f-4bb8-acbd-9f7c5a630f1c)    

Décocher la case de "Protocole Internet version 6 (TCP/IPv6)" (en bleu sur l'image ci-dessous) puis valider avec le bouton OK.    

![IMC7](https://github.com/user-attachments/assets/4b8fd580-eb78-4041-9089-98008006ceb3)    


Effectuer la même opération sur le PC serveur.
Pour aller plus vite pour se rendre dans connections réseaux, taper ncpa.cpl puis executer.   
decocher IPV6 comme sur la capture d'écran ci-dessous :

![IMS8a](https://github.com/user-attachments/assets/cf930362-c4c0-4c91-9dbf-137eeca988ad)     

Ping sur les deux PC :

PC "WINSERV" :

![IMS9](https://github.com/user-attachments/assets/f21a1d32-7c35-4c09-a50a-626a4b087451)

PC "client1".

Le ping s'effectue toujours.


## **Q.1.4**


**PC Serveur :**   

Le DHCP est déjà installé sur le serveur comme on peut le constater dans la fenêtre **"Server Manager"** (voir capture ci dessous).   

![IMS10](https://github.com/user-attachments/assets/18ea5207-77b2-4815-93a7-5c8ada9240dd)

On voit que DHCP est installé car il est en vert.      
  
**PC Client :**
Sur le PC client une adresse IP fixe était paramétrée(changée pour question 1.2). 
Pour qu'il soit configuré pour le DHCP, il faut retourner dans les paramètres de l'adaptateur .    

![IMC9](https://github.com/user-attachments/assets/98f44dc4-47c8-4efc-9a95-7ec09cdffc31)

Puis cocher "Obtenir une adresse IP automatiquement" (surligné sur capture ci-dessus).


## **Q.1.5**



Pour aller dans la configuration du serveur DHCP :     
Dans "Server Manager" Aller dans le menu "Tools" puis cliquer sur "DHCP".

![IMS12](https://github.com/user-attachments/assets/b627a02b-f258-47a3-ab3e-2a0c57936497)    


Dans "Scope" (étendue)-->Address Pool :
On voit une étendue de plages IP comprise entre 172.16.10.1 et 172.16.10.254 qui est destinée à être adressée pour les ordinateurs clients. 
On voit également que les adresses ip allant de 172.16.10.1 à 172.16.10.19 et allant de 172.16.10.241 à 172.16.10.254 sont exclues de la distribution.
Si une adresse ip est distribuée, elle commencera donc à 172.16.10.20 et le dernier octet pourra aller jusqu'à 254 puisque qu'on a un cidr de 24.   

Dans "Scope Option" on voit que l'option "006 DNS server" est activée avec l'adresse ip 172.16.10.10.    
 
![IMC10](https://github.com/user-attachments/assets/0b62a978-660e-474a-ad91-02ec6df17293)    


L'option 006 DNS Server avec l'adresse IP 172.16.10.10 signifie que tous les clients DHCP recevront cette adresse IP comme serveur DNS.     
Autrement dit, 172.16.10.10 est le serveur DNS que les clients vont utiliser pour résoudre les noms de domaine en adresses IP.



Dans l'invite de commande, la commande `ipconfig` montre que l'adresse ip que j'avais modifié dans une question précédente est maintenant 172.16.10.20.
Elle a donc été attribuée automatiquement. Le DHCP fonctionne et a adressé la première Adresse ip distribuable.

![IMC11](https://github.com/user-attachments/assets/3921352f-4ea6-411e-91a4-7785a493ca5e)     
 



## **Q.1.6**   

Configuration du dhcp pour une Attribution d'adresse ip 172.16.10.15 au PC client.
Pour être sûr que le pc client1 obtienne cette ip, il faut lui reserver l'adresse.

- PC client1 :
Aller chercher l'Adresse MAC dans l'invite de commande en tapant la commande ipconfig /all.

![IMC11](https://github.com/user-attachments/assets/43542b24-d0a7-4297-9051-00656c2f2ae1)     


l'Adresse MAC est :08-00-27-71-0B-AF

- PC serveur :
Dans la fenêtre de configuration DHCP, dans le menu "scope"->"reservations" :
Faire un clic droit et choisir "new reservation".

![IMC12](https://github.com/user-attachments/assets/9453046f-cf23-4e96-86a7-012acea90152)    


Remplir les champs surlignés puis valider en cliquant sur "Add".   

![IMS13](https://github.com/user-attachments/assets/b6abdf7b-5a73-462e-967e-d6254a5f76d4)


On peut constater en dessous de reservation que l'IP 172.16.10.15 est reservee pour l'adresse MAC du PC Client1.     

- PC  client :     

Sur le PC client dans l'invite de commande, taper les commandes suivantes :    

`ìp config /release` suivie de `ipconfig /renew`  

"ipconfig /release" est utilisé pour libérer l'adresse IP.    
"ipconfig /renew" est utilisé pour renouveler et obtenir une nouvelle adresse IP.

![IMC13](https://github.com/user-attachments/assets/94cfc612-69c6-4795-b9cc-9a1505635292)    

La capture d'écran du dessus montre bien la nouvelle adresse IP qui correspond bien à l'attendu.


## **Q.1.7**    

Passer le réseau en IPv6 présente plusieurs avantages :

**Épuisement des adresses IPv4 :**    

L'IPv4 utilise des adresses de 32 bits, ce qui limite le nombre total d'adresses uniques disponibles.     
**L'IPv6 utilise des adresses de 128 bits, offrant un espace d'adressage beaucoup plus large, éliminant ainsi le problème d'épuisement des adresses.**    

**Configuration automatique :**    

**L'IPv6 permet une configuration automatique des adresses (SLAAC - Stateless Address Autoconfiguration), simplifiant ainsi la gestion des adresses IP.**     

**Meilleure performance et sécurité :**      

**L'IPv6 inclut des fonctionnalités de sécurité intégrées comme IPsec (bien qu'IPsec puisse également être utilisé avec IPv4).**     
**De plus, il améliore l'efficacité du routage et réduit la taille des tables de routage.**      


## **Q.1.8**   


**- Est-ce que dans ce cas le serveur DHCP est obsolète ?**   
   


**Le serveur DHCP n'est pas obsolète avec IPv6, mais son rôle est légèrement différent.**     

En IPv6, deux types de configuration sont possibles :      

SLAAC (Stateless Address Autoconfiguration) :     

Les appareils peuvent s'auto-configurer une adresse IP en utilisant des annonces de routeur (RA - Router Advertisement).     


DHCPv6 (Dynamic Host Configuration Protocol for IPv6) :      


Semblable à DHCP pour IPv4, DHCPv6 peut être utilisé pour attribuer des adresses IPv6 et d'autres configurations réseau aux appareils.       


Pour que le serveur DHCP reste actif et permette de gérer les adresses IPv6 :            


**- Activer et configurer DHCPv6 sur le serveur DHCP :**


Accéder au gestionnaire DHCP sur le serveur WINSERV.    

Ajouter et configurer un "New Scope" DHCPv6 dans le menu IPV6 de la fenêtre de configuration DHCP en spécifiant une plage d'adresses IPv6.   

Configurer les options DHCPv6 nécessaires (comme les adresses DNS).     

Configurer les clients pour utiliser DHCPv6 :     

S'assurer que les clients sont configurés pour utiliser DHCPv6 pour l'attribution d'adresses et autres paramètres réseau.     

En configurant DHCPv6, on peut continuer à gérer les adresses IP et autres paramètres réseau de manière centralisée, même dans un environnement IPv6.   

On peut réserver par exemple une adresse IPV6 comme fait en IPV4 pour client1.    
   
     






