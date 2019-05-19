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
					IF @usuario IS NULL
						BEGIN
							SET @existe = 0
							RETURN NULL
						END
					ELSE
						BEGIN
							SET @existe = 1;
							RETURN (SELECT * FROM Usuario U WHERE @input = U.id);
						END
				END
			ELSE IF @mode = 2 /* Busqueda de recurso*/ 
				BEGIN
					DECLARE @recurso INT= (SELECT id FROM Recurso WHERE id = CONVERT(INT,@input));
					IF @recurso IS NULL
						BEGIN
							SET @existe = 0
							RETURN NULL
						END
					ELSE
						BEGIN
							SET @existe = 1
							RETURN (SELECT * FROM Recurso R WHERE @input = R.id);
						END
				END
			ELSE
				SET @existe = 0
				return NULL
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
						RETURN NULL;
					END
				ELSE
					BEGIN
						SET @existePaqueteInput = 1;
						RETURN (SELECT * FROM Paquete P WHERE @idPaqueteInput = P.numPaqueteRecurso);
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

CREATE PROC spBuscarProducto @idRecursoInput INT, @idPaqueteInput INT, @idProductoInput INT,@existeProducto INT AS
	BEGIN
	DECLARE @existePaquete BIT;
	EXEC spBuscarPaquete @idRecursoInput,@idPaqueteInput,@existePaquete;
	IF @existePaquete = 1 /* Existe paquete*/
		BEGIN
			DECLARE @producto INT = (SELECT P.numProductoPaquete FROM Producto P WHERE @idProductoInput=P.numProductoPaquete);
			IF @producto IS NULL
				BEGIN
					SET @existeProducto = 0;
					RETURN NULL;
				END
			ELSE
				BEGIN
					SET @existeProducto = 1;
					RETURN (SELECT * FROM Paquete P WHERE @idProductoInput=P.numPaqueteRecurso);
				END
		END
	ELSE
		BEGIN
			RETURN NULL
		END

	END
GO

/* PROC para el login */
DROP PROC IF EXISTS spLogin
GO

CREATE PROC spLogin @nombreUsuarioInput char(50), @passwordInput char(50) AS
	BEGIN
		DECLARE @existeUsuario BIT;
		EXEC spBuscarRegistro @input = @nombreUsuarioInput,@mode = 1,@existe = @existeUsuario;
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

	END
GO