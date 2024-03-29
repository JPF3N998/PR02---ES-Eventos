USE ESEventosOnline
GO

DROP PROC IF EXISTS spBuscarRegistro
GO
SET NOCOUNT ON
GO
/*
	PROC con parametro modo, para cubrir usuarios y recursos
	Retorna una fila con el usuario o recurso buscado
	----> MODES
	1 = usuarios
	2 = recursos
*/
CREATE PROC spBuscarRegistro @input CHAR(50), @mode INT, @existe BIT OUTPUT AS
	BEGIN
			IF @mode = 1 /* Busqueda de usuario */
				BEGIN
					DECLARE @usuario CHAR(50)= (SELECT username FROM Usuario WHERE username = @input);
					IF  @usuario IS NOT NULL
						BEGIN
							PRINT('Existe usuario: ' + @input);
							SET @existe = 0
							RETURN 0;
						END
					ELSE
						BEGIN
							SET @existe = 1;
							PRINT('No existe usuario: ' + @input);
							(SELECT * FROM Usuario U WHERE @input = U.id);
							RETURN 0;
						END
				END
			ELSE IF @mode = 2 /* Busqueda de recurso*/ 
				BEGIN
					DECLARE @recurso INT= (SELECT id FROM Recurso WHERE id = CONVERT(INT,@input));
					IF @recurso IS NULL
						BEGIN
							PRINT('No existe recurso: ' + @input);
							SET @existe = 0
							RETURN -1
						END
					ELSE
						BEGIN
							PRINT('Existe el recurso: ' + @input);
							SET @existe = 1
							(SELECT * FROM Recurso R WHERE CONVERT(INT,@input) = R.id);
							RETURN 0;
						END
				END
			ELSE
				SET @existe = 0
				return -1;
	END
GO

DROP PROC IF EXISTS spBuscarPaquete
GO

/*
	Busca un paquete con el ID de recurso y la llave primaria del paquete a buscar
	Retorna: Fila con el paquete especificado
*/
CREATE PROC spBuscarPaquete @idPaqueteInput INT,@existePaqueteInput BIT OUTPUT AS 
	BEGIN
		DECLARE @paquete INT = (SELECT P.id FROM Paquete P WHERE @idPaqueteInput = P.id);
		IF @paquete IS NULL
			BEGIN
				PRINT('Paquete '+ CONVERT(NVARCHAR(50),@idPaqueteInput) +' no existe.')
				RETURN -1
			END
		ELSE
			BEGIN
				PRINT('Paquete '+ CONVERT(VARCHAR(50),@paquete)+ ' existe.')
				SET @existePaqueteInput = 1;
				SELECT * FROM Paquete P WHERE @idPaqueteInput = P.id
			END
	END
GO

DROP PROC IF EXISTS spBuscarProducto
GO
/*
	Busca un producto con el ID de recurso, numero de paquete y numero de producto (todos a traves de llave primaria)
	Retorna: Fila con el producto especificado
*/

CREATE PROC spBuscarProducto @idProductoInput INT,@existeProducto INT OUTPUT AS
	BEGIN
		DECLARE @producto INT = (SELECT P.id FROM Producto P WHERE P.id=@idProductoInput);
		IF @producto IS NULL
			BEGIN
				PRINT('Producto no existe.')
				SET @existeProducto = 0;
				RETURN -1;
			END
		ELSE
			BEGIN
				PRINT('Producto ' + CONVERT(VARCHAR(50),@producto) + ' existe.')
				SET @existeProducto = 1;
				(SELECT * FROM Producto P WHERE @idProductoInput=P.id);
				RETURN 0;
			END
	END
GO

/* PROC para el login */
DROP PROC IF EXISTS spLogin
GO

