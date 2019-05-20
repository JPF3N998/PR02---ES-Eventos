
/*CORRER POR SEPARADO*/

/*1*/
/*
CREATE DATABASE ESEventosOnline
GO

USE ESEventosOnline
GO
*/

/*2*/
DROP PROC IF EXISTS spSetupBD
GO

CREATE PROC spSetupBD AS
	BEGIN

		CREATE TABLE Usuario(
			id INT PRIMARY KEY IDENTITY(1,1),
			nombre NVARCHAR(50),
			cedula INT,
			correo NVARCHAR(50),
			username NVARCHAR(50),
			password NVARCHAR(50)
		);

		CREATE TABLE Recurso(
			id INT PRIMARY KEY IDENTITY(1,1),
			nombre NVARCHAR(50),
			correo NVARCHAR(50),
			telefono NVARCHAR(50),
			provincia NVARCHAR(50)
		);

		/*
		numPaqueteRecurso es el ID del paquete con respecto al recurso
		y no es llave primaria. Es decir, id puede ser 5 (autogenerado por el identity),
		pero numPaqueteRecurso puede ser 2 ya que es el segundo paquete del recurso 'Catering'.
		El numPaqueteRecurso se establecera con SELECT (COUNT(id) from Paquete where idRecurso = Recurso.id) + 1
		*/

		CREATE TABLE Paquete(
			id INT PRIMARY KEY IDENTITY(1,1),
			idRecurso INT,
			numPaqueteRecurso INT,
			FOREIGN KEY (idRecurso) REFERENCES Recurso(id)
		);
		/*
		numProductoPaquete es el ID del producto con respecto al paquete
		y no es llave primaria. Es decir, id puede ser 6 (autogenerado por el identity),
		pero numProductoPaquete puede ser 2 ya que es el segundo producto del paquete 3 del recurso 'Catering'.
		El numProductoPaquete se establecera con SELECT (COUNT(id) from Producto where idPaquete = Paquete.id) + 1
		*/
		CREATE TABLE Producto(
			id INT PRIMARY KEY IDENTITY(1,1),
			idPaquete INT,
			numProductoPaquete INT,
			nombre NVARCHAR(100),
			precio FLOAT,
			FOREIGN KEY (idPaquete) REFERENCES Paquete(id)
		);

		CREATE TABLE Reservacion(
			id INT PRIMARY KEY IDENTITY(1,1),
			idCliente INT,
			idPaquete INT,
			fechaInicio DATE,
			fechaFin DATE,
			horaInicio TIME,
			horaFin TIME,
			precioTotal FLOAT,
			FOREIGN KEY (idCliente) REFERENCES Usuario(id),
			FOREIGN KEY (idPaquete) REFERENCES Paquete(id)
		);

		CREATE TABLE Factura(
			id INT PRIMARY KEY IDENTITY(1,1),
			idCliente INT,
			idReservacion INT,
			fechaFin DATE,
			horaInicio TIME,
			horaFin TIME,
			precioTotal FLOAT,
			FOREIGN KEY (idCliente) REFERENCES Usuario(id),
			FOREIGN KEY (idReservacion) REFERENCES Reservacion(id) 
		);
	END
GO
/*3*/
DROP PROC IF EXISTS spRegisterAdmin
GO

CREATE PROC spRegisterAdmin AS
	BEGIN
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		IF (SELECT U.username FROM Usuario U WHERE username = 'admin') IS NULL
			BEGIN
				BEGIN TRANSACTION
					INSERT INTO Usuario(nombre,cedula,correo,username,password)
					VALUES ('Administrador',12345,'f3n9b0t@gmail.com','admin','admin');
				COMMIT
			END
	END
GO

DROP PROC IF EXISTS spFillRecursos
GO

CREATE PROC  spFillRecursos AS
	BEGIN
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		BEGIN TRANSACTION
			INSERT INTO Recurso(nombre,correo,telefono,provincia)
			VALUES ('Local','local@correo.com','12345678','Cartago')
			INSERT INTO Recurso(nombre,correo,telefono,provincia)
			VALUES ('Catering','catering@correo.com','12345678','Limon')
			INSERT INTO Recurso(nombre,correo,telefono,provincia)
			VALUES ('Musica','musica@correo.com','12345678','Alajuela')
			INSERT INTO Recurso(nombre,correo,telefono,provincia)
			VALUES ('Decoracion','decoracion@correo.com','12345678','San Jose')
		COMMIT
	END
