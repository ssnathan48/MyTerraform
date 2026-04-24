#root certificate generation
$cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature `
-Subject "CN=SwamiRootCert" -KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 2048 `
-CertStoreLocation "Cert:\CurrentUser\My" -KeyUsageProperty Sign `
-KeyUsage CertSign

#export certificate generation
Export-Certificate -Cert $cert -FilePath "C:\development\MySamples\TerraformCode\certs\SwamiRootCert.cer"

[System.Convert]::ToBase64String(
    [System.IO.File]::ReadAllBytes("C:\development\MySamples\TerraformCode\certs\SwamiRootCert.cer")
) | Out-File "C:\development\MySamples\TerraformCode\certs\SwamiRootCert_Base64.txt"

#client certificate generation
New-SelfSignedCertificate -Type Custom -DnsName "SwamiClientCert" `
-Subject "CN=SwamiClientCert" -KeySpec Signature `
-KeyExportPolicy Exportable -HashAlgorithm sha256 `
-KeyLength 2048 -CertStoreLocation "Cert:\CurrentUser\My" `
-Signer $cert
