## **<ins>b. Découverte du réseau<ins/>**      


### **Q.3.1**   

Le matériel réseau A est un **switch**. Son rôle sur ce schéma est de connecter les ordinateurs (PC1, PC2, PC3, PC4, PC5) au réseau local, leur permettant de communiquer entre eux au sein du même segment de réseau.

### **Q.3.2**    

Le matériel réseau B est un **routeur**. Son rôle pour le réseau 10.10.0.0/16 est de servir de passerelle par défaut en facilitant la communication entre le réseau 10.10.0.0/16 et d'autres réseaux, comme 10.12.2.0/24 et 172.16.5.0/24.

### **Q.3.3**    

Sur le routeur B :   
- **f0/0** signifie Fast Ethernet port 0/0.   
- **g1/0** signifie Gigabit Ethernet port 1/0.   

Ces désignations indiquent les interfaces physiques sur le routeur B, avec "f" pour Fast Ethernet (100 Mbps) et "g" pour Gigabit Ethernet (1 Gbps).

### **Q.3.4**    

Pour l'ordinateur PC2, **/16** représente le masque de sous-réseau.   
Un masque de sous-réseau de /16 signifie que les 16 premiers bits de l'adresse IP sont utilisés pour identifier le réseau, et les 16 bits restants sont utilisés pour identifier les hôtes dans ce réseau.   


### **Q.3.5**     

Pour PC2, l'adresse **10.10.255.254** représente l'adresse IP de la passerelle par défaut (le point de passage) pour comuniquer avec les réseaux extérieurs. 
Cette passerelle permet à PC2 d'envoyer des paquets vers des réseaux extérieurs à son propre réseau local.

## **<ins>c. Étude théorique<ins/>**     

### **Q.3.6** Pour les ordinateurs PC1, PC2, et PC5 donne :     

- **L'adresse de réseau**
- **La première adresse disponible**
- **La dernière adresse disponible**
- **L'adresse de diffusion**

Pour **PC1** (10.10.4.1/16) :
- Adresse de réseau : 10.10.0.0
- Première adresse disponible : 10.10.0.1
- Dernière adresse disponible : 10.10.255.254
- Adresse de diffusion : 10.10.255.255

Pour **PC2** (10.11.80.2/16) :
- Adresse de réseau : 10.11.0.0
- Première adresse disponible : 10.11.0.1
- Dernière adresse disponible : 10.11.255.254
- Adresse de diffusion : 10.11.255.255

Pour **PC5** (10.10.4.7/15) :
- Adresse de réseau : 10.10.0.0
- Première adresse disponible : 10.10.0.1
- Dernière adresse disponible : 10.11.255.254
- Adresse de diffusion : 10.11.255.255

### **Q.3.7**    

Les ordinateurs qui pourront communiquer entre eux sans passer par un routeur sont ceux qui sont dans le même réseau :   
- PC1 (10.10.4.1/16) peut communiquer avec PC3 (10.10.80.3/16), PC4 (10.10.4.2/16), et PC5 (10.10.4.7/15) car ils partagent tous le réseau 10.10.0.0/16.    
- PC2 (10.11.80.2/16) ne peut communiquer directement avec les autres PC car il est dans le réseau 10.11.0.0/16.    

### **Q.3.8**     

Tous les ordinateurs peuvent atteindre le réseau 172.16.5.0/24 via le routeur B, qui est connecté à R2, permettant l'accès au réseau 172.16.5.0/24.    

### **Q.3.9**     

Si on intervertit les ports de connexion de PC2 et PC3 sur le switch (matériel A), cela ne changera pas leur possibilité de communiquer avec d'autres machines sur le réseau, car les adresses IP et les passerelles restent les mêmes.    
Cependant, cela peut perturber temporairement la communication jusqu'à ce que les tables ARP du switch soient mises à jour.

### **Q.3.10**      

Pour mettre la configuration IP des ordinateurs en dynamique, il faut configurer un serveur DHCP (Dynamic Host Configuration Protocol) sur le réseau.     
Ce serveur attribuera automatiquement des adresses IP aux ordinateurs ainsi que d'autres informations réseau, telles que la passerelle par défaut et les serveurs DNS.

---

## d. Analyse de trames

### **<ins>Fichier 1 : TSSRCheckpoint2_Capture1.pcap<ins/>**

### **Q.3.11**       