GO

DROP PROC IF EXISTS spFillPaquetes
GO

CREATE PROC  spFillPaquetes AS
	BEGIN
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		BEGIN TRANSACTION
			INSERT INTO Paquete(idRecurso,numPaqueteRecurso)
			VALUES (1,1)
			INSERT INTO Paquete(idRecurso,numPaqueteRecurso)
			VALUES (1,2)
			INSERT INTO Paquete(idRecurso,numPaqueteRecurso)
			VALUES (1,3)

			INSERT INTO Paquete(idRecurso,numPaqueteRecurso)
			VALUES (2,1)
			INSERT INTO Paquete(idRecurso,numPaqueteRecurso)
			VALUES (2,2)
			INSERT INTO Paquete(idRecurso,numPaqueteRecurso)
			VALUES (2,3)

			INSERT INTO Paquete(idRecurso,numPaqueteRecurso)
			VALUES (3,1)
			INSERT INTO Paquete(idRecurso,numPaqueteRecurso)
			VALUES (3,2)
			INSERT INTO Paquete(idRecurso,numPaqueteRecurso)
			VALUES (3,3)

			INSERT INTO Paquete(idRecurso,numPaqueteRecurso)
			VALUES (4,1)
			INSERT INTO Paquete(idRecurso,numPaqueteRecurso)
			VALUES (4,2)
			INSERT INTO Paquete(idRecurso,numPaqueteRecurso)
			VALUES (4,3)			
		COMMIT
	END
GO

DROP PROC IF EXISTS spFillProductos
GO

CREATE PROC spFillProductos AS
	BEGIN
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		BEGIN TRANSACTION
			INSERT INTO Producto(idPaquete,numProductoPaquete,nombre,precio)
			VALUES (1,1,'El Cuartel', 500)
			INSERT INTO Producto(idPaquete,numProductoPaquete,nombre,precio)
			VALUES (2,1,'La Concha', 1000)
			INSERT INTO Producto(idPaquete,numProductoPaquete,nombre,precio)
			VALUES (3,1,'XCape', 1500)

			INSERT INTO Producto(idPaquete,numProductoPaquete,nombre,precio)
			VALUES (4,1,'Desayuno', 500)
			INSERT INTO Producto(idPaquete,numProductoPaquete,nombre,precio)
			VALUES (5,1,'Almuerzo', 2000)
			INSERT INTO Producto(idPaquete,numProductoPaquete,nombre,precio)
			VALUES (6,1,'Cena', 2500)

			INSERT INTO Producto(idPaquete,numProductoPaquete,nombre,precio)
			VALUES (7,1,'Cocofunka', 500)
			INSERT INTO Producto(idPaquete,numProductoPaquete,nombre,precio)
			VALUES (8,1,'Magpie Jay', 3000)
			INSERT INTO Producto(idPaquete,numProductoPaquete,nombre,precio)
			VALUES (9,1,'424', 3500)

			INSERT INTO Producto(idPaquete,numProductoPaquete,nombre,precio)
			VALUES (10,1,'Globos', 500)
			INSERT INTO Producto(idPaquete,numProductoPaquete,nombre,precio)
			VALUES (11,1,'Flores', 4000)
			INSERT INTO Producto(idPaquete,numProductoPaquete,nombre,precio)
			VALUES (12,1,'Centros de mesa', 4500)


		COMMIT

	END
GO


/*4*/
EXEC spSetupBD
GO

EXEC spRegisterAdmin
GO

/*
DBCC CHECKIDENT ('Usuario',RESEED,0);
DBCC CHECKIDENT ('Recurso',RESEED,0);
DBCC CHECKIDENT ('Paquete',RESEED,0);
DBCC CHECKIDENT ('Producto',RESEED,0);
DBCC CHECKIDENT ('Reservacion',RESEED,0);
DBCC CHECKIDENT ('Factura',RESEED,0);
*/

EXEC spFillRecursos
GO

EXEC spFillPaquetes
GO

EXEC spFillProductos
GO
