<?php
declare(strict_types=1);
use PHPUnit\Framework\TestCase;
require_once __DIR__ . '/../SGDM/backend/shared/FirmaDigital.php';

final class FirmaDigitalTest extends TestCase
{
    public function testSignatureVerifiesAndTamperedContentFails(): void
    {
        $private=openssl_pkey_new(['private_key_type'=>OPENSSL_KEYTYPE_RSA,'private_key_bits'=>2048]);
        self::assertNotFalse($private);
        $details=openssl_pkey_get_details($private); self::assertIsArray($details);
        $privatePem=''; openssl_pkey_export($private,$privatePem); $publicPem=$details['key'];
        $content="Acta de prueba Tornalyx\nFecha: 2026-10-21\n";
        $signature=FirmaDigital::firmar($content,$privatePem);
        self::assertTrue(FirmaDigital::verificar($content,$signature,$publicPem));
        self::assertFalse(FirmaDigital::verificar($content.'modificado',$signature,$publicPem));
    }
}
