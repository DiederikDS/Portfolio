USE [master]
GO
/****** Object:  Database [Project]    Script Date: 08/12/2020 23:23:07 ******/
CREATE DATABASE [Project]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Project', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Project_Primary.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Project_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Project_Primary.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Project] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Project].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Project] SET ANSI_NULL_DEFAULT ON 
GO
ALTER DATABASE [Project] SET ANSI_NULLS ON 
GO
ALTER DATABASE [Project] SET ANSI_PADDING ON 
GO
ALTER DATABASE [Project] SET ANSI_WARNINGS ON 
GO
ALTER DATABASE [Project] SET ARITHABORT ON 
GO
ALTER DATABASE [Project] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Project] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Project] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Project] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Project] SET CURSOR_DEFAULT  LOCAL 
GO
ALTER DATABASE [Project] SET CONCAT_NULL_YIELDS_NULL ON 
GO
ALTER DATABASE [Project] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Project] SET QUOTED_IDENTIFIER ON 
GO
ALTER DATABASE [Project] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Project] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Project] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Project] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Project] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Project] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Project] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Project] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Project] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Project] SET RECOVERY FULL 
GO
ALTER DATABASE [Project] SET  MULTI_USER 
GO
ALTER DATABASE [Project] SET PAGE_VERIFY NONE  
GO
ALTER DATABASE [Project] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Project] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Project] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Project] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Project', N'ON'
GO
ALTER DATABASE [Project] SET QUERY_STORE = OFF
GO
USE [Project]
GO
/****** Object:  Table [dbo].[Labels]    Script Date: 08/12/2020 23:23:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Labels](
	[LabelId] [int] IDENTITY(1,1) NOT NULL,
	[Label] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Labels] PRIMARY KEY CLUSTERED 
(
	[LabelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recepten]    Script Date: 08/12/2020 23:23:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recepten](
	[ReceptId] [int] IDENTITY(1,1) NOT NULL,
	[ReceptNaam] [nvarchar](50) NOT NULL,
	[GebruikersId] [int] NOT NULL,
	[Beschrijving] [nvarchar](500) NOT NULL,
	[Tijd] [int] NULL,
	[AantalPersonen] [int] NULL,
 CONSTRAINT [PK_Recepten] PRIMARY KEY CLUSTERED 
(
	[ReceptId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReceptLabel]    Script Date: 08/12/2020 23:23:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReceptLabel](
	[ReceptId] [int] NOT NULL,
	[LabelId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Grieks]    Script Date: 08/12/2020 23:23:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Grieks]
	AS SELECT Re.ReceptId 
		, ReceptNaam
		, Re.GebruikersId
	FROM Recepten AS Re
		FULL OUTER JOIN ReceptLabel AS ReLa ON Re.ReceptId = ReLa.ReceptId
		FULL OUTER JOIN Labels AS Le ON ReLa.LabelId = Le.LabelId
	WHERE Label = 'Grieks'
GO
/****** Object:  Table [dbo].[Gebruikers]    Script Date: 08/12/2020 23:23:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gebruikers](
	[GebruikersId] [int] IDENTITY(1,1) NOT NULL,
	[VoorNaam] [nvarchar](50) NOT NULL,
	[AchterNaam] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Adres] [nvarchar](50) NOT NULL,
	[ZipCode] [int] NOT NULL,
 CONSTRAINT [PK_Gebruikers] PRIMARY KEY CLUSTERED 
(
	[GebruikersId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ingrediënten]    Script Date: 08/12/2020 23:23:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingrediënten](
	[IngrediëntId] [int] IDENTITY(1,1) NOT NULL,
	[Ingrediënt] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Ingrediënten] PRIMARY KEY CLUSTERED 
(
	[IngrediëntId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Maaltijden]    Script Date: 08/12/2020 23:23:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Maaltijden](
	[MaaltijdId] [int] IDENTITY(1,1) NOT NULL,
	[Maaltijd] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Maaltijden] PRIMARY KEY CLUSTERED 
(
	[MaaltijdId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReceptIngrediënt]    Script Date: 08/12/2020 23:23:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReceptIngrediënt](
	[ReceptId] [int] NOT NULL,
	[IngrediëntId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReceptMaaltijd]    Script Date: 08/12/2020 23:23:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReceptMaaltijd](
	[ReceptId] [int] NOT NULL,
	[MaaltijdId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 08/12/2020 23:23:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[ReviewId] [int] IDENTITY(1,1) NOT NULL,
	[Review] [nvarchar](200) NOT NULL,
	[ReceptId] [int] NOT NULL,
	[GebruikersId] [int] NOT NULL,
 CONSTRAINT [PK_Reviews] PRIMARY KEY CLUSTERED 
(
	[ReviewId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ZipCodes]    Script Date: 08/12/2020 23:23:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZipCodes](
	[ZipCode] [int] NOT NULL,
	[Stad] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ZipCodes] PRIMARY KEY CLUSTERED 
(
	[ZipCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Gebruikers] ON 

INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (1, N'Diederik', N'De Soete', N'diederik.desoete@gmail.com', N'Parklaan 17', 9000)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (2, N'Sarah', N'Peeters', N'sarah.Peeters@gmail.com', N'Hazenpad 4', 8210)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (3, N'Tom', N'Janssens', N'tom.janssens@gmail.com', N'Academiestraat 5', 2000)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (4, N'Pieter', N'Maes', N'pieter.maes@gmail.com', N'Augustijnenrei 34', 3000)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (5, N'Anton', N'Mertens', N'anton.mertens@hotmail.com', N'Bollaardstraat 29', 3118)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (6, N'Michiel', N'De Smet', N'Michiel.desmet@gmail.com', N'Giststraat 2', 2880)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (7, N'Saar', N'De Coster', N'saar.descoster@hotmail.com', N'Grote Markt 94', 9000)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (8, N'Marie', N'Gabriel', N'marie.gabriel@gmail.com', N'Kandelaarstraat 109', 8210)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (9, N'Marieke', N'Steen', N'marieke.steen@gmail.com', N'Kapelstraat 73', 9000)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (10, N'Lorenzo', N'Vanmullem', N'lorenzo.vanmullem@gmail.com', N'Neststraat 62', 2000)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (11, N'Ella', N'Dedrijcke', N'ella.derijcke@gmail.com', N'Oude Zak 1', 2100)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (12, N'Amber', N'Sommers', N'amber.sommers@gmail.com', N'Mallebergplaats 68', 3600)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (13, N'Charlotte', N'De Pauw', N'charlotte.depauw@gmail.com', N'Groenestraat 52', 3000)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (14, N'Laurent', N'Maes', N'laurent.maes@gmail.com', N'Goezeputstraat 7', 8400)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (15, N'Freddy', N'Vanbelle', N'freddy.vanbelle@gmail.com', N'Zilverstraat 84', 8510)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (16, N'Phillipe', N'De Coster', N'phillipe.decoster@gmail.com', N'Zuidzandstraat 19', 2100)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (17, N'Kenneth', N'Delange', N'kenneth.delange@gmail.com', N'Violierstraat 61', 8000)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (18, N'Kevin', N'slegers', N'kevin.slegers@gmail.com', N'Walstraat 37', 2000)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (19, N'Michiel', N'Deman', N'michiel.deman@gmail.com', N'Speelmansstraat 42', 9290)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (20, N'Tom', N'Devos', N'tom.devos@gmail.com', N'Rodestraat 20', 8210)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (21, N'Siebe', N'Goossens', N'siebe.goossens@gmail.com', N'Engelstraat 51', 2880)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (22, N'Sarah', N'de Jong', N'sarah.dejong@gmail.com', N'Fonteinstraat 126', 9520)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (23, N'Alain', N'Peeters', N'alain.peeters@gmail.com', N'Blekersstraat 14', 9810)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (24, N'Tristan', N'Vanheste', N'tristanvanheste@gmail.com', N'Beenhouwersstraat 93', 2400)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (25, N'Tom', N'van den Berg', N'tom.vandenberg@gmail.com', N'Molenmeers 87', 1850)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (26, N'Steven', N'de Vries', N'steven.devries@gmail.com', N'Pieter Pourbusstraat 46', 1620)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (27, N'Maxim', N' Visser', N'maxim.visser@gmail.com', N'Predikherenstraat 38', 9290)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (28, N'Dennis', N'Peeters', N'dennis.peeters@gmail.com', N'Niklaas Desparsstraat 55', 9000)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (29, N'Evelien', N'van Leeuwen', N'evelien.vanleeuwen@gmail.com', N'Loppemstraat 33', 2300)
INSERT [dbo].[Gebruikers] ([GebruikersId], [VoorNaam], [AchterNaam], [Email], [Adres], [ZipCode]) VALUES (30, N'Danny', N'Smet', N'danny.smet', N'Kreupelenstraat 9', 3000)
SET IDENTITY_INSERT [dbo].[Gebruikers] OFF
GO
SET IDENTITY_INSERT [dbo].[Ingrediënten] ON 

INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (16, N'Aardappel')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (60, N'Aardbei')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (45, N'Amaretto')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (62, N'Ananas')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (53, N'Appel')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (55, N'Asperge')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (18, N'Bacon')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (11, N'Bakmeel')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (30, N'Basilicum')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (4, N'Bieslook')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (37, N'Bladerdeeg')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (33, N'Bloem')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (10, N'Boter')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (71, N'Broccoli')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (42, N'Cacao')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (73, N'Cake')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (32, N'Chocolade')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (5, N'Croissant')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (1, N'Ei')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (63, N'Feta')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (47, N'Gehakt')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (36, N'Groene pesto')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (58, N'Groentenmix')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (2, N'Ham')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (49, N'Italiaanse kruiden')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (22, N'Kaas')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (52, N'Kaneel')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (39, N'Kerriepoeder')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (69, N'Ketjap Manis')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (24, N'Kipfilet')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (27, N'Kippenbouillon')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (61, N'Kiwi')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (28, N'Knoflook')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (44, N'Koffie')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (64, N'Komkommer')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (13, N'Kruidnoot')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (43, N'Lange vingers')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (57, N'Macaroni')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (67, N'Maïskolf')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (41, N'Mascarpone')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (3, N'Mayonaise')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (19, N'Melk')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (48, N'Mozarella')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (70, N'Noedels')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (9, N'Nootmuskaat')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (66, N'Olijfolie')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (65, N'Oregano')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (51, N'Paneermeel')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (17, N'Paprika')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (54, N'Peer')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (7, N'Peper')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (20, N'Peterselie')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (46, N'Pizzadeeg')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (31, N'Pompoen')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (38, N'Prei')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (29, N'Room')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (14, N'Roomkaas')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (21, N'Rucola')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (35, N'Sla')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (12, N'Speculaas')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (34, N'Spek')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (8, N'Suiker')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (26, N'Tomaat')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (23, N'Tortellini')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (72, N'Tortilla chips')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (25, N'Ui')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (59, N'Vanille ijs')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (40, N'Vegetarisch gehakt')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (56, N'Water')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (50, N'Witvis')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (68, N'Wortel')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (15, N'Wrap')
INSERT [dbo].[Ingrediënten] ([IngrediëntId], [Ingrediënt]) VALUES (6, N'Zout')
SET IDENTITY_INSERT [dbo].[Ingrediënten] OFF
GO
SET IDENTITY_INSERT [dbo].[Labels] ON 

INSERT [dbo].[Labels] ([LabelId], [Label]) VALUES (10, N'Alcohol')
INSERT [dbo].[Labels] ([LabelId], [Label]) VALUES (12, N'Amerikaans')
INSERT [dbo].[Labels] ([LabelId], [Label]) VALUES (16, N'Grieks')
INSERT [dbo].[Labels] ([LabelId], [Label]) VALUES (3, N'Halloween')
INSERT [dbo].[Labels] ([LabelId], [Label]) VALUES (11, N'Italiaans')
INSERT [dbo].[Labels] ([LabelId], [Label]) VALUES (5, N'Kip')
INSERT [dbo].[Labels] ([LabelId], [Label]) VALUES (15, N'Mexicaans')
INSERT [dbo].[Labels] ([LabelId], [Label]) VALUES (13, N'Oosters')
INSERT [dbo].[Labels] ([LabelId], [Label]) VALUES (1, N'Pasen')
INSERT [dbo].[Labels] ([LabelId], [Label]) VALUES (7, N'Pattiserie')
INSERT [dbo].[Labels] ([LabelId], [Label]) VALUES (9, N'Salade')
INSERT [dbo].[Labels] ([LabelId], [Label]) VALUES (2, N'Sinterklaas')
INSERT [dbo].[Labels] ([LabelId], [Label]) VALUES (8, N'Soep')
INSERT [dbo].[Labels] ([LabelId], [Label]) VALUES (17, N'Vegetarisch')
INSERT [dbo].[Labels] ([LabelId], [Label]) VALUES (6, N'Vis')
INSERT [dbo].[Labels] ([LabelId], [Label]) VALUES (14, N'Vlaams')
INSERT [dbo].[Labels] ([LabelId], [Label]) VALUES (4, N'Vlees')
SET IDENTITY_INSERT [dbo].[Labels] OFF
GO
SET IDENTITY_INSERT [dbo].[Maaltijden] ON 

INSERT [dbo].[Maaltijden] ([MaaltijdId], [Maaltijd]) VALUES (6, N'4-uurtje')
INSERT [dbo].[Maaltijden] ([MaaltijdId], [Maaltijd]) VALUES (2, N'Aperitief')
INSERT [dbo].[Maaltijden] ([MaaltijdId], [Maaltijd]) VALUES (5, N'Dessert')
INSERT [dbo].[Maaltijden] ([MaaltijdId], [Maaltijd]) VALUES (7, N'Dinner')
INSERT [dbo].[Maaltijden] ([MaaltijdId], [Maaltijd]) VALUES (4, N'Lunch')
INSERT [dbo].[Maaltijden] ([MaaltijdId], [Maaltijd]) VALUES (1, N'Ontbijt')
INSERT [dbo].[Maaltijden] ([MaaltijdId], [Maaltijd]) VALUES (3, N'Voorgerecht')
SET IDENTITY_INSERT [dbo].[Maaltijden] OFF
GO
SET IDENTITY_INSERT [dbo].[Recepten] ON 

INSERT [dbo].[Recepten] ([ReceptId], [ReceptNaam], [GebruikersId], [Beschrijving], [Tijd], [AantalPersonen]) VALUES (1, N'Gevulde croissantjes met eiersalade', 8, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 20, 2)
INSERT [dbo].[Recepten] ([ReceptId], [ReceptNaam], [GebruikersId], [Beschrijving], [Tijd], [AantalPersonen]) VALUES (2, N'Cupcakes', 13, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', NULL, 3)
INSERT [dbo].[Recepten] ([ReceptId], [ReceptNaam], [GebruikersId], [Beschrijving], [Tijd], [AantalPersonen]) VALUES (3, N'Wraps met aardappel en bacon', 27, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 25, 2)
INSERT [dbo].[Recepten] ([ReceptId], [ReceptNaam], [GebruikersId], [Beschrijving], [Tijd], [AantalPersonen]) VALUES (4, N'Tortellini ovenschotel met kip', 2, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 40, 3)
INSERT [dbo].[Recepten] ([ReceptId], [ReceptNaam], [GebruikersId], [Beschrijving], [Tijd], [AantalPersonen]) VALUES (5, N'Tomatensoep', 3, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 30, NULL)
INSERT [dbo].[Recepten] ([ReceptId], [ReceptNaam], [GebruikersId], [Beschrijving], [Tijd], [AantalPersonen]) VALUES (6, N'Pompoen brownie', 16, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 45, 8)
INSERT [dbo].[Recepten] ([ReceptId], [ReceptNaam], [GebruikersId], [Beschrijving], [Tijd], [AantalPersonen]) VALUES (7, N'Tortellini salade met spekjes', 2, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 25, 5)
INSERT [dbo].[Recepten] ([ReceptId], [ReceptNaam], [GebruikersId], [Beschrijving], [Tijd], [AantalPersonen]) VALUES (8, N'Quiche met kip kerrie', 11, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 50, 2)
INSERT [dbo].[Recepten] ([ReceptId], [ReceptNaam], [GebruikersId], [Beschrijving], [Tijd], [AantalPersonen]) VALUES (9, N'Vegetarische saucijzenbroodjes', 24, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 50, 4)
INSERT [dbo].[Recepten] ([ReceptId], [ReceptNaam], [GebruikersId], [Beschrijving], [Tijd], [AantalPersonen]) VALUES (10, N'Tiramisu', 7, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 180, 6)
INSERT [dbo].[Recepten] ([ReceptId], [ReceptNaam], [GebruikersId], [Beschrijving], [Tijd], [AantalPersonen]) VALUES (11, N'Pizza met gehaktballetjes', 29, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 30, 2)
INSERT [dbo].[Recepten] ([ReceptId], [ReceptNaam], [GebruikersId], [Beschrijving], [Tijd], [AantalPersonen]) VALUES (12, N'Viskoekjes', 23, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 30, 3)
INSERT [dbo].[Recepten] ([ReceptId], [ReceptNaam], [GebruikersId], [Beschrijving], [Tijd], [AantalPersonen]) VALUES (13, N'Kipschnitzel', 1, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 25, 2)
INSERT [dbo].[Recepten] ([ReceptId], [ReceptNaam], [GebruikersId], [Beschrijving], [Tijd], [AantalPersonen]) VALUES (14, N'Appel-perentaart', 7, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 90, 4)
INSERT [dbo].[Recepten] ([ReceptId], [ReceptNaam], [GebruikersId], [Beschrijving], [Tijd], [AantalPersonen]) VALUES (15, N'Aspergesoep met ham', 8, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 30, 2)
INSERT [dbo].[Recepten] ([ReceptId], [ReceptNaam], [GebruikersId], [Beschrijving], [Tijd], [AantalPersonen]) VALUES (16, N'Macaroni ovenschotel met gehakt', 17, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 50, 2)
INSERT [dbo].[Recepten] ([ReceptId], [ReceptNaam], [GebruikersId], [Beschrijving], [Tijd], [AantalPersonen]) VALUES (17, N'Ijstaart', 22, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', NULL, 8)
INSERT [dbo].[Recepten] ([ReceptId], [ReceptNaam], [GebruikersId], [Beschrijving], [Tijd], [AantalPersonen]) VALUES (18, N'Griekse salade met kip', 3, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 25, 2)
INSERT [dbo].[Recepten] ([ReceptId], [ReceptNaam], [GebruikersId], [Beschrijving], [Tijd], [AantalPersonen]) VALUES (19, N'Pittige maiskolf', 24, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 15, 3)
INSERT [dbo].[Recepten] ([ReceptId], [ReceptNaam], [GebruikersId], [Beschrijving], [Tijd], [AantalPersonen]) VALUES (20, N'Hutsepot met gehakt', 29, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 30, 2)
INSERT [dbo].[Recepten] ([ReceptId], [ReceptNaam], [GebruikersId], [Beschrijving], [Tijd], [AantalPersonen]) VALUES (21, N'Noedels met broccoli en gehakt', 19, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', NULL, 2)
INSERT [dbo].[Recepten] ([ReceptId], [ReceptNaam], [GebruikersId], [Beschrijving], [Tijd], [AantalPersonen]) VALUES (22, N'Nachos met gehakt', 25, N'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', 35, 2)
SET IDENTITY_INSERT [dbo].[Recepten] OFF
GO
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (1, 1)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (1, 2)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (1, 3)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (1, 4)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (1, 5)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (1, 6)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (1, 7)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (2, 1)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (2, 6)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (2, 8)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (2, 10)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (2, 11)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (2, 12)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (2, 13)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (2, 14)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (3, 1)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (3, 6)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (3, 7)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (3, 15)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (3, 16)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (3, 17)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (3, 18)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (3, 19)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (3, 20)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (3, 21)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (3, 22)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (4, 14)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (4, 17)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (4, 22)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (4, 23)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (4, 24)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (4, 25)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (5, 6)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (5, 7)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (5, 25)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (5, 26)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (5, 27)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (5, 28)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (5, 29)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (5, 30)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (5, 68)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (6, 1)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (6, 6)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (6, 8)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (6, 10)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (6, 11)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (6, 12)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (6, 31)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (6, 32)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (6, 33)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (7, 3)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (7, 7)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (7, 23)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (7, 25)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (7, 26)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (7, 34)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (7, 35)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (7, 36)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (8, 1)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (8, 20)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (8, 24)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (8, 25)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (8, 28)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (8, 29)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (8, 37)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (8, 38)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (8, 39)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (9, 25)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (9, 28)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (9, 37)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (9, 40)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (10, 1)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (10, 8)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (10, 41)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (10, 42)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (10, 43)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (10, 44)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (10, 45)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (11, 17)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (11, 22)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (11, 25)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (11, 26)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (11, 46)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (11, 47)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (11, 48)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (11, 49)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (11, 51)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (12, 1)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (12, 6)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (12, 7)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (12, 9)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (12, 20)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (12, 25)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (12, 28)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (12, 33)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (12, 50)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (12, 51)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (13, 1)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (13, 6)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (13, 7)
GO
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (13, 24)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (13, 33)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (13, 51)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (14, 1)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (14, 8)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (14, 10)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (14, 11)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (14, 52)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (14, 53)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (14, 54)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (15, 2)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (15, 6)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (15, 7)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (15, 10)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (15, 20)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (15, 25)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (15, 27)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (15, 33)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (15, 55)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (15, 56)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (16, 6)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (16, 7)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (16, 10)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (16, 19)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (16, 22)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (16, 26)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (16, 28)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (16, 30)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (16, 33)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (16, 47)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (16, 57)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (16, 58)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (17, 52)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (17, 59)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (17, 60)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (17, 61)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (17, 62)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (17, 73)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (18, 24)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (18, 25)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (18, 26)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (18, 35)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (18, 63)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (18, 64)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (18, 65)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (18, 66)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (19, 6)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (19, 10)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (19, 28)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (19, 67)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (20, 6)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (20, 7)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (20, 16)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (20, 19)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (20, 25)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (20, 28)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (20, 39)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (20, 47)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (20, 68)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (20, 69)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (21, 25)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (21, 28)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (21, 47)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (21, 69)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (21, 70)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (21, 71)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (22, 6)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (22, 7)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (22, 17)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (22, 22)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (22, 25)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (22, 26)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (22, 28)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (22, 47)
INSERT [dbo].[ReceptIngrediënt] ([ReceptId], [IngrediëntId]) VALUES (22, 72)
GO
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (1, 1)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (1, 4)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (2, 2)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (2, 7)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (2, 12)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (3, 4)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (4, 5)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (4, 11)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (5, 8)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (5, 11)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (6, 3)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (6, 7)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (7, 4)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (7, 9)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (7, 11)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (8, 5)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (9, 17)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (10, 12)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (10, 14)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (11, 4)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (11, 11)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (12, 6)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (13, 5)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (14, 7)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (15, 4)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (15, 8)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (16, 4)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (16, 11)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (17, 7)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (18, 5)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (18, 9)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (18, 16)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (19, 12)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (19, 17)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (20, 4)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (20, 14)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (21, 4)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (21, 13)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (22, 4)
INSERT [dbo].[ReceptLabel] ([ReceptId], [LabelId]) VALUES (22, 15)
GO
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (1, 1)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (1, 4)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (2, 5)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (2, 6)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (3, 1)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (3, 4)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (4, 7)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (5, 2)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (5, 3)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (5, 4)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (6, 5)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (6, 6)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (7, 4)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (7, 7)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (8, 4)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (8, 7)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (9, 2)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (9, 3)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (9, 4)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (9, 7)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (10, 5)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (11, 2)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (11, 4)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (11, 7)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (12, 4)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (12, 7)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (13, 7)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (14, 5)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (14, 6)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (15, 2)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (15, 3)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (15, 4)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (16, 4)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (16, 7)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (17, 5)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (18, 4)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (18, 7)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (19, 3)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (19, 4)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (19, 6)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (20, 7)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (21, 4)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (21, 7)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (22, 4)
INSERT [dbo].[ReceptMaaltijd] ([ReceptId], [MaaltijdId]) VALUES (22, 7)
GO
SET IDENTITY_INSERT [dbo].[Reviews] ON 

INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (30, N'10/10', 7, 22)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (20, N'Aanrader', 18, 17)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (22, N'Aanrader!', 14, 25)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (25, N'All time favorite', 10, 24)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (18, N'Altijd grote fan van spekjes', 7, 6)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (31, N'De borccoli maakt het uniek', 21, 9)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (8, N'De ham is een leuk idee', 15, 22)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (16, N'Deze mist nog iets vind ik', 5, 7)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (28, N'Deze zou ik sterk aanraden', 20, 7)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (33, N'Dit vond ik niet lekker, Potvolkoffie!', 16, 7)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (9, N'Echte winterkost!', 20, 23)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (29, N'Goed voor bij de koffie', 6, 13)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (26, N'Heel lekker', 3, 19)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (7, N'Het moet niet altijd margherita zijn', 11, 12)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (10, N'Klassiek', 2, 19)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (21, N'Koud zijn deze ook heel lekker', 3, 16)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (2, N'Krokant!', 12, 23)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (32, N'Lekker als hoofdgerecht of voorgerecht', 22, 4)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (24, N'Lekker als voorgerecht', 15, 18)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (14, N'lekker gezonde lunch', 18, 11)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (15, N'Lekkere combinatie', 8, 17)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (6, N'Mijn kinderen zijn grote fan', 10, 28)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (17, N'Mmmmmm!', 6, 26)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (13, N'Net zoals mama die maakt', 10, 4)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (5, N'Niet lekker', 5, 16)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (12, N'Normaal geen fan van asperges, maar in deze soep wel echt lekker', 15, 24)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (27, N'Simpel', 19, 5)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (4, N'Simpel en gezond', 19, 3)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (1, N'Super lekker', 11, 30)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (3, N'Super lekker als dessert', 17, 4)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (11, N'Verrassend lekker', 6, 20)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (19, N'Vreemde, maar lekkere combinatie', 1, 2)
INSERT [dbo].[Reviews] ([ReviewId], [Review], [ReceptId], [GebruikersId]) VALUES (23, N'Weinig werk voor een lekkere maaltijd', 4, 8)
SET IDENTITY_INSERT [dbo].[Reviews] OFF
GO
INSERT [dbo].[ZipCodes] ([ZipCode], [Stad]) VALUES (2000, N'Antwerpen')
INSERT [dbo].[ZipCodes] ([ZipCode], [Stad]) VALUES (9290, N'Berlare')
INSERT [dbo].[ZipCodes] ([ZipCode], [Stad]) VALUES (2880, N'Bornem')
INSERT [dbo].[ZipCodes] ([ZipCode], [Stad]) VALUES (8000, N'Brugge')
INSERT [dbo].[ZipCodes] ([ZipCode], [Stad]) VALUES (2100, N'Deurne')
INSERT [dbo].[ZipCodes] ([ZipCode], [Stad]) VALUES (1620, N'Drogenbos')
INSERT [dbo].[ZipCodes] ([ZipCode], [Stad]) VALUES (3600, N'Genk')
INSERT [dbo].[ZipCodes] ([ZipCode], [Stad]) VALUES (9000, N'Gent')
INSERT [dbo].[ZipCodes] ([ZipCode], [Stad]) VALUES (1850, N'Grimbergen')
INSERT [dbo].[ZipCodes] ([ZipCode], [Stad]) VALUES (3000, N'Leuven')
INSERT [dbo].[ZipCodes] ([ZipCode], [Stad]) VALUES (2400, N'Mol')
INSERT [dbo].[ZipCodes] ([ZipCode], [Stad]) VALUES (9810, N'Nazareth')
INSERT [dbo].[ZipCodes] ([ZipCode], [Stad]) VALUES (8400, N'Oostende')
INSERT [dbo].[ZipCodes] ([ZipCode], [Stad]) VALUES (8510, N'Rollegem')
INSERT [dbo].[ZipCodes] ([ZipCode], [Stad]) VALUES (2300, N'Turnhout')
INSERT [dbo].[ZipCodes] ([ZipCode], [Stad]) VALUES (3118, N'Werchter')
INSERT [dbo].[ZipCodes] ([ZipCode], [Stad]) VALUES (8210, N'Zedelgem')
INSERT [dbo].[ZipCodes] ([ZipCode], [Stad]) VALUES (9520, N'Zonnegem')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Gebruikers]    Script Date: 08/12/2020 23:23:07 ******/
ALTER TABLE [dbo].[Gebruikers] ADD  CONSTRAINT [UK_Gebruikers] UNIQUE NONCLUSTERED 
(
	[VoorNaam] ASC,
	[AchterNaam] ASC,
	[Adres] ASC,
	[ZipCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Ingrediënten]    Script Date: 08/12/2020 23:23:07 ******/
ALTER TABLE [dbo].[Ingrediënten] ADD  CONSTRAINT [UK_Ingrediënten] UNIQUE NONCLUSTERED 
(
	[Ingrediënt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Labels]    Script Date: 08/12/2020 23:23:07 ******/
ALTER TABLE [dbo].[Labels] ADD  CONSTRAINT [UK_Labels] UNIQUE NONCLUSTERED 
(
	[Label] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Maaltijden]    Script Date: 08/12/2020 23:23:07 ******/
ALTER TABLE [dbo].[Maaltijden] ADD  CONSTRAINT [UK_Maaltijden] UNIQUE NONCLUSTERED 
(
	[Maaltijd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Recepten]    Script Date: 08/12/2020 23:23:07 ******/
ALTER TABLE [dbo].[Recepten] ADD  CONSTRAINT [UK_Recepten] UNIQUE NONCLUSTERED 
(
	[ReceptNaam] ASC,
	[GebruikersId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK_ReceptIngrediënt]    Script Date: 08/12/2020 23:23:07 ******/
ALTER TABLE [dbo].[ReceptIngrediënt] ADD  CONSTRAINT [PK_ReceptIngrediënt] PRIMARY KEY NONCLUSTERED 
(
	[ReceptId] ASC,
	[IngrediëntId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK_ReceptLabel]    Script Date: 08/12/2020 23:23:07 ******/
ALTER TABLE [dbo].[ReceptLabel] ADD  CONSTRAINT [PK_ReceptLabel] PRIMARY KEY NONCLUSTERED 
(
	[ReceptId] ASC,
	[LabelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [PK_ReceptMaaltijd]    Script Date: 08/12/2020 23:23:07 ******/
ALTER TABLE [dbo].[ReceptMaaltijd] ADD  CONSTRAINT [PK_ReceptMaaltijd] PRIMARY KEY NONCLUSTERED 
(
	[ReceptId] ASC,
	[MaaltijdId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Reviews]    Script Date: 08/12/2020 23:23:07 ******/
ALTER TABLE [dbo].[Reviews] ADD  CONSTRAINT [UK_Reviews] UNIQUE NONCLUSTERED 
(
	[Review] ASC,
	[ReceptId] ASC,
	[GebruikersId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_ZipCodes]    Script Date: 08/12/2020 23:23:07 ******/
ALTER TABLE [dbo].[ZipCodes] ADD  CONSTRAINT [UK_ZipCodes] UNIQUE NONCLUSTERED 
(
	[Stad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Gebruikers]  WITH CHECK ADD  CONSTRAINT [FK_GebruikersZipCode] FOREIGN KEY([ZipCode])
REFERENCES [dbo].[ZipCodes] ([ZipCode])
GO
ALTER TABLE [dbo].[Gebruikers] CHECK CONSTRAINT [FK_GebruikersZipCode]
GO
ALTER TABLE [dbo].[Recepten]  WITH CHECK ADD  CONSTRAINT [FK_ReceptenGebruikersId] FOREIGN KEY([GebruikersId])
REFERENCES [dbo].[Gebruikers] ([GebruikersId])
GO
ALTER TABLE [dbo].[Recepten] CHECK CONSTRAINT [FK_ReceptenGebruikersId]
GO
ALTER TABLE [dbo].[ReceptIngrediënt]  WITH CHECK ADD  CONSTRAINT [FK_ReceptIngrediëntIngrediëntId] FOREIGN KEY([IngrediëntId])
REFERENCES [dbo].[Ingrediënten] ([IngrediëntId])
GO
ALTER TABLE [dbo].[ReceptIngrediënt] CHECK CONSTRAINT [FK_ReceptIngrediëntIngrediëntId]
GO
ALTER TABLE [dbo].[ReceptIngrediënt]  WITH CHECK ADD  CONSTRAINT [FK_ReceptIngrediëntReceptId] FOREIGN KEY([ReceptId])
REFERENCES [dbo].[Recepten] ([ReceptId])
GO
ALTER TABLE [dbo].[ReceptIngrediënt] CHECK CONSTRAINT [FK_ReceptIngrediëntReceptId]
GO
ALTER TABLE [dbo].[ReceptLabel]  WITH CHECK ADD  CONSTRAINT [FK_ReceptLabelLabelId] FOREIGN KEY([LabelId])
REFERENCES [dbo].[Labels] ([LabelId])
GO
ALTER TABLE [dbo].[ReceptLabel] CHECK CONSTRAINT [FK_ReceptLabelLabelId]
GO
ALTER TABLE [dbo].[ReceptLabel]  WITH CHECK ADD  CONSTRAINT [FK_ReceptLabelReceptId] FOREIGN KEY([ReceptId])
REFERENCES [dbo].[Recepten] ([ReceptId])
GO
ALTER TABLE [dbo].[ReceptLabel] CHECK CONSTRAINT [FK_ReceptLabelReceptId]
GO
ALTER TABLE [dbo].[ReceptMaaltijd]  WITH CHECK ADD  CONSTRAINT [FK_ReceptMaaltijdMaaltijdId] FOREIGN KEY([MaaltijdId])
REFERENCES [dbo].[Maaltijden] ([MaaltijdId])
GO
ALTER TABLE [dbo].[ReceptMaaltijd] CHECK CONSTRAINT [FK_ReceptMaaltijdMaaltijdId]
GO
ALTER TABLE [dbo].[ReceptMaaltijd]  WITH CHECK ADD  CONSTRAINT [FK_ReceptMaaltijdReceptId] FOREIGN KEY([ReceptId])
REFERENCES [dbo].[Recepten] ([ReceptId])
GO
ALTER TABLE [dbo].[ReceptMaaltijd] CHECK CONSTRAINT [FK_ReceptMaaltijdReceptId]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_ReviewsGebruikersId] FOREIGN KEY([GebruikersId])
REFERENCES [dbo].[Gebruikers] ([GebruikersId])
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_ReviewsGebruikersId]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_ReviewsReceptId] FOREIGN KEY([ReceptId])
REFERENCES [dbo].[Recepten] ([ReceptId])
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_ReviewsReceptId]
GO
/****** Object:  StoredProcedure [dbo].[NieuweGebruiker]    Script Date: 08/12/2020 23:23:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NieuweGebruiker] @Zipcode INT, @Stad NVARCHAR(50), @Voornaam NVARCHAR(50), @Achternaam NVARCHAR(50), @Email NVARCHAR(50), @Adres NVARCHAR(50)
AS

IF @Zipcode IN (SELECT ZipCode FROM ZipCodes)
BEGIN
	INSERT INTO Gebruikers (VoorNaam, AchterNaam, Email, Adres, ZipCode)
	VALUES (@Voornaam, @Achternaam, @Email, @Adres, @Zipcode)
END
ELSE
BEGIN
	INSERT INTO ZipCodes (ZipCode, Stad)
	VALUES (@Zipcode, @Stad)

	INSERT INTO Gebruikers (VoorNaam, AchterNaam, Email, Adres, ZipCode)
	VALUES (@Voornaam, @Achternaam, @Email, @Adres, @Zipcode)
END

RETURN 0
GO
USE [master]
GO
ALTER DATABASE [Project] SET  READ_WRITE 
GO