CREATE PROC spLogin @nombreUsuarioInput char(50), @passwordInput char(50) AS
	BEGIN
		DECLARE @isAdmin INT;
		IF(EXISTS(SELECT * FROM dbo.Usuario AS U WHERE U.username = @nombreUsuarioInput))
			BEGIN
			DECLARE @pass char(50) = (SELECT U.password FROM dbo.Usuario AS U WHERE U.username = @nombreUsuarioInput);
			IF(@passwordInput = @pass)
				BEGIN
					IF((SELECT U.admin FROM dbo.Usuario AS U WHERE U.username = @nombreUsuarioInput) = 1)
						BEGIN
						SET @isAdmin = 1;
						RETURN @isAdmin;
						END
					ELSE
						BEGIN
						SET @isAdmin = 0;
						RETURN @isAdmin;
						END
				END
			ELSE
				BEGIN
				SET @isAdmin = -1;
				RETURN @isAdmin;
				END
			END
		ELSE
			SET @isAdmin = -1;
			RETURN @isAdmin;

	END
GO

DROP PROC IF EXISTS spVerHistorialAdmin
GO

CREATE PROC spVerHistorialAdmin @idRecurso INT AS
	BEGIN
		SELECT Re.nombre as [Recurso],Re.correo,Re.telefono,Re.provincia,F.idCliente AS [ID Cliente],R.fecha AS [Fecha],R.horaInicio AS [Hora Inicio],R.horaFin AS [Hora Fin],F.idReservacion AS [ID Reservacion],R.idPaquete AS [Paquete],R.precioTotal AS [Monto] FROM Factura F JOIN (Reservacion R JOIN (Paquete P JOIN Recurso Re ON P.idRecurso = Re.id) ON R.idPaquete = P.id) ON F.idReservacion = R.id
	END
GO
DROP PROC IF EXISTS spGetPrecioDelPaquete
GO

CREATE PROC spGetPrecioDelPaquete @idPaquete INT,@precio FLOAT OUTPUT AS
	BEGIN
		IF EXISTS (SELECT P.id FROM Paquete P WHERE P.id = @idPaquete)
			BEGIN
				SET @precio = (SELECT SUM(P.precio) FROM Producto P WHERE P.idPaquete = @idPaquete)
				PRINT('Precio del paquete: '+CONVERT(NVARCHAR(50),@precio))
				RETURN 0
			END
		ELSE
			BEGIN
				PRINT('Paquete '+CONVERT(NVARCHAR(50),@idPaquete)+' no existe')
				RETURN -1
			END
	END
GO
DROP PROC IF EXISTS spGetIDFromUsername
GO
/*Devuelve en la variable output la llave primaria con el username como input*/
CREATE PROC spGetIDFromUsername @usernameInput VARCHAR(50),@idUsuario INT OUTPUT AS
	BEGIN
		SET @idUsuario = (SELECT U.id FROM Usuario U WHERE U.username = @idUsuario );
	END
GO

DROP PROC IF EXISTS spVerHistorialCliente
GO

CREATE PROC spVerHistorialCliente @username NVARCHAR(50) AS
	BEGIN
		DECLARE @idCliente INT;
		EXEC spGetIDFromUsername @username,@idCliente OUTPUT;
		SELECT F.id as [ID Factura],R.idPaquete as [ID Paquete],Re.nombre as [Recurso],R.fecha AS [Fecha],R.horaInicio AS [Hora Inicio],R.horaFin AS [Hora Fin],R.precioTotal AS [Precio] FROM Factura F JOIN (Reservacion R JOIN (Paquete P JOIN Recurso Re ON Re.id=P.idRecurso) ON R.idPaquete = P.id) ON F.idReservacion = R.id WHERE F.idCliente=@idCliente 
	END
GO

DROP PROC IF EXISTS spGetRecursos
GO

CREATE PROC spGetRecursos AS
	BEGIN
		SELECT R.nombre as [Nombre de recurso] FROM Recurso R
	END
GO

DROP PROC IF EXISTS spGetPaquetes
GO

