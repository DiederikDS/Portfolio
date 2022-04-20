-- Als actieve gebruiker wil ik graag mijn nieuw recept toevoegen aan de database van de applicatie zodat andere gebruikers deze kunnen vinden en gebruiken.

BEGIN TRANSACTION

INSERT INTO Recepten (ReceptNaam, GebruikersId, Beschrijving, Tijd, AantalPersonen)
VALUES ('Wortel pannekoeken', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 30, 2)

INSERT INTO Ingrediënten (Ingrediënt)
VALUES ('Walnoot')

INSERT INTO ReceptMaaltijd (ReceptId, MaaltijdId)
VALUES (23, 1)
	, (23, 4)

INSERT INTO ReceptLabel (ReceptId, LabelId)
VALUES (23, 7)

INSERT INTO ReceptIngrediënt (ReceptId, IngrediëntId)
VALUES (23, 1)
	, (23, 33)
	, (23, 68)
	, (23, 11)
	, (23, 52)
	, (23, 14)
	, (23, 8)
	, (23, 19)
	, (23, 74)

COMMIT