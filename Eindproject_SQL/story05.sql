-- Als passieve gebruiker ben ik opzoek naar een recept die tortellini bevat, want ik heb veel van dat ingrediënt in huis.

BEGIN TRANSACTION

SELECT Rec.ReceptNaam
FROM Recepten AS Rec
	FULL OUTER JOIN ReceptIngrediënt AS RecIn ON Rec.ReceptId = RecIn.ReceptId
	FULL OUTER JOIN Ingrediënten AS Ing ON RecIn.IngrediëntId = Ing.IngrediëntId
WHERE Ing.Ingrediënt = 'Tortellini' 

COMMIT