CREATE PROC spGetPaquetes AS
	BEGIN
		SELECT Pr.idPaquete, SUM(Pr.precio) AS [Precio] FROM (Paquete P JOIN Producto Pr ON P.id=Pr.idPaquete) GROUP BY Pr.idPaquete 
	END
GO

DROP PROC IF EXISTS spEliminarRecurso
GO

CREATE PROC spEliminarRecurso @nombreRecurso NVARCHAR(50) AS
	BEGIN
		DECLARE @idRecurso INT = (SELECT R.id FROM Recurso R WHERE R.nombre = @nombreRecurso)
		IF @idRecurso IS NOT NULL
			BEGIN
				
				DECLARE @tempP TABLE(idRecurso INT,nombreRecurso NVARCHAR(50), idPaquete INT, idProducto INT, nombre NVARCHAR(50),precio FLOAT,idReservacion INT,idFactura INT)
				INSERT INTO @tempP
				SELECT R.id,R.nombre,P.id,Pr.id,Pr.nombre,Pr.precio,R.id,F.id FROM Recurso R
				JOIN (Paquete P
				JOIN Producto Pr ON P.id=Pr.idPaquete
				LEFT JOIN (Reservacion Re JOIN Factura F ON F.idReservacion = Re.id) ON P.id=Re.idPaquete) ON R.id = P.idRecurso
				WHERE R.id = @idRecurso
				--SELECT * FROM @tempP
				
				BEGIN TRY
					SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
					BEGIN TRANSACTION
						DELETE FROM Factura WHERE Factura.id = (SELECT TP.idFactura FROM @tempP TP WHERE TP.idFactura = Factura.id GROUP BY idFactura)
						PRINT('Facturas: done')
						DELETE FROM Producto WHERE Producto.id = (SELECT TP.idProducto FROM @tempP TP WHERE Producto.id=TP.idProducto GROUP BY idProducto);
						PRINT('Productos: done')
						DELETE FROM Reservacion WHERE Reservacion.idPaquete = (SELECT TP.idPaquete FROM @tempP TP WHERE Reservacion.idPaquete = TP.idPaquete GROUP BY TP.idPaquete);
						PRINT('Reservaciones: done')
						DELETE FROM Paquete WHERE Paquete.idRecurso = @idRecurso 
						PRINT('Paquetes: done')
						DELETE FROM Recurso WHERE Recurso.id = @idRecurso;
						PRINT('Recurso: done')
					COMMIT
					PRINT('Recurso '+@nombreRecurso+ ' eliminado')
					RETURN 0
				END TRY
				BEGIN CATCH
					DECLARE @error NVARCHAR(200)= (SELECT 'Line '+CONVERT(NVARCHAR(100),ERROR_LINE())+' '+ERROR_MESSAGE() ) 
					ROLLBACK
					PRINT('Error: '+@error)
				END CATCH
			END
		ELSE
			BEGIN
				PRINT('Recurso '+@nombreRecurso+' no existe');
				RETURN -1
			END
	END
GO

DROP PROC IF EXISTS spEliminarPaquete
GO

/* Eliminar el paquete deseado pero con su numero de paquete del recurso, no su llave primaria */
CREATE PROC spEliminarPaquete @idPaquete INT AS
	BEGIN
		DECLARE @nombreRecurso NVARCHAR(50) = (SELECT R.nombre FROM Paquete P JOIN Recurso R ON P.idRecurso=R.id WHERE P.id = @idPaquete)
		DECLARE @existePaquete BIT;
		EXEC spBuscarPaquete @idPaquete,@existePaquete OUTPUT;
		IF	@existePaquete = 1
			BEGIN TRY
				SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				BEGIN TRANSACTION
					DELETE FROM Factura WHERE Factura.idReservacion = (SELECT F.idReservacion FROM Factura F JOIN Reservacion R ON R.id=F.idReservacion WHERE R.idPaquete = @idPaquete GROUP BY F.idReservacion)
					PRINT('Factura... Done')
					DELETE FROM Reservacion WHERE Reservacion.id = (SELECT R.id FROM Reservacion R WHERE R.idPaquete = @idPaquete)
					PRINT('Reservacion... Done')
					DELETE FROM Producto WHERE Producto.idPaquete = @idPaquete 
					PRINT('Producto... Done')
					DELETE FROM Paquete WHERE Paquete.id = @idPaquete
					PRINT('Paquete... Done')
				COMMIT
				--PRINT('Eliminado paquete '+ @idPaquete + ' del recurso ' +@nombreRecurso);
				RETURN 0;
			END TRY
			BEGIN CATCH
				ROLLBACK
				RETURN -2;
			END CATCH
		ELSE
			BEGIN
				RETURN -1
			END
	END
