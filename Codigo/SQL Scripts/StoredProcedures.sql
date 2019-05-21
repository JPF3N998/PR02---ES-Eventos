USE ESEventosOnline
GO

DROP PROC IF EXISTS spBuscarRegistro
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
	Busca un paquete con el ID de recurso y el numero de paquete del recurso, no con la llave primaria
	Retorna: Fila con el paquete especificado
*/
CREATE PROC spBuscarPaquete @idRecursoInput INT,@idPaqueteInput INT,@existePaqueteInput BIT OUTPUT AS 
	BEGIN
		DECLARE @existeRecurso BIT;
		EXEC spBuscarRegistro @input = @idRecursoInput, @mode = 2, @existe= @existeRecurso OUTPUT;
		IF @existeRecurso = 0
			BEGIN
				RETURN NULL;
			END
		ELSE
			BEGIN
				DECLARE @paquete INT = (SELECT P.numPaqueteRecurso FROM Paquete P WHERE @idPaqueteInput = P.numPaqueteRecurso);
				IF @paquete IS NULL
					BEGIN
						/*SELECT * FROM Paquete P WHERE @idPaqueteInput = P.numPaqueteRecurso*/
						RETURN -1
					END
				ELSE
					BEGIN
						SET @existePaqueteInput = 1;
						SELECT * FROM Paquete P WHERE @idPaqueteInput = P.numPaqueteRecurso
					END
			END
	END
GO

DROP PROC IF EXISTS spBuscarProducto
GO
/*
	Busca un producto con el ID de recurso, ID de paquete y numero de producto del paquete, no su ID de llave primaria
	Retorna: Fila con el producto especificado
*/

CREATE PROC spBuscarProducto @idRecursoInput INT, @idPaqueteInput INT, @idProductoInput INT,@existeProducto INT OUTPUT AS
	BEGIN
	DECLARE @existePaquete BIT;
	EXEC spBuscarPaquete @idRecursoInput,@idPaqueteInput,@existePaquete OUTPUT;
	IF @existePaquete = 1 /* Existe paquete*/
		BEGIN
			DECLARE @producto INT = (SELECT P.numProductoPaquete FROM Producto P WHERE @idProductoInput=P.numProductoPaquete);
			IF @producto IS NULL
				BEGIN
					SET @existeProducto = 0;
					RETURN -1;
				END
			ELSE
				BEGIN
					SET @existeProducto = 1;
					(SELECT * FROM Producto P WHERE @idProductoInput=P.numProductoPaquete);
					RETURN 0;
				END
		END
	ELSE
		BEGIN
			SET @existeProducto =0;
			RETURN -1;
		END

	END
GO

/* PROC para el login */
DROP PROC IF EXISTS spLogin
GO

CREATE PROC spLogin @nombreUsuarioInput char(50), @passwordInput char(50) AS
	BEGIN
		DECLARE @existeUsuario BIT;
		EXEC spBuscarRegistro @input = @nombreUsuarioInput,@mode = 1,@existe = @existeUsuario OUTPUT;
		IF (@existeUsuario = 1) /* Revisa existencia de usuario */
			BEGIN
				DECLARE @foundPassword CHAR(50)= (SELECT U.password FROM Usuario U WHERE @nombreUsuarioInput=U.username); 
				IF (@foundPassword=@passwordInput) /* Revisa si la contrasenna es la correcta */
					BEGIN
						RETURN 1;
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

DROP PROC IF EXISTS spCalcularPrecioDelPaquete
GO

CREATE PROC spCalcularPrecioDelPaquete @numPaquete INT,@precioTotal FLOAT OUTPUT AS
	BEGIN
		SET @precioTotal = (SELECT SUM(P.precio) FROM Producto P WHERE P.numProductoPaquete = @numPaquete);
		RETURN 0;
	END
GO

DROP PROC IF EXISTS spVerHistorialAdmin
GO

CREATE PROC spVerHistorialAdmin @idRecurso INT AS
	BEGIN
		SELECT * FROM Factura F JOIN (Reservacion R JOIN (Paquete P JOIN Recurso Re ON P.idRecurso = Re.id) ON R.idPaquete = P.id) ON F.idReservacion = R.id
		
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
				SELECT P.numPaqueteRecurso as [Paquete] FROM Paquete P WHERE @idRecurso = P.idRecurso
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
		PRINT(CONVERT(CHAR(2),@existeRecurso));
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

DROP PROC IF EXISTS spAgregarCliente
GO

CREATE PROC spAgregarCliente @nombreIn nvarchar(50), @cedulaIn int, @emailIn nvarchar(50), @userNameIn nvarchar(50), @passwordIn nvarchar(50) AS
BEGIN
	DECLARE @result int;
	BEGIN TRY
		if Exists(SELECT * FROM dbo.Usuario AS U WHERE U.username = @userNameIn)
			BEGIN
			SET @result = -1;
			RETURN @result;
			END
		IF @@TRANCOUNT = 0
			BEGIN
			SET TRANSACTION ISOLATION LEVEL READ COMMITTED
			BEGIN TRANSACTION
			END
		INSERT INTO dbo.Usuario	VALUES (@nombreIn, @cedulaIn, @emailIn, @userNameIn, @passwordIn);
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