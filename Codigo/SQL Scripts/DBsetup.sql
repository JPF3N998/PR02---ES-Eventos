
/*CORRER POR SEPARADO*/

/*1*/

CREATE DATABASE ESEventosOnline
GO

USE ESEventosOnline
GO

SET NOCOUNT ON;
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
			password NVARCHAR(50),
			admin BIT
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
			nombre NVARCHAR(100),
			precio FLOAT,
			FOREIGN KEY (idPaquete) REFERENCES Paquete(id)
		);

		CREATE TABLE Reservacion(
			id INT PRIMARY KEY IDENTITY(1,1),
			idCliente INT,
			idPaquete INT,
			fecha DATE,
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
			fecha DATE,
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
					INSERT INTO Usuario(nombre,cedula,correo,username,password,admin)
					VALUES ('Administrador',12345,'f3n9b0t@gmail.com','admin','admin',1);
					INSERT INTO Usuario(nombre,cedula,correo,username,password,admin)
					VALUES ('feng',12345,'feng@gmail.com','feng','feng',0);
					INSERT INTO Usuario(nombre,cedula,correo,username,password,admin)
					VALUES ('andrey',12345,'andrey@gmail.com','andrey','andrey',0);
				COMMIT
			END
	END
GO

DROP PROC IF EXISTS spFillRecursos
GO

CREATE PROC spFillRecursos AS
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
			DELETE Paquete /*Limpiar la tabla para que no se repitan los registros*/
			INSERT INTO Paquete(idRecurso)
			VALUES (1)
			INSERT INTO Paquete(idRecurso)
			VALUES (1)
			INSERT INTO Paquete(idRecurso)
			VALUES (1)

			INSERT INTO Paquete(idRecurso)
			VALUES (2)
			INSERT INTO Paquete(idRecurso)
			VALUES (2)
			INSERT INTO Paquete(idRecurso)
			VALUES (2)

			INSERT INTO Paquete(idRecurso)
			VALUES (3)
			INSERT INTO Paquete(idRecurso)
			VALUES (3)
			INSERT INTO Paquete(idRecurso)
			VALUES (3)

			INSERT INTO Paquete(idRecurso)
			VALUES (4)
			INSERT INTO Paquete(idRecurso)
			VALUES (4)
			INSERT INTO Paquete(idRecurso)
			VALUES (4)			
		COMMIT
	END
GO

DROP PROC IF EXISTS spFillProductos
GO

CREATE PROC spFillProductos AS
	BEGIN
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		BEGIN TRANSACTION
			DELETE Producto /*Limpiar la tabla para que no se repitan los registros*/
			INSERT INTO Producto(idPaquete,nombre,precio)
			VALUES (1,'El Cuartel', 500)
			INSERT INTO Producto(idPaquete,nombre,precio)
			VALUES (1,'Pilsen', 1500)
			INSERT INTO Producto(idPaquete,nombre,precio)
			VALUES (1,'Imperial', 1500)
			
			INSERT INTO Producto(idPaquete,nombre,precio)
			VALUES (2,'La Concha', 1000)
			INSERT INTO Producto(idPaquete,nombre,precio)
			VALUES (2,'Pilsen', 1300)
			INSERT INTO Producto(idPaquete,nombre,precio)
			VALUES (2,'Imperial', 100)

			INSERT INTO Producto(idPaquete,nombre,precio)
			VALUES (3,'XCape', 1500)
			INSERT INTO Producto(idPaquete,nombre,precio)
			VALUES (3,'Te Frio', 1000)
			INSERT INTO Producto(idPaquete,nombre,precio)
			VALUES (3,'Jugo de naranja', 1000)

			INSERT INTO Producto(idPaquete,nombre,precio)
			VALUES (4,'Desayuno', 500)
			INSERT INTO Producto(idPaquete,nombre,precio)
			VALUES (5,'Almuerzo', 2000)
			INSERT INTO Producto(idPaquete,nombre,precio)
			VALUES (6,'Cena', 2500)

			INSERT INTO Producto(idPaquete,nombre,precio)
			VALUES (7,'Cocofunka', 500)
			INSERT INTO Producto(idPaquete,nombre,precio)
			VALUES (8,'Magpie Jay', 3000)
			INSERT INTO Producto(idPaquete,nombre,precio)
			VALUES (9,'424', 3500)

			INSERT INTO Producto(idPaquete,nombre,precio)
			VALUES (10,'Globos', 500)
			INSERT INTO Producto(idPaquete,nombre,precio)
			VALUES (11,'Flores', 4000)
			INSERT INTO Producto(idPaquete,nombre,precio)
			VALUES (12,'Centros de mesa', 4500)
		COMMIT
	END
GO

DROP PROC IF EXISTS spFillReservacionesFacturas
GO

CREATE PROC spFillReservacionesFacturas AS
	BEGIN
		INSERT INTO Reservacion(idCliente,idPaquete,fecha,horaInicio,horaFin,precioTotal)
		VALUES (2,1,(CONVERT(DATE,'18/05/2019',103)),CONVERT(TIME,'20:00',108),CONVERT(TIME,'2:00',108),(SELECT SUM(P.precio) FROM Producto P WHERE P.idPaquete = 1))
		INSERT INTO Factura(idCliente,idReservacion,fecha,horaInicio,horaFin,precioTotal)
		VALUES (2,1,(CONVERT(DATE,'18/05/2019',103)),CONVERT(TIME,'20:00',108),CONVERT(TIME,'2:00',108),(SELECT SUM(P.precio) FROM Producto P WHERE P.idPaquete = 1))
		
		INSERT INTO Reservacion(idCliente,idPaquete,fecha,horaInicio,horaFin,precioTotal)
		VALUES (1,2,(CONVERT(DATE,'20/05/2019',103)),CONVERT(TIME,'20:00',108),CONVERT(TIME,'21:00',108),(SELECT SUM(P.precio) FROM Producto P WHERE P.idPaquete = 2))
		INSERT INTO Factura(idCliente,idReservacion,fecha,horaInicio,horaFin,precioTotal)
		VALUES (1,2,(CONVERT(DATE,'20/05/2019',103)),CONVERT(TIME,'20:00',108),CONVERT(TIME,'21:00',108),(SELECT SUM(P.precio) FROM Producto P WHERE P.idPaquete = 2))
		
		INSERT INTO Reservacion(idCliente,idPaquete,fecha,horaInicio,horaFin,precioTotal)
		VALUES (1,2,(CONVERT(DATE,'22/05/2019',103)),CONVERT(TIME,'8:00',108),CONVERT(TIME,'12:00',108),(SELECT SUM(P.precio) FROM Producto P WHERE P.idPaquete = 2))
		INSERT INTO Factura(idCliente,idReservacion,fecha,horaInicio,horaFin,precioTotal)
		VALUES (1,3,(CONVERT(DATE,'22/05/2019',103)),CONVERT(TIME,'8:00',108),CONVERT(TIME,'12:00',108),(SELECT SUM(P.precio) FROM Producto P WHERE P.idPaquete = 2))
		
		INSERT INTO Reservacion(idCliente,idPaquete,fecha,horaInicio,horaFin,precioTotal)
		VALUES (1,12,(CONVERT(DATE,'07/05/2019',103)),CONVERT(TIME,'18:00',108),CONVERT(TIME,'21:00',108),(SELECT SUM(P.precio) FROM Producto P WHERE P.idPaquete = 12))
		INSERT INTO Factura(idCliente,idReservacion,fecha,horaInicio,horaFin,precioTotal)
		VALUES (1,4,(CONVERT(DATE,'07/05/2019',103)),CONVERT(TIME,'18:00',108),CONVERT(TIME,'21:00',108),(SELECT SUM(P.precio) FROM Producto P WHERE P.idPaquete = 12))
	
		INSERT INTO Reservacion(idCliente,idPaquete,fecha,horaInicio,horaFin,precioTotal)
		VALUES (1,9,(CONVERT(DATE,'16/03/2019',103)),CONVERT(TIME,'20:00',108),CONVERT(TIME,'00:00',108),(SELECT SUM(P.precio) FROM Producto P WHERE P.idPaquete = 9))
		INSERT INTO Factura(idCliente,idReservacion,fecha,horaInicio,horaFin,precioTotal)
		VALUES (1,5,(CONVERT(DATE,'16/03/2019',103)),CONVERT(TIME,'20:00',108),CONVERT(TIME,'00:00',108),(SELECT SUM(P.precio) FROM Producto P WHERE P.idPaquete = 9))
		
		INSERT INTO Reservacion(idCliente,idPaquete,fecha,horaInicio,horaFin,precioTotal)
		VALUES (1,7,(CONVERT(DATE,'01/05/2019',103)),CONVERT(TIME,'13:00',108),CONVERT(TIME,'15:00',108),(SELECT SUM(P.precio) FROM Producto P WHERE P.idPaquete = 7))
		INSERT INTO Factura(idCliente,idReservacion,fecha,horaInicio,horaFin,precioTotal)
		VALUES (1,6,(CONVERT(DATE,'01/05/2019',103)),CONVERT(TIME,'13:00',108),CONVERT(TIME,'15:00',108),(SELECT SUM(P.precio) FROM Producto P WHERE P.idPaquete = 7))
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

EXEC spFillReservacionesFacturas
GO