GO

DROP PROC IF EXISTS spEliminarProducto
GO

CREATE PROC spEliminarProducto @nombreProducto NVARCHAR(50) AS
	BEGIN
		DECLARE @idProducto INT = (SELECT Pr.id FROM Producto Pr WHERE Pr.nombre = @nombreProducto);
		IF @idProducto IS NOT NULL
			BEGIN
				DECLARE @idPaquete INT = (SELECT P.id FROM Paquete P JOIN Producto Pr ON P.id = Pr.idPaquete WHERE Pr.id = @idProducto);
				DECLARE @newPrice FLOAT;
				EXEC spGetPrecioDelPaquete @idPaquete,@newPrice OUTPUT;
				SET @newPrice = @newPrice - (SELECT Pr.precio FROM Producto Pr WHERE Pr.id = @idProducto)
				SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				BEGIN TRANSACTION

					DELETE FROM Producto WHERE @idProducto = Producto.id
					UPDATE Reservacion
						SET Reservacion.precioTotal = @newPrice WHERE Reservacion.idPaquete = @idPaquete
			
				COMMIT
				RETURN 0
			END
		ELSE
			BEGIN
				PRINT('No existe el producto '+ @nombreProducto)
				RETURN -1
			END
	END
GO
DROP PROC IF EXISTS spAgregarRecurso
GO

CREATE PROC spAgregarRecurso @nombreRecurso NVARCHAR(50),@correoRecurso NVARCHAR(50),@telefonoRecurso NVARCHAR(50),@provinciaRecurso NVARCHAR(50) AS
	BEGIN
		BEGIN TRY
			IF EXISTS (SELECT R.nombre FROM Recurso R WHERE R.nombre=@nombreRecurso)
				BEGIN
					PRINT('Recurso ' +@nombreRecurso+' ya existe.');
					RETURN -2;
				END
			ELSE
				BEGIN
					
					SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
					BEGIN TRANSACTION
						INSERT INTO Recurso(nombre,correo,telefono,provincia)
						VALUES(@nombreRecurso,@correoRecurso,@telefonoRecurso,@provinciaRecurso)
					COMMIT
					PRINT('Recurso nuevo '+@nombreRecurso+' agregado exitosamente')
					RETURN 0/*Codigo de exito*/
				END
		END TRY
		BEGIN CATCH
			RETURN -1
		END CATCH
	END
GO

DROP PROC IF EXISTS spAgregarPaquete
GO

CREATE PROC spAgregarPaquete @nombreRecurso NVARCHAR(50) AS
	BEGIN
		DECLARE @idRecurso INT=(SELECT R.id FROM Recurso R WHERE R.nombre = @nombreRecurso);
		IF @idRecurso IS NOT NULL
			BEGIN
				SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				BEGIN TRANSACTION
					INSERT INTO Paquete(idRecurso)
					VALUES (@idRecurso)
				COMMIT
				RETURN (SELECT max(id) FROM Paquete P);
			END
		ELSE
			BEGIN
				RETURN -1
			END
	END
GO

DROP PROC IF EXISTS spAgregarProducto
GO

