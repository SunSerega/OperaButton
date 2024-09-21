try {
	
	
	
	$path = Resolve-Path .\native_host.json
	
	$json = Get-Content $path | ConvertFrom-Json
	$name = $json.name
	
	REG ADD "HKCU\Software\Google\Chrome\NativeMessagingHosts\$name" /ve /t REG_SZ /d $path /f
	
	
	
}
catch {
	Write-Host "An error occurred:"
	Write-Host $_
	pause
	exit 1
}
#pause