BACKUP DATABASE [AkirasBoutiques] TO  DISK = N'D:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\Backup\AkirasBoutiques.bak' WITH NOFORMAT, NOINIT,  NAME = N'AkirasBoutiques-Completa Base de datos Copia de seguridad', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=N'AkirasBoutiques' and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name=N'AkirasBoutiques' )
if @backupSetId is null begin raiserror(N'Error de comprobación. No se encontró la información de copia de seguridad de la base de datos ''AkirasBoutiques''.', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N'D:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\Backup\AkirasBoutiques.bak' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO
