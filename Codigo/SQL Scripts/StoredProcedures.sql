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

CREATE PROC spLogin @nombreUsuarioInput char(50), @passwordInput char(50),@adminBIT BIT OUTPUT AS
	BEGIN
		DECLARE @existeUsuario BIT;
		EXEC spBuscarRegistro @input = @nombreUsuarioInput,@mode = 1,@existe = @existeUsuario OUTPUT;
		IF (@existeUsuario = 1) /* Revisa existencia de usuario */
			BEGIN
				DECLARE @foundPassword CHAR(50)= (SELECT U.password FROM Usuario U WHERE @nombreUsuarioInput=U.username);
				DECLARE @isAdmin BIT = (SELECT U.admin FROM Usuario U WHERE U.username = @nombreUsuarioInput); 
				IF (@foundPassword=@passwordInput) /* Revisa si la contrasenna es la correcta */
					BEGIN
						IF @isAdmin = 1 /*Es administrador*/
							BEGIN
								SET @adminBIT = 1;
								RETURN 1 /*1 para admin*/
							END
						ELSE
							BEGIN
								SET @adminBit = 0;
								RETURN 2; /*2 para cliente*/
							END
						
					END
				ELSE
					BEGIN
						RETURN 0;
					END
			END
		ELSE
			BEGIN
				RETURN 0;
			END
	END
GO

DROP PROC IF EXISTS spVerHistorialAdmin
GO

CREATE PROC spVerHistorialAdmin @idRecurso INT AS
	BEGIN
		SELECT Re.nombre as [Recurso],Re.correo,Re.telefono,Re.provincia,F.idCliente AS [ID Cliente],F.fechaInicio AS [Fecha Inicio],F.fechaFin AS [Fecha Fin],F.horaInicio AS [Hora Inicio],F.horaFin AS [Hora Fin],F.idReservacion AS [ID Reservacion],R.idPaquete AS [Paquete],F.precioTotal AS [Monto] FROM Factura F JOIN (Reservacion R JOIN (Paquete P JOIN Recurso Re ON P.idRecurso = Re.id) ON R.idPaquete = P.id) ON F.idReservacion = R.id
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
		SELECT Re.nombre as [Recurso],Re.correo,Re.telefono,Re.provincia,F.idCliente AS [ID Cliente],F.fechaInicio AS [Fecha Inicio],F.fechaFin AS [Fecha Fin],F.horaInicio AS [Hora Inicio],F.horaFin AS [Hora Fin],F.idReservacion AS [ID Reservacion],R.idPaquete AS [Paquete],F.precioTotal AS [Monto] FROM Factura F JOIN (Reservacion R JOIN (Paquete P JOIN Recurso Re ON P.idRecurso = Re.id) ON R.idPaquete = P.id) ON F.idReservacion = R.id WHERE F.idCliente=@idCliente;
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

CREATE PROC spGetPaquetes @idRecurso INT AS
	BEGIN
		DECLARE @existeRecurso BIT;
		EXEC spBuscarRegistro @input=@idRecurso,@mode= 2,@existe = @existeRecurso;
		IF @existeRecurso = 1
			BEGIN
				SELECT P.id as [Paquete] FROM Paquete P WHERE @idRecurso = P.idRecurso
			END
	END
GO

DROP PROC IF EXISTS spAgregarRecurso
GO

DROP PROC IF EXISTS spEliminarRecurso
GO

CREATE PROC spEliminarRecurso @idRecurso INT AS
	BEGIN
		DECLARE @existeRecurso BIT;
		EXEC spBuscarRegistro @input = @idRecurso,@mode = 2, @existe = @existeRecurso OUTPUT;
		IF @existeRecurso = 1
			BEGIN
				DECLARE @nombreRecurso NVARCHAR(50) = (SELECT R.nombre FROM Recurso R WHERE R.id = @idRecurso)
				PRINT('Eliminando recurso: ' + @nombreRecurso)
				
				DECLARE @tempP TABLE(idRecurso INT,nombreRecurso NVARCHAR(50), idPaquete INT, idProducto INT, nombre NVARCHAR(50),precio FLOAT)
				
				INSERT INTO @tempP(idRecurso,nombreRecurso,idPaquete,idProducto,nombre,precio)
				SELECT R.id,R.nombre,P.id,Pr.id,Pr.nombre,Pr.precio FROM Recurso R  JOIN (Paquete P JOIN Producto Pr ON P.id=Pr.idPaquete) ON R.id=P.idRecurso WHERE R.id = @idRecurso 
				SELECT * FROM @tempP
				SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				BEGIN TRANSACTION
					DELETE FROM Producto WHERE Producto.id = (SELECT TP.idProducto FROM @tempP TP WHERE Producto.id=TP.idProducto);
					DELETE FROM Paquete WHERE Paquete.id = (SELECT TP.idPaquete FROM @tempP TP WHERE Paquete.id = TP.idPaquete);
					DELETE FROM Recurso WHERE Recurso.id = @idRecurso;
				COMMIT
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
			BEGIN
				PRINT('Eliminando paquete '+ @idPaquete + ' del recurso ' +@nombreRecurso)
				SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				BEGIN TRANSACTION
					DELETE FROM Producto WHERE Producto.idPaquete = @idPaquete 
					DELETE FROM Paquete WHERE Paquete.id = @idPaquete
				COMMIT
			END
	END
GO

DROP PROC IF EXISTS spEliminarProducto
GO
/* spEliminarProducto usa como entrada la llave primaria del producto a borrar*/
CREATE PROC spEliminarProducto @idProducto INT AS
	BEGIN
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		BEGIN TRANSACTION
			DECLARE @producto NVARCHAR(50)= (SELECT P.nombre FROM Producto P WHERE P.id=@idProducto);
			PRINT('Borrando producto: '+@producto);
			DELETE FROM Producto WHERE Producto.id = @idProducto
		COMMIT
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
					RETURN -1;
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

CREATE PROC spAgregarPaquete @idRecurso INT AS
	BEGIN
		DECLARE @existeRecurso BIT;
		EXEC spBuscarRegistro @idRecurso,2,@existeRecurso OUTPUT;
		IF @existeRecurso = 1
			BEGIN
				SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				BEGIN TRANSACTION
					INSERT INTO Paquete(idRecurso)
					VALUES (@idRecurso)
				COMMIT
			END
		ELSE
			BEGIN
				RETURN -1
			END
	END
GO

DROP PROC IF EXISTS spAgregarProducto
GO

CREATE PROC spAgregarProducto @idRecurso INT,@idPaquete INT,@nombreProducto NVARCHAR(50),@precioProducto FLOAT AS
	BEGIN
		DECLARE @existeRecurso BIT;
		EXEC spBuscarRegistro @idRecurso,2,@existeRecurso OUTPUT;
		IF @existeRecurso = 1
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
							DECLARE @nombreRecurso NVARCHAR(50) = (SELECT R.nombre FROM Recurso R WHERE R.id = @idRecurso);
							PRINT('Agregando '+@nombreProducto+ ' en el paquete '+CONVERT(NVARCHAR(50),@idPaquete)+ ' del recurso '+@nombreRecurso);
							END
						ELSE
							BEGIN
								PRINT('Producto '+@nombreProducto+' ya existe en el paquete')
								RETURN -1;
							END
						END
				ELSE
					BEGIN
						RETURN -1
					END
			END
		ELSE
			BEGIN
				RETURN -1
			END
	END
GO


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