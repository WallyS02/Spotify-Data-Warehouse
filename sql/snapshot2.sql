CREATE DATABASE Spotify_ss2 ON
( 
 NAME = Spotify, 
 FILENAME ='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Spotify_Data2.ss'  
)
AS
SNAPSHOT OF Spotify
GO