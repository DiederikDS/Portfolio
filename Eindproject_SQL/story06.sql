-- Als vegetarische passieve gebruiker zoek ik alle recepten die vegetarisch zijn zodat ik 1 hiervan kan volgen.

BEGIN TRANSACTION

SELECT Rec.ReceptNaam
FROM Recepten AS Rec
	FULL OUTER JOIN ReceptLabel AS ReLa ON Rec.ReceptId = ReLa.ReceptId
	FULL OUTER JOIN Labels AS La ON ReLa.LabelId = La.LabelId
WHERE Label = 'Vegetarisch'

COMMIT