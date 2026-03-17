--Joseph Hines Jimenez
--Rodolfo Jose Carmona Bermudez
--Noilyn Elena Mendez Ruiz
--Jorge Alberto Bravo Urbina

--Importancia: El modelo relacional elimina la redundancia de datos, asegura la integridad y mejora la eficiencia de las consultas y el mantenimiento. 
--Por eso es más robusto y escalable que un “archivador electrónico” con información duplicada.

-------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE Usuarios(
UsuarioID INT IDENTITY PRIMARY KEY,
Nombre NVARCHAR (100) NOT NULL,
CorreoElectronico NVARCHAR (100) NOT NULL UNIQUE,
Telefono NVARCHAR (20) NULL
);
--Agregar Usuarios--
INSERT INTO Usuarios (Nombre, CorreoElectronico, Telefono) VALUES ('David Lopez', 'david.lopez@gmail.co', '8888-1111')
INSERT INTO Usuarios (Nombre, CorreoElectronico, Telefono) VALUES('Carmen Arias', 'carmen.arias@gmail.com', '8888-2222')
INSERT INTO Usuarios (Nombre, CorreoElectronico, Telefono) VALUES('Jose Torres', 'jose.torres@gmail.com', '8888-3333')
INSERT INTO Usuarios (Nombre, CorreoElectronico, Telefono) VALUES('Ana Ramirez', 'ana.ramirez@gmail.com', '8888-4444')
INSERT INTO Usuarios (Nombre, CorreoElectronico, Telefono) VALUES('Juan Castro', 'juan.castro@gmail.com', '8888-5555')

INSERT INTO Usuarios (Nombre, CorreoElectronico, Telefono) VALUES('Miguel Valverde', 'miguel.valverde@gmail.com', '8888-6666')
--Agrega la informacion de cada usuario o dueño del dispositivo con su information de contacto
SELECT * FROM Usuarios;

UPDATE Usuarios
SET CorreoElectronico = 'david.lopez@gmail.com'
WHERE UsuarioID = 10;
--
--------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Equipos(
EquipoID INT IDENTITY PRIMARY KEY,
TipoEquipo NVARCHAR(50) NOT NULL,
Modelo NVARCHAR(50) NOT NULL,
UsuarioID INT NOT NULL,
FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);
--Agregar Equipos--
INSERT INTO Equipos (TipoEquipo, Modelo, UsuarioID) VALUES('Laptop', 'Acer Aspire', 10) -- Equipo de David Lopez
INSERT INTO Equipos (TipoEquipo, Modelo, UsuarioID) VALUES('Laptop', 'HP OmniBook', 11) -- Equipo de Carmen Arias
INSERT INTO Equipos (TipoEquipo, Modelo, UsuarioID) VALUES('Laptop', 'Lenovo ThinkPad', 12) -- Equipo de Jose Torres
INSERT INTO Equipos (TipoEquipo, Modelo, UsuarioID) VALUES('Tablet', 'iPad Air', 13) -- Equipo de Ana Ramirez
INSERT INTO Equipos (TipoEquipo, Modelo, UsuarioID) VALUES('Tablet', 'iPad Pro', 14) -- Equipo de Juan Castro

INSERT INTO Equipos (TipoEquipo, Modelo, UsuarioID) VALUES('Celular', 'iPhone 17 Pro Max', 15) -- Equipo de Miguel Valverde
--Agrega la informacion general de cada dispositivo y lo enlaza al usuario o dueño
SELECT * FROM Equipos

UPDATE Equipos
SET Modelo = 'Microsoft Surface'
WHERE EquipoID = 1;

---------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE Reparaciones(
ReparacionID INT IDENTITY PRIMARY KEY,
EquipoID INT NOT NULL,
FechaSolicitud DATE NOT NULL,
Estado NVARCHAR(50) NOT NULL,
FOREIGN KEY (EquipoID) REFERENCES Equipos(EquipoID)
);

