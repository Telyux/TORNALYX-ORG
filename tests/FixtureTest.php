<?php
declare(strict_types=1);
use PHPUnit\Framework\TestCase;
require_once __DIR__ . '/../SGDM/backend/shared/Fixture.php';

final class FixtureTest extends TestCase
{
    public function testRoundRobinSchedulesEveryPairExactlyOnceForEvenField(): void
    {
        $rounds = Fixture::roundRobin([1,2,3,4]);
        self::assertCount(3, $rounds);
        $pairs = [];
        foreach ($rounds as $round) {
            self::assertCount(2, $round);
            foreach ($round as [$a,$b]) { self::assertNotSame($a,$b); $pair=[$a,$b]; sort($pair); $pairs[]=implode('-', $pair); }
        }
        self::assertCount(6, array_unique($pairs));
    }
    public function testRoundRobinSupportsOddNumberOfContenders(): void
    {
        $rounds=Fixture::roundRobin([10,20,30,40,50]); self::assertCount(5,$rounds); $pairs=[];
        foreach($rounds as $round) { self::assertCount(2,$round); foreach($round as $pair){sort($pair);$pairs[]=implode('-',$pair);} }
        self::assertCount(10,array_unique($pairs));
    }
    public function testEliminationPairsContendersAndLeavesOddOneOut(): void
    { self::assertSame([[1,2],[3,4]],Fixture::eliminacion([1,2,3,4,5])); }
    public function testSwissAvoidsPreviouslyPlayedOpponentsWhenPossible(): void
    {
        $played=[1=>[2=>true],3=>[4=>true]];
        $pairs=Fixture::suizo([1,2,3,4],$played); self::assertCount(2,$pairs);
        foreach($pairs as [$a,$b]) { self::assertFalse(!empty($played[$a][$b])); }
    }
    public function testRoundNameDependsOnFormatAndFieldSize(): void
    {
        self::assertSame('Final',Fixture::nombreRonda('eliminacion_directa',3,2));
        self::assertSame('Semifinal',Fixture::nombreRonda('eliminacion_directa',2,4));
        self::assertSame('Ronda 2',Fixture::nombreRonda('suizo',2,8));
    }
}
