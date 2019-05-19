
/*CORRER POR SEPARADO*/

/*1*/
CREATE DATABASE ESEventosOnline
GO

USE ESEventosOnline
GO

/*2*/
DROP PROC IF EXISTS spSetupBD
GO

CREATE PROC spSetupBD AS
	BEGIN

		CREATE TABLE Usuario(
			id INT PRIMARY KEY IDENTITY(1,1),
			nombre CHAR(50),
			cedula INT,
			correo CHAR(50),
			username CHAR(50),
			password CHAR(50)
		);

		CREATE TABLE Recurso(
			id INT PRIMARY KEY IDENTITY(1,1),
			nombre CHAR(50)
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
			nombre CHAR(100),
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

/*3*/
DROP PROC IF EXISTS spRegisterAdmin
GO

CREATE PROC spRegisterAdmin AS
	BEGIN
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		BEGIN TRANSACTION
			INSERT INTO Usuario(nombre,cedula,correo,username,password)
			VALUES ('Administrador',12345,'f3n9b0t@gmail.com','admin','admin');
		COMMIT
	END
GO

/*4*/
EXEC spSetupBD
GO

EXEC spRegisterAdmin
GO