INSERT INTO Reparaciones (EquipoID, FechaSolicitud, Estado) VALUES (1, '01-03-2026', 'En Proceso')
INSERT INTO Reparaciones (EquipoID, FechaSolicitud, Estado) VALUES (2, '02-03-2026', 'En Proceso')
INSERT INTO Reparaciones (EquipoID, FechaSolicitud, Estado) VALUES (3, '03-03-2026', 'En Proceso')
INSERT INTO Reparaciones (EquipoID, FechaSolicitud, Estado) VALUES (4, '04-03-2026', 'En Proceso')
INSERT INTO Reparaciones (EquipoID, FechaSolicitud, Estado) VALUES (5, '05-03-2026', 'En Proceso')
--Ingresa la informacion general de cada reparacion
SELECT * FROM Reparaciones
--------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE DetallesReparacion(
DetalleID INT IDENTITY PRIMARY KEY,
ReparacionID INT NOT NULL,
Descripcion NVARCHAR(300) NOT NULL,
FechaInicio DATE NOT NULL,
FechaFin DATE NULL,
FOREIGN KEY (ReparacionID) REFERENCES Reparaciones(ReparacionID)
);

INSERT INTO DetallesReparacion (ReparacionID, Descripcion, FechaInicio, FechaFin) VALUES (1, 'Cambio de teclado','01-03-2026', NULL)
INSERT INTO DetallesReparacion (ReparacionID, Descripcion, FechaInicio, FechaFin) VALUES (2, 'Actualizacion de disco duro','02-03-2026', '09-03-2026')
INSERT INTO DetallesReparacion (ReparacionID, Descripcion, FechaInicio, FechaFin) VALUES (3, 'Remplazo de bateria','03-03-2026', '10-03-2026')
INSERT INTO DetallesReparacion (ReparacionID, Descripcion, FechaInicio, FechaFin) VALUES (4, 'Cambio de pantalla','04-03-2026', NULL)
INSERT INTO DetallesReparacion (ReparacionID, Descripcion, FechaInicio, FechaFin) VALUES (5, 'Desbloqueo completo','05-03-2026', '12-03-2026')
--Ingresa los detalles sobre lo que hay que reparar a cada dispositivo
SELECT * FROM DetallesReparacion
--------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE Tecnicos(
TecnicoID INT IDENTITY PRIMARY KEY,
Nombre NVARCHAR (50) NOT NULL,
Especialidad NVARCHAR (50) NOT NULL
);
--Agregar Tecnicos--
INSERT INTO Tecnicos (Nombre, Especialidad) VALUES('Pedro Esquivel', 'Hardware')
INSERT INTO Tecnicos (Nombre, Especialidad) VALUES('Manuel Lopez', 'Hardware')
INSERT INTO Tecnicos (Nombre, Especialidad) VALUES('Susana Rojas', 'Hardware')
INSERT INTO Tecnicos (Nombre, Especialidad) VALUES('Jeffry Vega', 'Hardware-Mobiles')
INSERT INTO Tecnicos (Nombre, Especialidad) VALUES('Luisa Herrera', 'Mobiles')
--Agregar tecnicos al sistema con su especialidad
SELECT * FROM Tecnicos
---------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE Asignaciones(
AsignacionID INT IDENTITY PRIMARY KEY,
ReparacionID INT NOT NULL,
TecnicoID INT NOT NULL,
FechaAsignacion DATE NOT NULL,
FOREIGN KEY (ReparacionID) REFERENCES Reparaciones(ReparacionID),
FOREIGN KEY (TecnicoID) REFERENCES Tecnicos(TecnicoID)
);

