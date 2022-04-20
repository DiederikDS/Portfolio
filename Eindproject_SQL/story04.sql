-- Als passieve gebruiker zoek ik een leuk recept zodat ik een leuk gerecht kan maken op het paasontbijt.

BEGIN TRANSACTION

SELECT Rec.ReceptNaam
FROM Recepten AS Rec
	FULL OUTER JOIN ReceptLabel AS ReLa ON Rec.ReceptId = ReLa.ReceptId
	FULL OUTER JOIN Labels AS La ON ReLa.LabelId = La.LabelId
	FULL OUTER JOIN ReceptMaaltijd AS ReMa ON Rec.ReceptId = ReMa.ReceptId
	FULL OUTER JOIN Maaltijden AS Ma ON ReMa.MaaltijdId = Ma.MaaltijdId
WHERE Label = 'Pasen' AND Maaltijd = 'Ontbijt'

COMMIT