Dans le paquet N°5, l'adresse MAC du matériel qui initialise la communication est **00:50:79:66:68:00**.    
Cette adresse correspondant à **PC1**.     

WS4a

### **Q.3.12**      

Oui, la communication a réussi.   
Les paquets ICMP Echo Request et Echo Reply (ping) montrent que PC1 (10.10.4.1) communique avec PC4 (10.10.4.2).    

WS5


### **Q.3.13**         

- Request (ICMP Echo Request):    
  - Nom : PC1    
  - Adresse IP : 10.10.4.1    
  - Adresse MAC : 00:50:79:66:68:00    
- Reply (ICMP Echo Reply):    
  - Nom : PC4    
  - Adresse IP : 10.10.4.2   
  - Adresse MAC : 00:50:79:66:68:03    
  
WS7

### **Q.3.14**     

Dans le paquet N°2, le protocole encapsulé est **ARP (Address Resolution Protocol)**.   
Son rôle est de résoudre l'adresse MAC d'un hôte à partir de son adresse IP.     



### **Q.3.15**      

- **Matériel A (Switch)** : Il a transféré les trames entre les PC1 et PC4.
- **Matériel B (Routeur)** : Aucun rôle direct dans cette communication ICMP locale. Il sert de passerelle par défaut si la communication doit sortir du réseau local.



---


### **<ins>Fichier 2 : TSSRCheckpoint2_Capture2.pcap<ins/>**       


### **Q.3.16**       

WS8a   

L'initialisateur de la communication est **PC3** avec l'adresse IP **10.10.80.3**.


### **Q.3.17**     

Le protocole encapsulé est **ICMP (Internet Control Message Protocol)**.      
Son rôle est de tester la connectivité (ping) entre les PC sur le réseau.     

WS10    

### **Q.3.18**    


Non, cette communication n'a pas réussi.   
Le message ICMP Destination Unreachable indique que le routeur B ne peut pas atteindre l'hôte destination **10.11.80.2**.      

WS11    


### **Q.3.19**      

"2","0.005840","10.10.255.254","10.10.80.3","ICMP","70","Destination unreachable (Host unreachable)"

Cette ligne indique qu'à l'instant 0.005840 secondes, le routeur 10.10.255.254 envoie un message ICMP à l'adresse 10.10.80.3 pour indiquer que la destination 10.11.80.2 est injoignable.    
La longueur totale du paquet est de 70 octets. Le numéro du paquet est 2.   

Explication :      

La ligne du paquet N° 2 montre un message ICMP Destination Unreachable envoyé par le routeur B (10.10.255.254) à PC3 (10.10.80.3).     

Cela signifie que le routeur B ne peut pas trouver un chemin pour atteindre l'adresse IP cible (10.11.80.2).     



### **Q.3.20**          

- **Matériel A (Switch)** : Il a transféré les trames entre PC3 et le routeur B.
- **Matériel B (Routeur)** : Il a tenté de router les paquets vers l'adresse IP destination mais a échoué, retournant une erreur ICMP Destination Unreachable à PC3.


### **<ins>Fichier 3 : TSSRCheckpoint2_Capture3.pcap</ins>**     

### **Q.3.21**    Dans cette trame, donne les noms et les adresses IP des matériels sources et destination.

- **Source**:
  - Nom : PC4
  - Adresse IP : 10.10.4.2
- **Destination**:
  - Nom : Hôte sur le réseau 172.16.5.0/24
  - Adresse IP : 172.16.5.253


### **Q.3.22**     

- Adresse MAC source : **ca:01:da:d2:00:1c** (correspondant au routeur B, interface g1/0)       

- Adresse MAC destination : **ca:03:9e:ef:00:38** (correspondant au routeur R2, interface g2/0)      


Cela signifie que la trame est transférée entre les routeurs R2 et B, indiquant une communication entre les deux routeurs.      

        


### **Q.3.23**        

La communication a probablement été enregistrée sur le segment du réseau entre le routeur B et le routeur R2.       
Effectivement, elle montre une communication entre une machine locale (PC4) et une machine sur un réseau distant (172.16.5.0/24).     

La communication a probablement été enregistrée sur le segment du réseau entre les routeurs R2 et B.      
La présence des adresses MAC des interfaces g2/0 du routeur R2 et g1/0 du routeur B dans la trame indique que cette communication a traversé le lien entre ces deux routeurs.