CREATE PROC spAgregarProducto @idPaquete INT,@nombreProducto NVARCHAR(50),@precioProducto FLOAT AS
	BEGIN
		DECLARE @existePaquete BIT;
		EXEC spBuscarPaquete @idPaquete,@existePaquete OUTPUT;
		IF @existePaquete = 1
			BEGIN
				DECLARE @existeNombre NVARCHAR(50) = (SELECT P.nombre FROM Producto P WHERE P.nombre=@nombreProducto AND P.idPaquete=@idPaquete);
				IF @existeNombre IS NULL
					BEGIN
					SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
					BEGIN TRANSACTION
						INSERT INTO Producto(idPaquete,nombre,precio)
						VALUES(@idPaquete,@nombreProducto,@precioProducto)
					COMMIT
					PRINT('Agregando '+@nombreProducto+ ' en el paquete '+CONVERT(NVARCHAR(50),@idPaquete));
					END
				ELSE
					BEGIN
						PRINT('Producto '+@nombreProducto+' ya existe en el paquete')
						RETURN -2;
					END
				END
		ELSE
			BEGIN
				RETURN -1
			END
	END
GO


DROP PROC IF EXISTS spAgregarCliente 
GO 
 
CREATE PROC spAgregarCliente @nombreIn nvarchar(50), @cedulaIn int, @emailIn nvarchar(50), @userNameIn nvarchar(50), @passwordIn nvarchar(50) AS 
BEGIN 
	DECLARE @result int; 
	BEGIN TRY 
		if Exists(SELECT * FROM dbo.Usuario AS U WHERE U.username = @userNameIn) 
			BEGIN 
			PRINT('Usuario '+@userNameIn+' ya existe.')
			SET @result = -1; 
			RETURN @result; 
			END 
		IF @@TRANCOUNT = 0 
			BEGIN 
			SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
			BEGIN TRANSACTION 
			END 
		INSERT INTO dbo.Usuario	VALUES (@nombreIn, @cedulaIn, @emailIn, @userNameIn, @passwordIn, 0); 
		IF @@TRANCOUNT > 0 
			COMMIT; 
		SET @result = 1; 
		RETURN @result; 
	END TRY 
	BEGIN CATCH 
		IF @@TRANCOUNT > 0 
			ROLLBACK; 
		SET @result = -1; 
		RETURN @result; 
	END CATCH 
END 
GO

DROP PROC IF EXISTS spAgregarAdmin
GO 
 
CREATE PROC spAgregarAdmin @nombreIn nvarchar(50), @cedulaIn int, @emailIn nvarchar(50), @userNameIn nvarchar(50), @passwordIn nvarchar(50) AS 
BEGIN 
	DECLARE @result int; 
	BEGIN TRY 
		if Exists(SELECT * FROM dbo.Usuario AS U WHERE U.username = @userNameIn) 
			BEGIN 
			PRINT('Usuario '+@userNameIn+' ya existe.')
			SET @result = -1; 
			RETURN @result; 
			END 
		IF @@TRANCOUNT = 0 
			BEGIN 
			SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
			BEGIN TRANSACTION 
			END 
		INSERT INTO dbo.Usuario	VALUES (@nombreIn, @cedulaIn, @emailIn, @userNameIn, @passwordIn, 1); 
		IF @@TRANCOUNT > 0 
			COMMIT; 
		SET @result = 1; 
		RETURN @result; 
	END TRY 
	BEGIN CATCH 
		IF @@TRANCOUNT > 0 
			ROLLBACK; 
		SET @result = -1; 
		RETURN @result; 
	END CATCH 
END 
GO

