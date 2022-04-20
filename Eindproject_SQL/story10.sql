-- Als beheerder wil ik een recept 5 'Tomatensoep' verwijderen, want deze heeft enkel slechte reviews.

BEGIN TRANSACTION

DELETE FROM ReceptIngrediënt
WHERE ReceptId = 5

DELETE FROM ReceptLabel
WHERE ReceptId = 5

DELETE FROM ReceptMaaltijd
WHERE ReceptId = 5

DELETE FROM Reviews
WHERE ReceptId = 5

DELETE FROM Recepten
WHERE ReceptId = 5

COMMIT