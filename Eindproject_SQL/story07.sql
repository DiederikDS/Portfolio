-- Als passieve gebruiker zoek ik alle recepten van gebruiker: Sarah Peeters, want ik probeerde reeds eerder een gerecht van haar.

BEGIN TRANSACTION

SELECT Rec.ReceptNaam
FROM Recepten AS Rec
	FULL OUTER JOIN Gebruikers AS Geb ON Rec.GebruikersId = Geb.GebruikersId
WHERE VoorNaam = 'Sarah' AND AchterNaam = 'Peeters'

COMMIT