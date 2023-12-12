CREATE DATABASE Spotify_ss1 ON
( 
 NAME = Spotify, 
 FILENAME ='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Spotify_Data1.ss'  
)
AS
SNAPSHOT OF Spotify
GO