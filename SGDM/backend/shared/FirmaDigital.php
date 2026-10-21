<?php
declare(strict_types=1);

/** Firma y verifica contenido con RSA + SHA-256. La clave privada nunca va en Git ni en el DocumentRoot. */
final class FirmaDigital
{
    public static function firmar(string $contenido, string $clavePrivadaPem, ?string $passphrase = null): string
    {
        $key=openssl_pkey_get_private($clavePrivadaPem,$passphrase ?? '');
        if($key===false) throw new RuntimeException('No se pudo cargar la clave privada de firma.');
        $signature=''; $ok=openssl_sign($contenido,$signature,$key,OPENSSL_ALGO_SHA256); 
        if(!$ok) throw new RuntimeException('OpenSSL no pudo generar la firma digital.');
        return base64_encode($signature);
    }
    public static function verificar(string $contenido, string $firmaBase64, string $clavePublicaPem): bool
    {
        $key=openssl_pkey_get_public($clavePublicaPem);
        if($key===false) throw new RuntimeException('No se pudo cargar la clave pública de verificación.');
        $signature=base64_decode($firmaBase64,true);
        if($signature===false){return false;}
        $result=openssl_verify($contenido,$signature,$key,OPENSSL_ALGO_SHA256); openssl_free_key($key);
        if($result===-1) throw new RuntimeException('OpenSSL no pudo verificar la firma.');
        return $result===1;
    }
}
