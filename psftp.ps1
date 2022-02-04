Write-Output "Connect your ftp";
Write-Output "";
Write-Output "[1] - Connect new profil";
Write-Output "[2] - Connect a profil";
Write-Output "[3] - Exit";
Write-Output "";
$choice = Read-Host ;

Clear-Host

switch ($choice) {
    1 {
        $hostname = Read-Host -Prompt 'Host';
        $username = Read-Host -Prompt 'User';
        $password = Read-host 'Password' -AsSecureString;

        $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
        $unpassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

        $output = "$hostname`n$username`n$unpassword"

        if (Test-Path -Path ".\FTP") {
        } else {
            New-Item -Path "." -Name "FTP" -ItemType "directory" -Force 
        }

        New-Item -Path ".\FTP\connect.sav" -Value $output -ItemType File -Force
        Clear-Host

        Write-Output 'Do you want do save the profil? [y/n]';
        Write-Output "";
        $save = Read-Host;

        $stringkey = '';
        $key = @();
        for (($i = 0); $i -lt 24; $i++) {
            $key = $key + (Get-Random -Minimum 1 -Maximum 150);
            if ($i -eq 0) {
                $stringkey = $stringkey + $key[$i];
            }
            else {
                $stringkey = $stringkey + ',' + $key[$i];
            }
        }
        
        if ($save -eq "y") {
            Clear-Host
            $profilname = Read-Host -Prompt 'Profil name';
            $savepath = ".\FTP\Profil\$profilname"

            $securehostname = $hostname | ConvertTo-SecureString -AsPlainText -Force
            $encryptedhostname = ConvertFrom-SecureString -SecureString $securehostname -Key $key

            $secureusername = $username | ConvertTo-SecureString -AsPlainText -Force
            $encryptedusername = ConvertFrom-SecureString -SecureString $secureusername -Key $key

            $secureunpassword = $unpassword | ConvertTo-SecureString -AsPlainText -Force
            $encryptedunpassword = ConvertFrom-SecureString -SecureString $secureunpassword -Key $key

            $saveoutput = "$encryptedhostname,$encryptedusername,$encryptedunpassword"

            New-Item -Path $savepath -Value $saveoutput -ItemType File -Force | Out-Null

            Write-Output ''
            Write-Output "Your key: $stringkey" 
            pause
        }
        else {
            if ($save -eq "Y") {
                Clear-Host
                $profilname = Read-Host -Prompt 'Profil name';
                $savepath = ".\FTP\Profil\$profilname"

                $securehostname = $hostname | ConvertTo-SecureString -AsPlainText -Force
                $encryptedhostname = ConvertFrom-SecureString -SecureString $securehostname -Key $key

                $secureusername = $username | ConvertTo-SecureString -AsPlainText -Force
                $encryptedusername = ConvertFrom-SecureString -SecureString $secureusername -Key $key

                $secureunpassword = $unpassword | ConvertTo-SecureString -AsPlainText -Force
                $encryptedunpassword = ConvertFrom-SecureString -SecureString $secureunpassword -Key $key

                $saveoutput = "$encryptedhostname,$encryptedusername,$encryptedunpassword"

                New-Item -Path $savepath -Value $saveoutput -ItemType File -Force | Out-Null

                Write-Output ''
                Write-Output "Your key: $stringkey" 
                pause
            }
        }

        Clear-Host
    }
    2 {
        $profilname = Read-Host -Prompt 'Profil name';
        $profilpassword = Read-host 'Key';

        $profilpath = ".\FTP\Profil\$profilname";

        $line = [System.IO.File]::ReadLines($profilpath);
        $args = $line.Split(',');

        $strkey = $profilpassword.Split(",") 
        $key = @()

        if ($strkey.Length -eq 24) {
            for (($i = 0); $i -lt $strkey.Length; $i++) {
                $key = $key + [int]$strkey[$i]
            }
            try {
                $secureht = ConvertTo-SecureString -String $args[0] -Key $key -ErrorAction Stop
                $decryptedht = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureht)
                $decryptedht = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($decryptedht)

                $secureusr = ConvertTo-SecureString -String $args[1] -Key $key
                $decryptedusr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureusr)
                $decryptedusr = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($decryptedusr)

                $secureps = ConvertTo-SecureString -String $args[2] -Key $key
                $decryptedps = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureps)
                $decryptedps = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($decryptedps)

                $decryptedht
                $decryptedusr
                $decryptedps
            }
            catch {
                Write-Warning -Message "Wrong key"
            }
                 
        }
        else {
            Write-Warning -Message "Wrong key"
        }          
       
        pause
        Clear-Host
    }
    default {
        Clear-Host;
    }
}