INSERT INTO Asignaciones (ReparacionID, TecnicoID, FechaAsignacion) VALUES (1, 1, '01-03-2026')
INSERT INTO Asignaciones (ReparacionID, TecnicoID, FechaAsignacion) VALUES (2, 2, '02-03-2026')
INSERT INTO Asignaciones (ReparacionID, TecnicoID, FechaAsignacion) VALUES (3, 3, '03-03-2026')
INSERT INTO Asignaciones (ReparacionID, TecnicoID, FechaAsignacion) VALUES (4, 4, '04-03-2026')
INSERT INTO Asignaciones (ReparacionID, TecnicoID, FechaAsignacion) VALUES (5, 5, '05-03-2026')
--Agrega la informacion de las asignaciones
SELECT * FROM Asignaciones
---------------------------------------------------------------------------------------------------------------------------------

---PROCEDIMIENTOS ALMACENADOS---

--Registrar una reparacion
GO
CREATE PROCEDURE sp_RegistrarReparacion
    @EquipoID INT,
    @FechaSolicitud DATE

AS
BEGIN
    INSERT INTO Reparaciones (EquipoID, FechaSolicitud, Estado)
    VALUES (@EquipoID, @FechaSolicitud, 'Pendiente');
END;
GO

EXEC sp_RegistrarReparacion @EquipoID = 6, @FechaSolicitud = '2026-03-06'; --Ejecutable para ingresar una reparacion al sistema

--Asignar tecnico
GO
CREATE PROCEDURE sp_AsignarTecnico
    @ReparacionID INT,
    @TecnicoID INT,
    @FechaAsignacion DATE
AS
BEGIN
    INSERT INTO Asignaciones (ReparacionID, TecnicoID, FechaAsignacion)
    VALUES (@ReparacionID, @TecnicoID, @FechaAsignacion);
END;
GO

EXEC sp_AsignarTecnico @ReparacionID = 6, @TecnicoID = 5, @FechaAsignacion = '2026-03-06'; --Ejecutable para asignar una reparacion a un tecnico

--Trigger de actualizacion de estado de reparacion
GO
CREATE TRIGGER trg_FinalizarReparacion
ON DetallesReparacion
AFTER UPDATE
AS
BEGIN
    UPDATE R
    SET Estado = 'Completado'
    FROM Reparaciones R
    INNER JOIN inserted i ON R.ReparacionID = i.ReparacionID
    WHERE i.FechaFin IS NOT NULL;
END;
GO

UPDATE DetallesReparacion
SET FechaFin = '03-15-2026'
WHERE ReparacionID = 1;     --Es el encargado de hacer funcionar al triger para cambiar el estado de las reparaciones

--FASE 4--

--Informe de asignaciones
SELECT U.Nombre AS Usuario,
       E.Modelo AS Equipo,
       T.Nombre AS Tecnico
FROM Asignaciones A
INNER JOIN Reparaciones R ON A.ReparacionID = R.ReparacionID
INNER JOIN Equipos E ON R.EquipoID = E.EquipoID
INNER JOIN Usuarios U ON E.UsuarioID = U.UsuarioID
INNER JOIN Tecnicos T ON A.TecnicoID = T.TecnicoID;  --Permite verificar que dispositivo tiene cada tecnico y su dueño
--Estadistica de carga de trabajo
SELECT T.Nombre AS Tecnico,
       COUNT(A.ReparacionID) AS TotalReparaciones
FROM Asignaciones A
INNER JOIN Tecnicos T ON A.TecnicoID = T.TecnicoID
GROUP BY T.Nombre;                                   --Indica la cantidad de reparaciones que tiene cada tecnico asignado
--Filtro de seguridad
SELECT *
FROM Equipos
WHERE Modelo = 'iPhone 17 Pro Max'
  AND EXISTS (
      SELECT 1
      FROM Reparaciones R
      WHERE R.EquipoID = Equipos.EquipoID
        AND R.FechaSolicitud >= DATEADD(MONTH, -1, GETDATE()) --Ayuda a verificar los dispositivos que han sido ingresados basado en un modelo
 );