DROP PROC IF EXISTS spReservar
GO
/*Se usa el username para la reservacion del paquete*/
CREATE PROC spReservar @usuario NVARCHAR(50),@idPaquete INT,@fecha NVARCHAR(50),@horaInicio NVARCHAR(20),@horaFin NVARCHAR(20),@exito BIT OUTPUT AS
	BEGIN
		DECLARE @idCliente INT = (SELECT U.id FROM Usuario U WHERE U.username = @usuario);
		IF @idCliente IS NULL
			BEGIN
				PRINT('Cliente no pudo ser encontrado')
				SET @exito = -1;
				RETURN -1;
			END
		ELSE
			
			IF EXISTS (SELECT P.id FROM Paquete P WHERE P.id = @idPaquete)
				BEGIN
					BEGIN
						/*Conversion de entradas a sus tipos de dato respectivos*/
						DECLARE @fechaDATE DATE = CONVERT(DATE,@fecha,103)
						DECLARE @horaInicioTIME TIME= CONVERT(TIME,@horaInicio,108)
						DECLARE @horaFinTIME TIME = CONVERT(TIME,@horaFin,108)
						/*Chequeo de choque de horarios*/
						DECLARE @horariosDelPaquete TABLE(idPaquete INT,fecha DATE, horaInicio TIME(0),horaFin TIME(0));
						/*Tabla temporal donde se encuentran todas las reservaciones del paquete en ese dia*/
						INSERT INTO @horariosDelPaquete
						SELECT P.id,R.fecha,R.horaInicio,R.horaFin FROM Paquete P JOIN Reservacion R ON P.id = R.idPaquete
						WHERE @idPaquete = P.id AND R.fecha = @fechaDATE
						AND ((R.horaInicio <= @horaInicioTIME AND R.horaInicio <= R.horaFin) OR (R.horaInicio <= @horaFinTIME AND R.horaFin <= @horaFinTIME))
				
						IF EXISTS (SELECT * FROM @horariosDelPaquete)
							BEGIN
								PRINT('Hay choque de horarios');
								SET @exito = -1;
								RETURN -2
							END
						ELSE
							BEGIN TRY
								DECLARE @precioDeLaReservacion FLOAT;
								EXEC spGetPrecioDelPaquete @idPaquete,@precioDeLaReservacion OUTPUT;
								SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
								BEGIN TRANSACTION
									INSERT INTO Reservacion(idCliente,idPaquete,fecha,horaInicio,horaFin,precioTotal)
									VALUES (@idCliente,@idPaquete,@fechaDATE,@horaInicioTIME,@horaFinTIME,@precioDeLaReservacion)
									INSERT INTO Factura(idCliente,idReservacion)
									VALUES (@idCliente,(SELECT max(id) FROM Reservacion))
								COMMIT
								PRINT('Reservacion establecida')
								SET @exito = 0;
								RETURN 0;
							END TRY
							BEGIN CATCH
								PRINT('Error en la transaccion a la hora de registrar reservacion');
								SET @exito = -1;
								RETURN -1;
							END CATCH
					END
				END
			ELSE
				BEGIN
					PRINT('Paquete '+ CONVERT(NVARCHAR(50),@idPaquete) +' no existe')
					RETURN -1
				END
	END
GO

/*
SELECT * FROM Paquete
SELECT * FROM Reservacion
SELECT * FROM Factura
DECLARE @bit BIT;
EXEC spReservar 'feng','11','30/09/2019','8:00','21:00',@bit
print(@bit)
*/
DROP PROC IF EXISTS spVerReservaciones
GO

