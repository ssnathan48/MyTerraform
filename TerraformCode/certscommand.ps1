#root certificate generation
$cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature `
-Subject "CN=SwamiRootCert" -KeyExportPolicy Exportable `
-HashAlgorithm sha256 -KeyLength 2048 `
-CertStoreLocation "Cert:\CurrentUser\My" -KeyUsageProperty Sign `
-KeyUsage CertSign

#export certificate generation
Export-Certificate -Cert $cert -FilePath "C:\temp\SwamiRootCert.cer"

#client certificate generation
New-SelfSignedCertificate -Type Custom -DnsName "SwamiClientCert" `
-Subject "CN=SwamiClientCert" -KeySpec Signature `
-KeyExportPolicy Exportable -HashAlgorithm sha256 `
-KeyLength 2048 -CertStoreLocation "Cert:\CurrentUser\My" `
-Signer $cert
