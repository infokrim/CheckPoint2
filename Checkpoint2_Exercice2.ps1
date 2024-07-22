Write-Host "--- D�but du script ---"
#Modification de la longueur du mot de passe qui passe de 6 caract�res � 12Function Random-Password ($length = 12){    $punc = 46..46
    $digits = 48..57
    $letters = 65..90 + 97..122
    $password = get-random -count $length -input ($punc + $digits + $letters) |`
        ForEach -begin { $aa = $null } -process {$aa += [char]$_} -end {$aa}
    Return $password.ToString()
}

Function ManageAccentsAndCapitalLetters{    param ([String]$String)    
    $StringWithoutAccent = $String -replace '[����]', 'e' -replace '[���]', 'a' -replace '[��]', 'i' -replace '[��]', 'o' -replace '[���]', 'u'    $StringWithoutAccentAndCapitalLetters = $StringWithoutAccent.ToLower()    $StringWithoutAccentAndCapitalLetters
}

$Path = "C:\Scripts"$CsvFile = "$Path\Users.csv"$LogFile = "$Path\Log.log"
#J'ai remplac� -skip 2 par skip 1 dans la ligne sivante pour que les utilisateurs soient pris en compte d�s la deuxi�me ligne (la premi�re ligne correspond aux noms dess diff�rentes informations) 
$Users = Import-Csv -Path $CsvFile -Delimiter ";" -Header "prenom","nom","description","fonction" -Encoding UTF8 | Select-Object -Skip 1

foreach ($User in $Users)
{
    $Prenom = ManageAccentsAndCapitalLetters -String $User.prenom    $Nom = ManageAccentsAndCapitalLetters -String $User.Nom
    $Name = "$Prenom.$Nom"
    If (-not(Get-LocalUser -Name "$Name" -ErrorAction SilentlyContinue))    {        $Pass = Random-Password        $Password = (ConvertTo-secureString $Pass -AsPlainText -Force)
        $Description = "$($user.description) - $($User.fonction)"
        $UserInfo = @{
            Name                 = "$Name"
            FullName             = "$Name"
            Password             = $Password
            #Ajout de la ligne en dessous pour que la description soit prise en compte
            Description          = $Description
            AccountNeverExpires  = $true
            PasswordNeverExpires = $true
        }

        New-LocalUser @UserInfo
        Add-LocalGroupMember -Group "Utilisateurs" -Member "$Name"
        Write-Host "L'utilisateur $Name a �t� cr�e"
        Write-Host "Le compte $Name a �t� cr�� avec le mot de passe $Pass" -ForegroundColor Green
        Import-Module C:\Scripts\Functions.psm1
        Log -FilePath $LogFile -Content "Cr�ation de l'utilisateur $Name"
        
    }
    else
    {
        Write-Host "Le compte $Name existe d�j�" -ForegroundColor Red
    }
}


pause
Write-Host "--- Fin du script ---"
Read-Host -Prompt "Appuyez sur Entr�e pour terminer"