CREATE PROC spVerReservaciones @username NVARCHAR(50) AS
	BEGIN
		DECLARE @idCliente INT = (SELECT U.id FROM Usuario U WHERE U.username = @username)
		IF @idCliente IS NOT NULL
			BEGIN
				DECLARE @admin BIT = (SELECT U.admin FROM Usuario U WHERE @idCliente = U.id);
				IF @admin = 1
					BEGIN
						PRINT('Es admin')
						SELECT R.id as [ID Reservacion],R.idPaquete AS [ID Paquete],Re.nombre as [Recurso], CONVERT(NVARCHAR(12),R.fecha) as [Fecha de reservacion],R.horaInicio AS [Hora de inicio],R.horaFin AS [Hora de fin],R.precioTotal FROM Reservacion R JOIN (Paquete P JOIN Recurso Re ON P.idRecurso = Re.id) ON P.id = R.idPaquete ORDER BY P.idRecurso
					END
				ELSE
					BEGIN
						SELECT R.id as [ID Reservacion],R.idPaquete AS [ID Paquete],Re.nombre as [Recurso], CONVERT(NVARCHAR(12),R.fecha) as [Fecha de reservacion],R.horaInicio AS [Hora de inicio],R.horaFin AS [Hora de fin],R.precioTotal FROM Reservacion R JOIN (Paquete P JOIN Recurso Re ON P.idRecurso = Re.id) ON P.id = R.idPaquete WHERE R.idCliente = @idCliente ORDER BY P.idRecurso
					END
				END
		ELSE
			BEGIN
				PRINT('Usuario '+ @username + ' no existe')
				RETURN -1
			END
	END
GO

DROP PROC IF EXISTS spFiltrarReservaciones
GO

CREATE PROC spFiltrarReservaciones @username NVARCHAR(50),@nombreRecurso NVARCHAR(50) AS
	BEGIN
		DECLARE @idCliente INT = (SELECT U.id FROM Usuario U WHERE U.username = @username)
		IF @idCliente IS NOT NULL
			BEGIN
				DECLARE @admin BIT = (SELECT U.admin FROM Usuario U WHERE @idCliente = U.id);
				IF @admin = 1
					BEGIN
						PRINT('Es admin')
						SELECT R.id as [ID Reservacion],Re.nombre as [Nombre del recurso],R.idPaquete AS [ID Paquete], CONVERT(NVARCHAR(12),R.fecha) as [Fecha de reservacion],R.horaInicio AS [Hora de inicio],R.horaFin AS [Hora de fin],R.precioTotal FROM Reservacion R JOIN (Paquete P JOIN Recurso Re ON P.idRecurso = Re.id) ON P.id = R.idPaquete WHERE R.idCliente = @idCliente AND Re.nombre LIKE @nombreRecurso ORDER BY P.idRecurso
					END
				ELSE
					BEGIN
						SELECT R.id as [ID Reservacion],Re.nombre as [Nombre del recurso],R.idPaquete AS [ID Paquete], CONVERT(NVARCHAR(12),R.fecha) as [Fecha de reservacion],R.horaInicio AS [Hora de inicio],R.horaFin AS [Hora de fin],R.precioTotal FROM Reservacion R JOIN (Paquete P JOIN Recurso Re ON P.idRecurso = Re.id) ON P.id = R.idPaquete WHERE R.idCliente = @idCliente AND Re.nombre LIKE @nombreRecurso ORDER BY P.idRecurso
					END
				END
		ELSE
			BEGIN
				PRINT('Usuario '+ @username + ' no existe')
				RETURN -1
			END
	END
GO

DROP PROC IF EXISTS spVerFacturas
GO

CREATE PROC spVerFacturas @username NVARCHAR(50) AS
	BEGIN
		DECLARE @idCliente INT = (SELECT U.id FROM Usuario U WHERE U.username = @username)
		IF @idCliente IS NOT NULL
			BEGIN
				DECLARE @admin BIT = (SELECT U.admin FROM Usuario U WHERE @idCliente = U.id);
				IF @admin = 1
					BEGIN
						PRINT('Es admin')
						SELECT F.id as [ID de Factura],F.idCliente as [ID Cliente],F.idReservacion AS [ID Reservacion],CONVERT(NVARCHAR(12),R.fecha) as [Fecha de reservacion],R.horaInicio AS [Hora de inicio],R.horaFin AS [Hora de fin] FROM Factura F JOIN Reservacion R ON R.id = F.idReservacion
					END
				ELSE
					BEGIN
						SELECT F.id as [ID de Factura],F.idCliente as [ID Cliente],F.idReservacion AS [ID Reservacion],CONVERT(NVARCHAR(12),R.fecha) as [Fecha de reservacion],R.horaInicio AS [Hora de inicio],R.horaFin AS [Hora de fin] FROM Factura F JOIN Reservacion R ON R.id = F.idReservacion  WHERE F.idCliente = @idCliente
					END
				END
		ELSE
			BEGIN
				PRINT('Usuario '+ @username + ' no existe')
				RETURN -1
			END
	END
