<?php
declare(strict_types=1);
require_once __DIR__ . '/../SGDM/backend/shared/FirmaDigital.php';
function uso(): never {
    fwrite(STDERR, "Uso:\n  php scripts/firma-documento.php firmar archivo [archivo.firma]\n  php scripts/firma-documento.php verificar archivo archivo.firma\nVariables: TORNALYX_SIGNING_PRIVATE_KEY (ruta PEM), TORNALYX_SIGNING_PUBLIC_KEY (ruta PEM).\n");
    exit(2);
}
$accion=$argv[1] ?? ''; $archivo=$argv[2] ?? '';
if(!in_array($accion,['firmar','verificar'],true) || $archivo==='' || !is_file($archivo) || !is_readable($archivo)) uso();
$contenido=file_get_contents($archivo);
if($contenido===false){fwrite(STDERR,"No se pudo leer el archivo.\n");exit(1);}
if($accion==='firmar'){
    $keyPath=getenv('TORNALYX_SIGNING_PRIVATE_KEY') ?: '';
    if($keyPath==='' || !is_file($keyPath) || !is_readable($keyPath)){fwrite(STDERR,"Definí TORNALYX_SIGNING_PRIVATE_KEY con la ruta a la clave privada PEM.\n");exit(2);}
    $pem=file_get_contents($keyPath);
    if($pem===false){fwrite(STDERR,"No se pudo leer la clave privada.\n");exit(1);}
    $signature=FirmaDigital::firmar($contenido,$pem,getenv('TORNALYX_SIGNING_KEY_PASSPHRASE') ?: null);
    $out=$argv[3] ?? ($archivo.'.firma');
    if(file_put_contents($out,$signature.PHP_EOL,LOCK_EX)===false){fwrite(STDERR,"No se pudo escribir la firma.\n");exit(1);}
    chmod($out,0600); echo "Firma SHA-256 creada: {$out}\n"; exit(0);
}
$firmaPath=$argv[3] ?? '';
if($firmaPath==='' || !is_file($firmaPath)){fwrite(STDERR,"Indicá el archivo de firma existente como tercer argumento.\n");exit(2);}
$keyPath=getenv('TORNALYX_SIGNING_PUBLIC_KEY') ?: '';
if($keyPath==='' || !is_file($keyPath)){fwrite(STDERR,"Definí TORNALYX_SIGNING_PUBLIC_KEY con la ruta a la clave pública PEM.\n");exit(2);}
$firma=file_get_contents($firmaPath); $pem=file_get_contents($keyPath);
if($firma===false || $pem===false){fwrite(STDERR,"No se pudo leer firma o clave pública.\n");exit(1);}
if(!FirmaDigital::verificar($contenido,trim($firma),$pem)){fwrite(STDERR,"FIRMA INVÁLIDA: contenido modificado o clave incorrecta.\n");exit(1);}
echo "Firma válida: el contenido coincide con la clave pública.\n";
