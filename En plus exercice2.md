# **Exercice 2 : Débogage de script PowerShell**     
   
## **Q.2.1**    


Pour pouvoir récupérer les fichiers de script de l'exercice 2, on va créer un dossier de partage sur le réseau.     

- Voici la démarche entreprise pour créer un dossier de partage :    


**- PC client client1 :**     

Création du dossier à la racine du disque dur du PC client1 :    

Aller sur le disque dur du PC sur le lecteur c et creer un dossier qu'on nommera "karimshare"

     
![GIF1_PSsharedir](https://github.com/user-attachments/assets/9194874c-38f1-40bf-8fda-1f94ccf1778a)    


Maintenant que le dossier est crée, il faut aller dans propriétés en faisant un clic droit sur le dossier puis en choisissant propriétés.    

Puis dans la fenêtre propriétés qui s'affiche aller dans l'onglet partage puis cliquer sur le bouton Partage avancé.      

![GIF2_paradvance](https://github.com/user-attachments/assets/5e0f119c-a007-4f77-9b80-5f51f9699407)     
   

Dans la fenêtre de partage avancé, cocher la case partager ce dossier.    
Puis cliquer sur le boutons autorisations.   
On constate une fenêtre "Nom de groupes ou d'utilisateurs".       
Dans cette fenêtre il y a une ligne "Tout le monde".   
On peut ajouter si on veut certains utilisateurs et leur assigner des droits différents sur le dossier.    
Mais dans notre cas on va rester sur tous les utilisateurs et leur assigner le droit "Modifier" et "Lecture" en cochant les cases portant le même nom dans la colonne Autoriser.      
Il est préférable de ne pas cocher "Contrôle Total" dans autorisations. Une bonne habitude de sécurité à garder.    

![GIF3_paradvance](https://github.com/user-attachments/assets/2383e11c-b3bf-4083-b5f6-0a4c904e9882)     


Ayant un soucis avec la VM serveur qui s'éteint régulièrement, j'ai effectué cette opération sur le PC client1.    
Je voulais le faire sur le PC winserv mais il s'est éteint entretemps. Ca ne change rien à cette configuration.   
Je vais maintenant allumer le PC winserv sur lequel les fichiers du script de l'exercice sont présents pour pouvoir les copier dans le dossier partagé "karimshare".   


**- PC serveur winserv :**     


- Vérifier que le dossier karimshare est accessible sur cette VM :      

Ouvrir l'explorateur de fichier, puis aller cliquer la flèche à gauche de network.     

![pcs_karshare](https://github.com/user-attachments/assets/d307b21e-a758-4917-ac43-4c7cc8cc1628)      

 

Le dossier karimshare est accessible depuis le pc winser.   

- Copie des fichiers dans le dossier de partage :      

Aller dans le dossier "scripts" à la racine du disque dur  c:\.    
Selectionner tous les fichiers puis à l'aide d'un clique droit sur ce dossier, choisir copier.    
Aller dans le dossier karimshare puis faire un clique droit et chosir coller.   


![GIF1_copyfiles](https://github.com/user-attachments/assets/f9320a43-aba4-423b-9679-081d82c94348)     
   


Maintenant direction le PC client1 pour récupérer les fichiers.     

 
## **Q.2.2**   
 
## **Script principal**   


**- PC client client1 :**      

- Recupération des fichiers de script :    

Création d'un dossier scripts à la racine puis copie des fichiers depuis le dossier karimshare.
Coller fichiers script dans le repertoire script de la racine du pc client1 pour pouvoir les tester.


![GIF4_recupscripts](https://github.com/user-attachments/assets/d849264c-6070-4162-929c-f5de796ec3d4)



- Ouverture PowerShell ISE :
Taper PowerShell ISE pui éxécuter en tant qu'administrateur.   

![GIF5_lancepwsise](https://github.com/user-attachments/assets/a1f2ed76-9ef6-40ee-ad2d-e1059cd90e30)     


- Ouverture et éxécution du script "Main.ps1"

Dans PowerShell ISE, faire ouvrir puis choisir Main.ps1 dans son dossier scripts.   
Cliquer sur le bouton lecture vert pour éxécuter le script ouvert.     

- Résultat :

![GIF6_runscript](https://github.com/user-attachments/assets/74abfde8-0db7-4a97-b7af-27ea256e9f5e)    
   

On constate qu'une fenêtre PowerShell s'ouvre furtivement avec du rouge qui s'inscrit dans la fenêtre ce qui indique une erreur.   
La fenêtre se ferme et le script s'arrête.   

Je reconnais en lisant la seule ligne du script une première erreur.

**Erreur 1 :**

Cette ligne de commande est utilisée pour **démarrer PowerShell en tant qu'administrateur** et pour exécuter le script **"AddLocalUsers.ps1"** situé dans **"C:\Temp"**.   


Ayant copié moi même les fichiers scripts dans le dossier scripts de la racine disque dur du PC client1, je sais que le deuxième script **"AddLocalUsers.ps1"** s'y trouve.   

Il faut donc juste remplacer l'emplacement "c:\Temp" par "c:\scripts".

ce qui donne la ligne de commande :  

`Start-Process -FilePath "powershell.exe" -ArgumentList "C:\scripts\AddLocalUsers.ps1" -Verb RunAs -WindowStyle Maximized`   

**- Résultat après modification :  **    

gif7runmodif   

les erreures au deuxième lancement :

pcc1 runscript   

**Erreur 2 :**  **Désolé d'avoir répondu trop tôt à la question 2.11, je croyais que le deuxième script devait fonctionner aussi dans la question**

Le premier script "Main.ps1" lance dorénavant le script "AddLocalUsers.ps1".      
Le script semble créer plusieurs utilisateurs locaux, mais il échoue lors de l'ajout de ces utilisateurs au groupe "Utilisateur".
Le message "Le groupe Utilisateur n’a pas été trouvé" indique que le script essaie d'ajouter les utilisateurs à un groupe qui n'existe pas ou dont le nom est différent.

Pour résoudre ce problème, il faut sûrement vérifier le nom du groupe auquel le script essaie d'ajouter des utilisateurs.    
Dans Windows, le groupe par défaut pour les utilisateurs est souvent appelé "Utilisateurs" au lieu de "Utilisateur".    
L'erreur est gérée par le script lui-même et il demande l'interaction de l'utilisateur avant de continuer.  
Effectivement, il demande à l'utilisateur de presser la touche "Entrée" pour continuer après l'affichage des messages d'erreur.   

Je vais maintenant ouvrir le script "AddLocalUsers.ps1" pour en vérifier le contenu.   
J'y retrouve bien la ligne de commande suivante :    

`Add-LocalGroupMember -Group "Utilisateur" -Member "$Prenom.$Nom"`   

La ligne de commande attribue un nouvel utilisateur au groupe "Utilisateur".
En voulant ouvrir le répertoire correspondant au groupe portant le même nom, on constate que "Utilisateurs" comprend bien un s à la fin .    

![pcc2_verifrepusers](https://github.com/user-attachments/assets/b858412b-8897-4e46-87b2-5e712310cb32)     
   

Je vais donc modifier la ligne de commande  en ajoutant un s à "Utilisateur".   
Ce qui donne :

`Add-LocalGroupMember -Group "Utilisateurs" -Member "$Prenom.$Nom"`  

**Relancement du premier script après modification du deuxième script :**    

Je relance le premier script pour voir si tout fonctionne :   

 ![GIF8_runscrprincmod](https://github.com/user-attachments/assets/e123b5b6-010c-4ce9-8606-cb6c1501cb55)    

 ![GIF9_2runscrprincmod](https://github.com/user-attachments/assets/b84f1c00-3770-4a91-84e6-82ace9e1d09f)     
 
 Pas de signalement d'erreur.     


---------------------------------------------------
 
 
## **Script secondaire**   


## **Q.2.3**   


L'option -Verb RunAs permet d'exécuter le script avec des privilèges élevés (administrateur).


## **Q.2.4**   

L'option -WindowStyle Maximized permet de maximiser la fenêtre de PowerShell pour une meilleure visibilité.    


## **Q.2.5**  

L'importation des utilisateurs saute les deux premières lignes du fichier CSV à cause de -Skip 2 dans la dernière commande `Select-Object` de la ligne.   

Voici la correction :    

`$Users = Import-Csv -Path $CsvFile -Delimiter ";" -Header "prenom","nom","societe","fonction","service","description","mail","mobile","scriptPath","telephoneNumber" -Encoding UTF8 | Select-Object -Skip 1`    

Changez -Skip 2 en -Skip 1 permet de ne sauter que la première ligne du CSV qui correspondrait dans un tableau au nom de chaque colonne d'information.

Effectivement lors de l'éxécution du script, en comparant le contenu du fichier csv aux nouveaux utilisateurs on remarque l'abscence de  Anna Dumas qui est l'utilisatrice indiquée dans la deuxième ligne du fichier csv.   

Contenu Fichier csv :    

prenom;nom;societe;fonction;service;description;mail;mobile;scriptPath;telephoneNumber
Anna;Dumas;sweetcakes;Directeur;Communication;Utilisateur du service Communication;Anna.Dumas@sweetcakes.net;06.28.37.25.55;logonscript.bat;01.59.82.30.21
Styrbjörn;Colin;sweetcakes;Assistant;Communication;Utilisateur du service Communication;Quentin.Colin@sweetcakes.net;06.52.65.51.47;logonscript.bat;01.51.91.31.24
Matheo;Aubert;sweetcakes;Assistant;Communication;Utilisateur du service Communication;Matheo.Aubert@sweetcakes.net;06.66.82.20.34;logonscript.bat;01.94.44.57.17
Anaïs;Bourgeois;sweetcakes;Directeur;Comptabilite;Utilisateur du service Comptabilite;Rose.Bourgeois@sweetcakes.net;06.17.31.57.26;logonscript.bat;01.31.25.95.11    

Utilisateurs crées après lancement du script et avant modification :
  
![pcc4_repuseravtmod](https://github.com/user-attachments/assets/cb6608fc-ddc4-4b52-981e-222d4b70abc4)

   
 
Utilisateurs crées après lancement du script et après modification :

![pcc6_annaestla](https://github.com/user-attachments/assets/6f6dfe51-6363-4155-a247-b0823a3c2982)


Il y a de l'amélioration Anna a été crée.   


## **Q.2.6**  

Utilisation du Champ Description :   

Il faut rajouter `$Description` dans la déclaration de variables à utiliser pour créer le nouvel utilisateur.   
ligne à ajouter :

`Description          = $Description`
   
Ce qui donne :     

```   
$Description = "$($User.description) - $($User.fonction)"
$UserInfo = @{
    Name                 = "$Prenom.$Nom"
    FullName             = "$Prenom.$Nom"
    Password             = $Password
    Description          = $Description
    AccountNeverExpires  = $true
    PasswordNeverExpires = $true
}
```    

Vérification en relançant le script après avoir supprimé les utilisateurs du script pour qu'ils soient recrées.   

 

![pcc8_adddescript](https://github.com/user-attachments/assets/06cf4d00-3ead-4c07-a422-87a994c0a387)
  


## **Q.2.7**      

Les champs nécéssaires sont le nom, prénom, la description et la fonction, il faut enlever pour cela les éléments mail, mobile et telephoneNumber.    
  

La ligne de commande permettant d'importer les éléments du fichier csv est :   

`$Users = Import-Csv -Path $CsvFile -Delimiter ";" -Header "prenom","nom","societe","fonction","service","description","mail","mobile","scriptPath","telephoneNumber" -Encoding UTF8  | Select-Object -Skip 1`   

La ligne modifiée devient :    

**`$Users = Import-Csv -Path $CsvFile -Delimiter ";" -Header "prenom","nom","description","fonction" -Encoding UTF8 | Select-Object -Skip 1`**     




## **Q.2.8**     


Ajouter la ligne de commande suivante au script pour afficher le mot de passe en vert :     

`Write-Host "Le compte $Name a été créé avec le mot de passe $Pass" -ForegroundColor Green`    

J'ai ajouté cette ligne de commande juste après celle-ci :      

`Write-Host "L'utilisateur $Prenom.$Nom a été crée"`    

Vérification en relançant le script après avoir supprimé les utilisateurs du script pour qu'ils soient recrées.     

Résultat :     

![pcc9_addpassgreen](https://github.com/user-attachments/assets/6cd44598-4421-48f8-a042-da4c9a18409b)    
    

## **Q.2.9**     


Pour la Journalisation des Actions à partir de la fonction du script Functions.psm1   
Ce module est utile pour suivre les événements ou les messages dans un script.   
Il inclue des informations sur la date, l’heure et l’utilisateur crée.    

**Méthode 1 : Appel Direct**

Ajouter un appel direct à la fonction Log :   

```
. C:\Scripts\Functions.psm1
Log -FilePath $LogFile -Content "Création de l'utilisateur $Name"   
```   

**Méthode 2 : Utilisation d'un Module**    


Importez le module puis utilisez la fonction :   

```
Import-Module C:\Scripts\Functions.psm1    
Log -FilePath $LogFile -Content "Création de l'utilisateur $Name"     
```   

J'utilise la méthode 2 pour ajouter la journalisation de l'activité.    
Implémentation au début du script :
   

![pcc10_addpassgreen](https://github.com/user-attachments/assets/31300a87-cc95-4270-80a8-09b3c9b3e453)    




Lancement du script puis ouverture du fichier log pour vérifier la journalisation effectuée :    

![pcc11_addlog](https://github.com/user-attachments/assets/20b202f5-d499-43d4-9cb4-a04763ef5a95)     


## **Q.2.10**     


Affichage si l'Utilisateur Existe Déjà.   

Pour ajouter une ligne afin d'afficher un message en rouge si l'utilisateur existe déjà :
Ajouter a la condition if dans la boucle foreach la condition else.

```   
else
{
    Write-Host "Le compte $Name existe déjà" -ForegroundColor Red
}
```   

![pcc12_addredline](https://github.com/user-attachments/assets/0daaaf1e-96af-436e-8af5-7eb48dc8e15d)    
 

le résultat donne :

![pcc13_resredlin](https://github.com/user-attachments/assets/185ea6de-1869-45d0-8174-d82282c734d3)    
    

## **Q.2.11**    

Réponse de la question 2.2
Dans Windows, le groupe par défaut pour les utilisateurs est souvent appelé "Utilisateurs" au lieu de "Utilisateur".    
L'erreur est gérée par le script lui-même et il demande l'interaction de l'utilisateur avant de continuer.  
Effectivement, il demande à l'utilisateur de presser la touche "Entrée" pour continuer après l'affichage des messages d'erreur.   

Je vais maintenant ouvrir le script "AddLocalUsers.ps1" pour en vérifier le contenu.   
J'y retrouve bien la ligne de commande suivante :    

`Add-LocalGroupMember -Group "Utilisateur" -Member "$Prenom.$Nom"`   

La ligne de commande attribue un nouvel utilisateur au groupe "Utilisateur".
En voulant ouvrir le répertoire correspondant au groupe portant le même nom, on constate que "Utilisateurs" comprend bien un s à la fin .    

pcc2_repuser   

Je vais donc modifier la ligne de commande  en ajoutant un s à "Utilisateur".   
Ce qui donne :

`Add-LocalGroupMember -Group "Utilisateurs" -Member "$Prenom.$Nom"`  


## **Q.2.12**

Remplace la chaîne "$Prenom.$Nom" par une variable $Name.
La variable $Name est déjà utilisée dans le script. 
Donc il suffit de l'utiliser partout où $Prenom.$Nom était utilisé. 
Tout a été remplacé sauf la déclaration de variable en début de boucle foreach:       

`$Name = "$Prenom.$Nom"`    

## **Q.2.13**    

Voici la partie de code où se trouve 
```
$UserInfo = @{
    Name                 = "$Name"
    FullName             = "$Name"
    Password             = $Password
    Description          = $Description
    AccountNeverExpires  = $true
    PasswordNeverExpires = $false
}
```

On peut constater que PasswordNeverExpires est défini comme false.  

Il faut s'assurer que PasswordNeverExpires est défini comme true.

$false est remplacé par $true.   

ce qui donne :  
  
```
$UserInfo = @{
    Name                 = "$Name"
    FullName             = "$Name"
    Password             = $Password
    Description          = $Description
    AccountNeverExpires  = $true
    PasswordNeverExpires = $true
}
```


Modifier le code pour que le mot de passe soit constitué de 12 caractères au lieu de 6.
Changer la longueur par défaut de la fonction Random-Password.


## **Q.2.14**   
  
Correction du script AddLocalUsers.ps1

```
Function Random-Password ($length = 12)
{
    ♀# Code de la fonction
}
```

La modification est juste le remplacement du 6 par un 12.   

## **Q.2.15**   


Pour remplacer le temps d'attente de 10 secondes par une pause gérable par un appui sur la touche Entrée du clavier.   
Utiliser la commande Read-Host pour attendre l'appui sur la touche Entrée.    


Correction du script AddLocalUsers.ps1

Remplacer :
```
Write-Host "--- Fin du script ---"
Start-Sleep -Seconds 10
```
par   

```
Write-Host "--- Fin du script ---"
Read-Host -Prompt "Appuyez sur Entrée pour terminer"
```

## **Q.2.16**   


La fonction ManageAccentsAndCapitalLetters sert à supprimer les accents.   
Elle sert aussi à convertir les lettres en minuscules pour uniformiser les noms d'utilisateur.   
Par exemple, "Anaïs Bourgeois" devient "anais.bourgeois".   

Exemple avec la liste des utilisateurs :    

Anna;Dumas -> anna.dumas
Styrbjörn;Colin -> styrbjorn.colin
Matheo;Aubert -> matheo.aubert
Anaïs;Bourgeois -> anais.bourgeois    