GO

DROP PROC IF EXISTS spCancelarReservacion
GO

CREATE PROC spCancelarReservacion @username NVARCHAR(50),@idReservacion INT AS
	BEGIN
		DECLARE @idCliente INT = (SELECT U.id FROM Usuario U WHERE U.username = @username);
		IF @idCliente IS NOT NULL
			BEGIN
				IF EXISTS (SELECT R.id FROM Reservacion R WHERE @idReservacion = R.id)
					BEGIN
						IF EXISTS (SELECT R.id FROM Reservacion R WHERE R.id = @idReservacion)
							BEGIN
								DECLARE @diaReservacion DATE = (SELECT R.fecha FROM Reservacion R WHERE R.id = @idReservacion) 
								IF DATEDIFF(DAY,GETDATE(),@diaReservacion) < 7
									BEGIN
										PRINT('No se puede cancelar la reservacion, ya que hace falta menos de una semana')
										RETURN -2
									END
								ELSE
									BEGIN
										BEGIN TRY
											DECLARE @precioDeLaReservacion FLOAT;
											DECLARE @idPaquete INT = (SELECT R.idPaquete FROM Reservacion R WHERE R.id = @idReservacion)
											EXEC spGetPrecioDelPaquete @idPaquete,@precioDeLaReservacion OUTPUT;
											SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
											BEGIN TRANSACTION
												DELETE FROM Factura WHERE Factura.idReservacion = @idReservacion
												DELETE FROM Reservacion WHERE Reservacion.id = @idReservacion

											COMMIT
											RETURN 0
										END TRY
										BEGIN CATCH
											PRINT('Error en la cancelacion de la reservacion numero '+ CONVERT(NVARCHAR(50),@idReservacion))
											declare @error int, @message varchar(4000), @xstate int;
											select @error = ERROR_NUMBER(), @message = ERROR_MESSAGE(), @xstate = XACT_STATE();
											raiserror ('Cancelacion de la reservacion: %d: %s', 16, 1, @error, @message) ;
											ROLLBACK
											RETURN -1
										END CATCH
									END
								END
						ELSE
							BEGIN
								PRINT('Reservacion numero: ' +@idReservacion+ ' no existe')
								RETURN -1
							END
						END
				ELSE
					BEGIN
						PRINT('No existe la reservacion con numero: '+CONVERT(NVARCHAR(50),@idReservacion))
						RETURN -1
					END
			END
		ELSE
			BEGIN
				PRINT('Cliente '+@username+' no existe')
				RETURN -1
			END
	END
GO

/*EXEC spCancelarReservacion 'feng',1*/


/*
EXEC spReservar 'admin',2,'20/05/2019','7:00','22:00'
*/



/*
SELECT * FROM Recurso
SELECT * FROM Paquete
SELECT * FROM Producto

EXEC spEliminarRecurso 5
EXEC spEliminarPaquete 11
EXEC spEliminarProducto 6
*/
/*
exec spAgregarRecurso 'Decoracion','reposteria@correo.com','12345678','Heredia'
exec spAgregarRecurso 'Reposteria','reposteria@correo.com','12345678','Heredia'
exec spAgregarRecurso 'Miscelaneos','misc@correo.com','12345678','Limon'
exec spAgregarPaquete '6'
exec spAgregarProducto 6,13,'Limpieza',1200
exec spAgregarProducto 6,13,'Pintura',1200exec spAgregarProducto 6,13,'Seguridad',1200

*/