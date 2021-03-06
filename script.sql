USE [master]
GO
/****** Object:  Database [SocialNetwork]    Script Date: 9/29/2020 2:16:32 PM ******/
CREATE DATABASE [SocialNetwork]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SocialNetwork', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\SocialNetwork.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SocialNetwork_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\SocialNetwork_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SocialNetwork] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SocialNetwork].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SocialNetwork] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SocialNetwork] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SocialNetwork] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SocialNetwork] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SocialNetwork] SET ARITHABORT OFF 
GO
ALTER DATABASE [SocialNetwork] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SocialNetwork] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SocialNetwork] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SocialNetwork] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SocialNetwork] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SocialNetwork] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SocialNetwork] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SocialNetwork] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SocialNetwork] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SocialNetwork] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SocialNetwork] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SocialNetwork] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SocialNetwork] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SocialNetwork] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SocialNetwork] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SocialNetwork] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SocialNetwork] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SocialNetwork] SET RECOVERY FULL 
GO
ALTER DATABASE [SocialNetwork] SET  MULTI_USER 
GO
ALTER DATABASE [SocialNetwork] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SocialNetwork] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SocialNetwork] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SocialNetwork] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [SocialNetwork] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'SocialNetwork', N'ON'
GO
USE [SocialNetwork]
GO
/****** Object:  Table [dbo].[comment]    Script Date: 9/29/2020 2:16:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[comment](
	[commentID] [int] IDENTITY(1,1) NOT NULL,
	[postID] [int] NOT NULL,
	[email] [nvarchar](150) NOT NULL,
	[content] [nvarchar](500) NOT NULL,
	[date] [datetime] NOT NULL,
	[status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[commentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[emotion]    Script Date: 9/29/2020 2:16:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[emotion](
	[emotionID] [int] IDENTITY(1,1) NOT NULL,
	[postID] [int] NOT NULL,
	[email] [nvarchar](150) NULL,
	[status] [int] NOT NULL,
	[date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[emotionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[notification]    Script Date: 9/29/2020 2:16:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[notification](
	[notificationID] [int] IDENTITY(1,1) NOT NULL,
	[postID] [int] NOT NULL,
	[email] [nvarchar](150) NULL,
	[date] [datetime] NOT NULL,
	[type] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[notificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[otp]    Script Date: 9/29/2020 2:16:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[otp](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[email] [nvarchar](150) NOT NULL,
	[otp] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[post]    Script Date: 9/29/2020 2:16:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[post](
	[postID] [int] IDENTITY(1,1) NOT NULL,
	[email] [nvarchar](150) NOT NULL,
	[image] [nvarchar](250) NULL,
	[description] [nvarchar](500) NULL,
	[date] [datetime] NOT NULL,
	[numberOfLike] [int] NOT NULL,
	[numberOfDislike] [int] NOT NULL,
	[status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[postID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[status]    Script Date: 9/29/2020 2:16:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[status](
	[statusID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[statusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[user]    Script Date: 9/29/2020 2:16:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user](
	[firstname] [nvarchar](50) NOT NULL,
	[lastname] [nvarchar](50) NOT NULL,
	[email] [nvarchar](150) NOT NULL,
	[password] [nvarchar](500) NOT NULL,
	[status] [int] NOT NULL,
	[unreadNotification] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[comment] ON 

INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (1, 2, N'anhwtuan@gmail.com', N'No like?', CAST(N'2020-09-24 17:24:03.957' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (3, 3, N'anhwtuan@gmail.com', N'Hallo', CAST(N'2020-09-24 17:26:05.613' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (4, 4, N'anhwtuan@gmail.com', N'Yo', CAST(N'2020-09-25 09:52:06.300' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (5, 4, N'anhztuan590@gmail.com', N'Hellloooooo!!', CAST(N'2020-09-25 09:53:25.653' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (6, 4, N'anhwtuan@gmail.com', N'Hellloooooo!!', CAST(N'2020-09-25 09:55:09.737' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (7, 5, N'anhztuan590@gmail.com', N'Hmm?', CAST(N'2020-09-25 10:33:05.707' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (8, 5, N'anhztuan590@gmail.com', N'No one', CAST(N'2020-09-25 10:33:14.780' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (9, 7, N'anhwtuan@gmail.com', N'What?', CAST(N'2020-09-25 15:17:06.113' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (10, 6, N'anhwtuan@gmail.com', N'ADAfafa', CAST(N'2020-09-25 15:17:11.677' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (11, 7, N'anhwtuan@gmail.com', N'Nothing', CAST(N'2020-09-25 15:50:02.910' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (12, 7, N'anhwtuan@gmail.com', N'I fixed it', CAST(N'2020-09-25 15:50:10.907' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (13, 7, N'anhztuan590@gmail.com', N'Crazy???', CAST(N'2020-09-25 19:21:37.233' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (14, 3, N'anhztuan590@gmail.com', N'Hi', CAST(N'2020-09-25 20:49:24.947' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (15, 11, N'anhwtuan@gmail.com', N'Hahahahahhahahahahahahaha.............', CAST(N'2020-09-26 10:53:55.107' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (16, 15, N'anhztuan590@gmail.com', N'Ho ho..', CAST(N'2020-09-26 15:17:02.357' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (17, 15, N'anhwtuan@gmail.com', N'Searching work..hahahaha', CAST(N'2020-09-26 19:34:09.473' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (18, 16, N'anhwtuan@gmail.com', N'Go work.', CAST(N'2020-09-26 19:48:10.667' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (19, 16, N'anhwtuan@gmail.com', N'...', CAST(N'2020-09-26 19:48:54.117' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (20, 14, N'anhwtuan@gmail.com', N'Hmm?', CAST(N'2020-09-26 19:49:21.463' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (21, 17, N'anhwtuan@gmail.com', N'more..', CAST(N'2020-09-26 19:57:15.393' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (22, 15, N'anhwtuan@gmail.com', N'jo', CAST(N'2020-09-26 19:59:01.417' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (23, 17, N'anhwtuan@gmail.com', N'tesing redirect', CAST(N'2020-09-26 20:11:32.880' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (24, 17, N'anhwtuan@gmail.com', N'tesing redirect', CAST(N'2020-09-26 20:12:09.670' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (25, 17, N'anhwtuan@gmail.com', N'tesing redirect', CAST(N'2020-09-26 20:12:54.160' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (26, 17, N'anhwtuan@gmail.com', N'tesing redirect', CAST(N'2020-09-26 20:13:24.187' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (27, 17, N'anhwtuan@gmail.com', N'Hi', CAST(N'2020-09-26 20:15:24.477' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (28, 17, N'anhwtuan@gmail.com', N'Hi', CAST(N'2020-09-26 20:15:46.273' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (29, 17, N'anhwtuan@gmail.com', N'Hi', CAST(N'2020-09-26 20:18:26.257' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (30, 17, N'anhwtuan@gmail.com', N'Hi', CAST(N'2020-09-26 20:19:53.673' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (31, 17, N'anhwtuan@gmail.com', N'Hi', CAST(N'2020-09-26 20:26:32.207' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (32, 17, N'anhwtuan@gmail.com', N'Hi', CAST(N'2020-09-26 20:27:50.537' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (33, 17, N'anhwtuan@gmail.com', N'Hi', CAST(N'2020-09-26 20:30:03.220' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (34, 17, N'anhwtuan@gmail.com', N'Hi', CAST(N'2020-09-26 20:30:30.007' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (35, 15, N'anhwtuan@gmail.com', N'test', CAST(N'2020-09-26 20:30:59.533' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (36, 20, N'anhwtuan@gmail.com', N'hmmm', CAST(N'2020-09-26 23:03:45.037' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (37, 33, N'anhwtuan@gmail.com', N'no', CAST(N'2020-09-26 23:50:00.430' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (38, 53, N'anhwtuan@gmail.com', N'Hmm?', CAST(N'2020-09-27 11:07:00.277' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (39, 52, N'anhztuan590@gmail.com', N'No i am the king', CAST(N'2020-09-27 15:00:35.797' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (40, 51, N'anhztuan590@gmail.com', N'sad :(', CAST(N'2020-09-27 15:39:33.787' AS DateTime), 3)
INSERT [dbo].[comment] ([commentID], [postID], [email], [content], [date], [status]) VALUES (41, 5, N'anhwtuan@gmail.com', N'Tesing notification', CAST(N'2020-09-27 16:04:45.930' AS DateTime), 3)
SET IDENTITY_INSERT [dbo].[comment] OFF
SET IDENTITY_INSERT [dbo].[emotion] ON 

INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (1, 7, N'anhwtuan@gmail.com', 6, CAST(N'2020-09-25 17:17:09.797' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (4, 7, N'anhztuan590@gmail.com', 5, CAST(N'2020-09-25 20:40:47.887' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (5, 6, N'anhztuan590@gmail.com', 5, CAST(N'2020-09-25 20:48:28.450' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (6, 5, N'anhztuan590@gmail.com', 15, CAST(N'2020-09-25 20:48:40.477' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (7, 3, N'anhztuan590@gmail.com', 6, CAST(N'2020-09-25 20:57:16.243' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (8, 4, N'anhztuan590@gmail.com', 5, CAST(N'2020-09-25 21:09:00.313' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (11, 11, N'anhwtuan@gmail.com', 5, CAST(N'2020-09-26 10:53:58.553' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (12, 6, N'anhwtuan@gmail.com', 6, CAST(N'2020-09-26 10:58:08.477' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (13, 4, N'anhwtuan@gmail.com', 6, CAST(N'2020-09-26 10:58:46.357' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (14, 3, N'anhwtuan@gmail.com', 6, CAST(N'2020-09-26 10:59:03.633' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (15, 2, N'anhwtuan@gmail.com', 5, CAST(N'2020-09-26 10:59:08.727' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (16, 15, N'anhwtuan@gmail.com', 5, CAST(N'2020-09-26 13:04:57.080' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (17, 15, N'anhztuan590@gmail.com', 5, CAST(N'2020-09-26 15:17:04.887' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (18, 14, N'anhwtuan@gmail.com', 5, CAST(N'2020-09-26 19:49:27.070' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (19, 18, N'anhztuan590@gmail.com', 5, CAST(N'2020-09-26 20:52:39.587' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (20, 18, N'anhwtuan@gmail.com', 6, CAST(N'2020-09-26 21:27:04.683' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (21, 16, N'anhwtuan@gmail.com', 6, CAST(N'2020-09-26 21:27:09.753' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (22, 19, N'anhwtuan@gmail.com', 6, CAST(N'2020-09-26 21:27:54.030' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (23, 20, N'anhwtuan@gmail.com', 6, CAST(N'2020-09-26 23:03:58.357' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (24, 33, N'anhwtuan@gmail.com', 6, CAST(N'2020-09-26 23:50:03.263' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (25, 51, N'anhwtuan@gmail.com', 5, CAST(N'2020-09-27 01:59:43.453' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (26, 53, N'anhwtuan@gmail.com', 5, CAST(N'2020-09-27 02:02:30.397' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (27, 52, N'anhwtuan@gmail.com', 6, CAST(N'2020-09-27 11:45:19.070' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (28, 52, N'anhztuan590@gmail.com', 5, CAST(N'2020-09-27 15:00:16.667' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (29, 51, N'anhztuan590@gmail.com', 6, CAST(N'2020-09-27 15:00:19.743' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (30, 50, N'anhztuan590@gmail.com', 5, CAST(N'2020-09-27 15:00:24.197' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (31, 48, N'anhztuan590@gmail.com', 5, CAST(N'2020-09-27 16:09:23.487' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (32, 49, N'anhztuan590@gmail.com', 5, CAST(N'2020-09-27 16:30:40.833' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (33, 50, N'anhwtuan@gmail.com', 5, CAST(N'2020-09-27 16:46:39.287' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (34, 48, N'anhwtuan@gmail.com', 5, CAST(N'2020-09-27 16:48:46.357' AS DateTime))
INSERT [dbo].[emotion] ([emotionID], [postID], [email], [status], [date]) VALUES (35, 27, N'anhwtuan@gmail.com', 5, CAST(N'2020-09-27 16:52:41.957' AS DateTime))
SET IDENTITY_INSERT [dbo].[emotion] OFF
SET IDENTITY_INSERT [dbo].[notification] ON 

INSERT [dbo].[notification] ([notificationID], [postID], [email], [date], [type]) VALUES (1, 52, N'anhztuan590@gmail.com', CAST(N'2020-09-27 15:00:35.803' AS DateTime), N'commented')
INSERT [dbo].[notification] ([notificationID], [postID], [email], [date], [type]) VALUES (2, 51, N'anhztuan590@gmail.com', CAST(N'2020-09-27 15:39:33.793' AS DateTime), N'commented')
INSERT [dbo].[notification] ([notificationID], [postID], [email], [date], [type]) VALUES (3, 5, N'anhwtuan@gmail.com', CAST(N'2020-09-27 16:04:45.937' AS DateTime), N'commented')
INSERT [dbo].[notification] ([notificationID], [postID], [email], [date], [type]) VALUES (4, 50, N'anhztuan590@gmail.com', CAST(N'2020-09-27 16:06:36.060' AS DateTime), N'Like')
INSERT [dbo].[notification] ([notificationID], [postID], [email], [date], [type]) VALUES (5, 48, N'anhztuan590@gmail.com', CAST(N'2020-09-27 16:09:23.493' AS DateTime), N'Like')
INSERT [dbo].[notification] ([notificationID], [postID], [email], [date], [type]) VALUES (6, 49, N'anhztuan590@gmail.com', CAST(N'2020-09-27 16:30:40.843' AS DateTime), N'Like')
INSERT [dbo].[notification] ([notificationID], [postID], [email], [date], [type]) VALUES (7, 50, N'anhwtuan@gmail.com', CAST(N'2020-09-27 16:46:39.300' AS DateTime), N'Like')
INSERT [dbo].[notification] ([notificationID], [postID], [email], [date], [type]) VALUES (8, 48, N'anhwtuan@gmail.com', CAST(N'2020-09-27 16:48:46.360' AS DateTime), N'Like')
INSERT [dbo].[notification] ([notificationID], [postID], [email], [date], [type]) VALUES (9, 27, N'anhwtuan@gmail.com', CAST(N'2020-09-27 16:52:41.957' AS DateTime), N'Like')
INSERT [dbo].[notification] ([notificationID], [postID], [email], [date], [type]) VALUES (10, 51, N'anhztuan590@gmail.com', CAST(N'2020-09-27 17:04:12.093' AS DateTime), N'Dislike')
INSERT [dbo].[notification] ([notificationID], [postID], [email], [date], [type]) VALUES (11, 51, N'anhztuan590@gmail.com', CAST(N'2020-09-27 17:08:16.173' AS DateTime), N'Dislike')
INSERT [dbo].[notification] ([notificationID], [postID], [email], [date], [type]) VALUES (12, 16, N'anhwtuan@gmail.com', CAST(N'2020-09-27 17:08:31.203' AS DateTime), N'Dislike')
INSERT [dbo].[notification] ([notificationID], [postID], [email], [date], [type]) VALUES (13, 51, N'anhztuan590@gmail.com', CAST(N'2020-09-27 17:45:12.733' AS DateTime), N'Dislike')
INSERT [dbo].[notification] ([notificationID], [postID], [email], [date], [type]) VALUES (14, 52, N'anhwtuan@gmail.com', CAST(N'2020-09-28 07:22:30.163' AS DateTime), N'Dislike')
SET IDENTITY_INSERT [dbo].[notification] OFF
SET IDENTITY_INSERT [dbo].[otp] ON 

INSERT [dbo].[otp] ([id], [email], [otp]) VALUES (1, N'anhwtuan@gmail.com', 17323917)
INSERT [dbo].[otp] ([id], [email], [otp]) VALUES (2, N'anhztuan590@gmail.com', 91086994)
SET IDENTITY_INSERT [dbo].[otp] OFF
SET IDENTITY_INSERT [dbo].[post] ON 

INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (2, N'anhwtuan@gmail.com', N'', N'Second post in the network.', CAST(N'2020-08-22 00:00:00.000' AS DateTime), 1, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (3, N'anhwtuan@gmail.com', N'', N'First post in the network.', CAST(N'2020-08-21 00:00:00.000' AS DateTime), 0, 1, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (4, N'anhwtuan@gmail.com', N'', N'Hello world!
', CAST(N'2020-09-25 08:28:19.873' AS DateTime), 2, 1, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (5, N'anhztuan590@gmail.com', N'', N'Can not load comment. Help!!!!', CAST(N'2020-09-25 10:32:50.677' AS DateTime), 0, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (6, N'anhwtuan@gmail.com', N'', N'dsfgh
', CAST(N'2020-09-25 14:55:42.763' AS DateTime), 1, 1, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (7, N'anhwtuan@gmail.com', N'', N'Help', CAST(N'2020-09-25 15:15:27.650' AS DateTime), 1, 1, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (10, N'anhwtuan@gmail.com', N'', N'Working on picture...', CAST(N'2020-09-26 10:49:16.403' AS DateTime), 0, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (11, N'anhwtuan@gmail.com', N'maxresdefault.jpg', N'Testing picture', CAST(N'2020-09-26 10:52:33.890' AS DateTime), 1, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (12, N'anhwtuan@gmail.com', N'', N'Testing paging...', CAST(N'2020-09-26 12:07:40.823' AS DateTime), 0, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (13, N'anhwtuan@gmail.com', N'', N'Adding more posts', CAST(N'2020-09-26 12:09:57.270' AS DateTime), 0, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (14, N'anhwtuan@gmail.com', N'', N'More post incoming...', CAST(N'2020-09-26 12:27:34.960' AS DateTime), 1, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (15, N'anhwtuan@gmail.com', N'image-450w-766363144.jpg', N'Working on searching..', CAST(N'2020-09-26 13:04:54.240' AS DateTime), 2, 0, 4)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (16, N'anhztuan590@gmail.com', N'', N'Still working', CAST(N'2020-09-26 17:28:13.983' AS DateTime), 0, 1, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (17, N'anhwtuan@gmail.com', N'', N'More post...', CAST(N'2020-09-26 19:57:06.203' AS DateTime), 0, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (18, N'anhztuan590@gmail.com', N'hqdefault.jpg', N'Doggo
', CAST(N'2020-09-26 20:52:36.310' AS DateTime), 1, 1, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (19, N'anhwtuan@gmail.com', NULL, N'Check this bird :D', CAST(N'2020-09-26 21:27:26.557' AS DateTime), 0, 1, 4)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (20, N'anhwtuan@gmail.com', NULL, N':D', CAST(N'2020-09-26 22:11:59.220' AS DateTime), 0, 1, 4)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (21, N'anhwtuan@gmail.com', NULL, NULL, CAST(N'2020-09-26 23:04:29.843' AS DateTime), 0, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (22, N'anhwtuan@gmail.com', NULL, NULL, CAST(N'2020-09-26 23:07:26.020' AS DateTime), 0, 0, 4)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (23, N'anhwtuan@gmail.com', NULL, NULL, CAST(N'2020-09-26 23:08:58.573' AS DateTime), 0, 0, 4)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (24, N'anhwtuan@gmail.com', NULL, NULL, CAST(N'2020-09-26 23:11:45.607' AS DateTime), 0, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (25, N'anhwtuan@gmail.com', N'maxresdefault (1).jpg', N'test x3', CAST(N'2020-09-26 23:12:58.263' AS DateTime), 0, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (26, N'anhwtuan@gmail.com', N'maxresdefault (1).jpg', N'...', CAST(N'2020-09-26 23:15:28.173' AS DateTime), 0, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (27, N'anhwtuan@gmail.com', N'hqdefault.jpg', N'....', CAST(N'2020-09-26 23:17:48.893' AS DateTime), 1, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (28, N'anhwtuan@gmail.com', NULL, NULL, CAST(N'2020-09-26 23:34:37.220' AS DateTime), 0, 0, 4)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (29, N'anhwtuan@gmail.com', NULL, NULL, CAST(N'2020-09-26 23:38:25.397' AS DateTime), 0, 0, 4)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (30, N'anhwtuan@gmail.com', NULL, NULL, CAST(N'2020-09-26 23:42:09.157' AS DateTime), 0, 0, 4)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (31, N'anhwtuan@gmail.com', NULL, NULL, CAST(N'2020-09-26 23:43:12.733' AS DateTime), 0, 0, 4)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (32, N'anhwtuan@gmail.com', NULL, NULL, CAST(N'2020-09-26 23:48:28.267' AS DateTime), 0, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (33, N'anhwtuan@gmail.com', N'image-450w-766363144.jpg', NULL, CAST(N'2020-09-26 23:48:28.320' AS DateTime), 0, 1, 4)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (34, N'anhwtuan@gmail.com', NULL, NULL, CAST(N'2020-09-27 00:14:23.797' AS DateTime), 0, 0, 4)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (35, N'anhwtuan@gmail.com', N'image-450w-766363144.jpg', NULL, CAST(N'2020-09-27 00:14:23.810' AS DateTime), 0, 0, 4)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (36, N'anhwtuan@gmail.com', NULL, NULL, CAST(N'2020-09-27 00:23:43.070' AS DateTime), 0, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (37, N'anhwtuan@gmail.com', N'image-450w-766363144.jpg', N'image-450w-766363144.jpg', CAST(N'2020-09-27 00:23:43.077' AS DateTime), 0, 0, 4)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (38, N'anhwtuan@gmail.com', NULL, NULL, CAST(N'2020-09-27 00:25:57.220' AS DateTime), 0, 0, 4)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (39, N'anhwtuan@gmail.com', NULL, NULL, CAST(N'2020-09-27 00:31:10.607' AS DateTime), 0, 0, 4)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (40, N'anhwtuan@gmail.com', N'hqdefault.jpg', N'hqdefault.jpg', CAST(N'2020-09-27 00:31:10.610' AS DateTime), 0, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (41, N'anhwtuan@gmail.com', NULL, NULL, CAST(N'2020-09-27 00:32:16.213' AS DateTime), 0, 0, 4)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (42, N'anhwtuan@gmail.com', N'maxresdefault (1).jpg', N'maxresdefault (1).jpg', CAST(N'2020-09-27 00:32:16.220' AS DateTime), 0, 0, 4)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (43, N'anhwtuan@gmail.com', N'slider_puffin_jpegmini_mobile.jpg', N'ahhhh', CAST(N'2020-09-27 01:13:08.990' AS DateTime), 0, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (44, N'anhwtuan@gmail.com', N'slider_puffin_jpegmini_mobile.jpg', N'Again...', CAST(N'2020-09-27 01:13:56.417' AS DateTime), 0, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (45, N'anhwtuan@gmail.com', N'slider_puffin_jpegmini_mobile.jpg', N'again x2', CAST(N'2020-09-27 01:24:23.330' AS DateTime), 0, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (46, N'anhwtuan@gmail.com', N'slider_puffin_jpegmini_mobile.jpg', N'agains', CAST(N'2020-09-27 01:27:51.967' AS DateTime), 0, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (47, N'anhwtuan@gmail.com', N'slider_puffin_jpegmini_mobile.jpg', N'AgAiN', CAST(N'2020-09-27 01:31:08.710' AS DateTime), 0, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (48, N'anhwtuan@gmail.com', N'hqdefault.jpg', N'aGaIn', CAST(N'2020-09-27 01:43:39.400' AS DateTime), 2, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (49, N'anhwtuan@gmail.com', N'slider_puffin_jpegmini_mobile.jpg', N'Test', CAST(N'2020-09-27 01:50:06.377' AS DateTime), 1, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (50, N'anhwtuan@gmail.com', N'crop.jpg', N'Cool working....', CAST(N'2020-09-27 01:54:27.940' AS DateTime), 2, 0, 4)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (51, N'anhwtuan@gmail.com', N'PikachuTA-EWEATA-1024x768.jpg', N'Feeling sad', CAST(N'2020-09-27 01:59:03.047' AS DateTime), 1, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (52, N'anhwtuan@gmail.com', N'screen-6.jpg', N'I am the king!', CAST(N'2020-09-27 02:00:12.047' AS DateTime), 0, 1, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (53, N'anhwtuan@gmail.com', N'ong-xa-that-cool.jpg', N'WTF!!!?', CAST(N'2020-09-27 02:02:22.617' AS DateTime), 1, 0, 4)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (54, N'anhwtuan@gmail.com', N'', N'First post in the network.', CAST(N'2020-08-21 00:00:00.000' AS DateTime), 0, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (55, N'anhwtuan@gmail.com', N'', N'Second post in the network.', CAST(N'2020-08-22 00:00:00.000' AS DateTime), 0, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (56, N'anhwtuan@gmail.com', N'', N'First post in the network.', CAST(N'2020-08-21 00:00:00.000' AS DateTime), 0, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (57, N'anhwtuan@gmail.com', N'', N'Second post in the network.', CAST(N'2020-08-22 00:00:00.000' AS DateTime), 0, 0, 3)
INSERT [dbo].[post] ([postID], [email], [image], [description], [date], [numberOfLike], [numberOfDislike], [status]) VALUES (58, N'anhwtuan@gmail.com', N'PikachuTA-EWEATA-1024x768.jpg', N'Con m? nó ch?!!', CAST(N'2020-09-28 10:50:34.687' AS DateTime), 0, 0, 3)
SET IDENTITY_INSERT [dbo].[post] OFF
SET IDENTITY_INSERT [dbo].[status] ON 

INSERT [dbo].[status] ([statusID], [Name]) VALUES (1, N'New')
INSERT [dbo].[status] ([statusID], [Name]) VALUES (2, N'Active')
INSERT [dbo].[status] ([statusID], [Name]) VALUES (3, N'Alive')
INSERT [dbo].[status] ([statusID], [Name]) VALUES (4, N'Deleted')
INSERT [dbo].[status] ([statusID], [Name]) VALUES (5, N'Liked')
INSERT [dbo].[status] ([statusID], [Name]) VALUES (6, N'Disliked')
INSERT [dbo].[status] ([statusID], [Name]) VALUES (15, N'Nothing')
SET IDENTITY_INSERT [dbo].[status] OFF
INSERT [dbo].[user] ([firstname], [lastname], [email], [password], [status], [unreadNotification]) VALUES (N'Anh', N'Nguyen', N'anhwtuan@gmail.com', N'49ab638866aef3ed2474277d020227ab7d5ea9fcf1b267f07d0a68d3db9fc2a0', 2, 0)
INSERT [dbo].[user] ([firstname], [lastname], [email], [password], [status], [unreadNotification]) VALUES (N'Em', N'Laai', N'anhztuan590@gmail.com', N'3b7f85d06d8d6c21e144bda3f9826271da2c2b3a9ef685c13c525adfa0621d70', 2, 0)
ALTER TABLE [dbo].[comment]  WITH CHECK ADD FOREIGN KEY([email])
REFERENCES [dbo].[user] ([email])
GO
ALTER TABLE [dbo].[comment]  WITH CHECK ADD FOREIGN KEY([postID])
REFERENCES [dbo].[post] ([postID])
GO
ALTER TABLE [dbo].[comment]  WITH CHECK ADD FOREIGN KEY([status])
REFERENCES [dbo].[status] ([statusID])
GO
ALTER TABLE [dbo].[emotion]  WITH CHECK ADD FOREIGN KEY([email])
REFERENCES [dbo].[user] ([email])
GO
ALTER TABLE [dbo].[emotion]  WITH CHECK ADD FOREIGN KEY([postID])
REFERENCES [dbo].[post] ([postID])
GO
ALTER TABLE [dbo].[emotion]  WITH CHECK ADD FOREIGN KEY([status])
REFERENCES [dbo].[status] ([statusID])
GO
ALTER TABLE [dbo].[notification]  WITH CHECK ADD FOREIGN KEY([email])
REFERENCES [dbo].[user] ([email])
GO
ALTER TABLE [dbo].[notification]  WITH CHECK ADD FOREIGN KEY([postID])
REFERENCES [dbo].[post] ([postID])
GO
ALTER TABLE [dbo].[otp]  WITH CHECK ADD FOREIGN KEY([email])
REFERENCES [dbo].[user] ([email])
GO
ALTER TABLE [dbo].[post]  WITH CHECK ADD FOREIGN KEY([email])
REFERENCES [dbo].[user] ([email])
GO
ALTER TABLE [dbo].[post]  WITH CHECK ADD FOREIGN KEY([status])
REFERENCES [dbo].[status] ([statusID])
GO
ALTER TABLE [dbo].[user]  WITH CHECK ADD FOREIGN KEY([status])
REFERENCES [dbo].[status] ([statusID])
GO
USE [master]
GO
ALTER DATABASE [SocialNetwork] SET  READ_WRITE 
GO
