CREATE TABLE [dbo].[Gebruikers] (
    [GebruikersId]   INT            NOT NULL IDENTITY,
    [VoorNaam]       NVARCHAR (50)  NOT NULL,
    [AchterNaam]     NVARCHAR (50)  NOT NULL,
    [Email]          NVARCHAR (50)  NOT NULL,
    [Adres]          NVARCHAR (50)  NOT NULL,
    [ZipCode]        INT            NOT NULL,
    [Stad]           NVARCHAR (50)  NOT NULL
    CONSTRAINT [PK_Gebruikers] PRIMARY KEY CLUSTERED ([GebruikersId] ASC)
);

CREATE TABLE [dbo].[Recepten] (
    [ReceptId]       INT            NOT NULL IDENTITY,
    [ReceptNaam]     NVARCHAR (50)  NOT NULL,
    [GebruikersId]   INT            NOT NULL,
    [Beschrijving]   NVARCHAR (500) NOT NULL,
    [Tijd]           INT                NULL,
    [AantalPersonen] INT                NULL,
    CONSTRAINT [PK_Recepten] PRIMARY KEY CLUSTERED ([ReceptId] ASC),
    CONSTRAINT [FK_ReceptenGebruikersId] FOREIGN KEY ([GebruikersId]) REFERENCES [dbo].[Gebruikers] ([GebruikersId])
);

CREATE TABLE [dbo].[Reviews] (
    [ReviewId]     INT             NOT NULL IDENTITY,
    [Review]       NVARCHAR (200)  NOT NULL,
    [ReceptId]     INT             NOT NULL,
    [GebruikersId] INT             NOT NULL
    CONSTRAINT [PK_Reviews] PRIMARY KEY CLUSTERED ([ReviewId] ASC),
    CONSTRAINT [FK_ReviewsReceptId] FOREIGN KEY ([ReceptId]) REFERENCES [dbo].[Recepten] ([ReceptId]),
    CONSTRAINT [FK_ReviewsGebruikersId] FOREIGN KEY ([GebruikersId]) REFERENCES [dbo].[Gebruikers] ([GebruikersId])
);

CREATE TABLE [dbo].[Maaltijden] (
    [MaaltijdId]   INT            NOT NULL IDENTITY,
    [Maaltijd]     NVARCHAR (50)  NOT NULL,
    CONSTRAINT [PK_Maaltijden] PRIMARY KEY CLUSTERED ([MaaltijdId] ASC)
);

CREATE TABLE [dbo].[Labels] (
    [LabelId]   INT            NOT NULL IDENTITY,
    [Label]     NVARCHAR (50)  NOT NULL,
    CONSTRAINT [PK_Labels] PRIMARY KEY CLUSTERED ([LabelId] ASC)
);

CREATE TABLE [dbo].[Ingrediënten] (
    [IngrediëntId]   INT            NOT NULL IDENTITY,
    [Ingrediënt]     NVARCHAR (50)  NOT NULL,
    CONSTRAINT [PK_Ingrediënten] PRIMARY KEY CLUSTERED ([IngrediëntId] ASC)
);

CREATE TABLE [dbo].[ReceptMaaltijd] (
    [ReceptId]     INT            NOT NULL,
    [MaaltijdId]   INT            NOT NULL,
    CONSTRAINT [PK_ReceptMaaltijd] PRIMARY KEY NONCLUSTERED ([ReceptId] ASC, [MaaltijdId] ASC),
    CONSTRAINT [FK_ReceptMaaltijdReceptId] FOREIGN KEY ([ReceptId]) REFERENCES [dbo].[Recepten] ([ReceptId]),
    CONSTRAINT [FK_ReceptMaaltijdMaaltijdId] FOREIGN KEY ([MaaltijdId]) REFERENCES [dbo].[Maaltijden] ([MaaltijdId])
);

CREATE TABLE [dbo].[ReceptLabel] (
    [ReceptId]     INT            NOT NULL,
    [LabelId]      INT            NOT NULL,
    CONSTRAINT [PK_ReceptLabel] PRIMARY KEY NONCLUSTERED ([ReceptId] ASC, [LabelId] ASC),
    CONSTRAINT [FK_ReceptLabelReceptId] FOREIGN KEY ([ReceptId]) REFERENCES [dbo].[Recepten] ([ReceptId]),
    CONSTRAINT [FK_ReceptLabelLabelId] FOREIGN KEY ([LabelId]) REFERENCES [dbo].[Labels] ([LabelId])
);

CREATE TABLE [dbo].[ReceptIngrediënt] (
    [ReceptId]     INT            NOT NULL,
    [IngrediëntId] INT            NOT NULL,
    CONSTRAINT [PK_ReceptIngrediënt] PRIMARY KEY NONCLUSTERED ([ReceptId] ASC, [IngrediëntId] ASC),
    CONSTRAINT [FK_ReceptIngrediëntReceptId] FOREIGN KEY ([ReceptId]) REFERENCES [dbo].[Recepten] ([ReceptId]),
    CONSTRAINT [FK_ReceptIngrediëntIngrediëntId] FOREIGN KEY ([IngrediëntId]) REFERENCES [dbo].[Ingrediënten] ([IngrediëntId])
);

