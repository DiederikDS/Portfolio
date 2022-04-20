--  Als beheerder wil ik een gebruiker verwijderen die al een lange tijd inactief is (27: Maxim Visser), zodat dit geen onnodige plaats opneemt in de database.

BEGIN TRANSACTION

DELETE FROM ReceptIngrediënt
WHERE ReceptId = 3

DELETE FROM ReceptLabel
WHERE ReceptId = 3

DELETE FROM ReceptMaaltijd
WHERE ReceptId = 3

DELETE FROM Reviews
WHERE ReceptId = 3

DELETE FROM Recepten
WHERE GebruikersId = 27

DELETE FROM Gebruikers
WHERE GebruikersId = 27

COMMIT