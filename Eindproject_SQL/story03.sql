-- Als actieve gebruiker wil ik graag de labels van mijn recept veranderen zodat deze beter representatief zijn voor het recept en in meer relevante zoek opdrachten gevonden kunnen worden.

UPDATE ReceptLabel
SET LabelId = 10
WHERE ReceptId = 10 AND LabelId = 12

UPDATE ReceptLabel
SET LabelId = 11
WHERE ReceptId = 10 AND LabelId = 14