INSERT INTO Gebruikers (VoorNaam, AchterNaam, Email, Adres, ZipCode, Stad)
VALUES ('Diederik', 'De Soete', 'diederik.desoete@gmail.com', 'Parklaan 17', 9000, 'Gent')
	, ('Sarah', 'Peeters', 'sarah.Peeters@gmail.com', 'Hazenpad 4', 8210, 'Zedelgem')
	, ('Tom', 'Janssens', 'tom.janssens@gmail.com', 'Academiestraat 5', 2000, 'Antwerpen')
	, ('Pieter', 'Maes', 'pieter.maes@gmail.com', 'Augustijnenrei 34', 3000, 'Leuven')
	, ('Anton', 'Mertens', 'anton.mertens@hotmail.com', 'Bollaardstraat 29', 3118, 'Werchter')

INSERT INTO Recepten (ReceptNaam, GebruikersId, Beschrijving, Tijd, AantalPersonen)
VALUES ('Gevulde croissantjes met eiersalade', 5, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 20, 2)
	, ('Cupcakes', 4, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', NULL, 3)
	, ('Wraps met aardappel en bacon', 3, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 25, 2)
	, ('Tortellini ovenschotel met kip', 2, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 40, 3)
	, ('Tomatensoep', 1, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 30, NULL)

INSERT INTO Reviews (Review, ReceptId, GebruikersId)
VALUES ('Super lekker', 1, 5)
	, ('Krokant!', 3, 4)
	, ('Super lekker als dessert', 2, 3)
	, ('Simpel en gezond', 4, 1)
	, ('Niet lekker', 5, 2)

INSERT INTO Maaltijden (Maaltijd)
VALUES ('Ontbijt')
	, ('Aperitief')
	, ('Voorgerecht')
	, ('Lunch')
	, ('Dessert')
	, ('4-uurtje')
	, ('Dinner')

INSERT INTO Labels (Label)
VALUES ('Pasen')
	, ('Sinterklaas')
	, ('Halloween')
	, ('Vlees')
	, ('Kip')
	, ('Vis')
	, ('Pattiserie')
	, ('Soep')
	, ('Salade')
	, ('Alcohol')
	, ('Italiaans')
	, ('Amerikaans')
	, ('Oosters')
	, ('Vlaams')
	, ('Mexicaans')
	, ('Grieks')
	, ('Vegetarisch')

INSERT INTO Ingrediënten (Ingrediënt)
VALUES ('Ei')
	, ('Ham')
	, ('Mayonaise')
	, ('Bieslook')
	, ('Croissant')
	, ('Zout')
	, ('Peper')
	, ('Suiker')
	, ('Nootmuskaat')
	, ('Boter')
	, ('Bakmeel')
	, ('Speculaas')
	, ('Kruidnoot')
	, ('Roomkaas')
	, ('Wrap')
	, ('Aardappel')
	, ('Paprika')
	, ('Bacon')
	, ('Melk')
	, ('Peterselie')
	, ('Rucola')
	, ('Kaas')
	, ('Tortellini')
	, ('Kipfilet')
	, ('Ui')
	, ('Tomaat')
	, ('Kippenbouillon')
	, ('Knoflook')
	, ('Room')
	, ('Basilicum')
	, ('Wortel')

INSERT INTO ReceptMaaltijd (ReceptId, MaaltijdId)
VALUES (1, 1)
	,(1, 4)
	,(2, 5)
	,(2, 6)
	,(3, 1)
	,(3, 4)
	,(4, 7)
	,(5, 2)
	,(5, 3)
	,(5, 4)

INSERT INTO ReceptLabel (ReceptId, LabelId)
VALUES (1, 1)
	,(1, 4)
	,(2, 2)
	,(2, 7)
	,(2, 12)
	,(3, 4)
	,(4, 5)
	,(4, 11)
	,(5, 8)
	,(5, 11)

INSERT INTO ReceptIngrediënt (ReceptId, IngrediëntId)
VALUES (1, 1)
	,(1, 2)
	,(1, 3)
	,(1, 4)
	,(1, 5)
	,(1, 6)
	,(1, 7)
	,(2, 10)
	,(2, 8)
	,(2, 1)
	,(2, 11)
	,(2, 6)
	,(2, 12)
	,(2, 13)
	,(2, 14)
	,(3, 15)
	,(3, 16)
	,(3, 17)
	,(3, 18)
	,(3, 1)
	,(3, 19)
	,(3, 20)
	,(3, 21)
	,(3, 22)
	,(3, 6)
	,(3, 7)
	,(4, 23)
	,(4, 24)
	,(4, 14)
	,(4, 25)
	,(4, 17)
	,(4, 22)
	,(5, 26)
	,(5, 27)
	,(5, 28)
	,(5, 25)
	,(5, 31)
	,(5, 29)
	,(5, 30)
	,(5, 6)
	,(5, 7)