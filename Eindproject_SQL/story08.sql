-- Als beheerder wil ik een review verwijderen met taalgebruik die niet voldoet aan onze gebruikersovereenkomst, zodat de app gebruiksvriendelijk blijft.

BEGIN TRANSACTION

DELETE FROM Reviews
WHERE Review LIKE '%Potvolkoffie%'

COMMIT