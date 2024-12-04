create database SistemaEscolar;
use SistemaEscolar;

CREATE TABLE Roles (
    IdRol INT PRIMARY KEY IDENTITY(1,1),
    NombreRol NVARCHAR(50) NOT NULL
);

CREATE TABLE Usuarios (
    IdUsuario INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Apellido NVARCHAR(100) NOT NULL,
    Telefono NVARCHAR(20),
    Correo NVARCHAR(100),
    RH NVARCHAR(5),
    EPS NVARCHAR(50),
    IdRol INT NOT NULL,
    FOREIGN KEY (IdRol) REFERENCES Roles(IdRol)
);


CREATE TABLE Grados (
    IdGrado INT PRIMARY KEY IDENTITY(1,1),
    NombreGrado NVARCHAR(50) NOT NULL
);


CREATE TABLE Horarios (
    IdHorario INT PRIMARY KEY IDENTITY(1,1),
    Hora NVARCHAR(50) NOT NULL,
    Dia NVARCHAR(50) NOT NULL,
    Aula NVARCHAR(50) NOT NULL
);


CREATE TABLE Estudiantes (
    IdEstudiante INT PRIMARY KEY,
    IdUsuario INT NOT NULL,
    CodigoMatricula NVARCHAR(50) NOT NULL,
    IdGrado INT NOT NULL,
    DatosAcudiente NVARCHAR(255),
    FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario),
    FOREIGN KEY (IdGrado) REFERENCES Grados(IdGrado)
);


CREATE TABLE Docentes (
    IdDocente INT PRIMARY KEY,
    IdUsuario INT NOT NULL,
    IdGrado INT NOT NULL,
    FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario),
    FOREIGN KEY (IdGrado) REFERENCES Grados(IdGrado)
);


CREATE TABLE Administradores (
    IdAdministrador INT PRIMARY KEY,
	NombreAdministrador NVARCHAR(100),
    IdUsuario INT NOT NULL,
    FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario)
);


CREATE TABLE Matriculas (
    IdMatricula INT PRIMARY KEY IDENTITY(1,1),
    IdEstudiante INT NOT NULL,
    IdHorario INT NOT NULL,
    FOREIGN KEY (IdEstudiante) REFERENCES Estudiantes(IdEstudiante),
    FOREIGN KEY (IdHorario) REFERENCES Horarios(IdHorario)
);

CREATE TABLE Calificaciones (
    IdCalificacion INT PRIMARY KEY IDENTITY(1,1),
    IdEstudiante INT NOT NULL,
    IdDocente INT NOT NULL,
    Nota DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (IdEstudiante) REFERENCES Estudiantes(IdEstudiante),
    FOREIGN KEY (IdDocente) REFERENCES Docentes(IdDocente)
);


INSERT INTO Roles (NombreRol) VALUES
('Estudiante'),
('Docente'),
('Administrador');


INSERT INTO Usuarios (Nombre, Apellido, Telefono, Correo, RH, EPS, IdRol) VALUES
('Juan', 'Pérez', '3001234567', 'juan.perez@gmail.com', 'O+', 'Sura', 1),
('Ana', 'Gómez', '3107654321', 'ana.gomez@gmail.com', 'A-', 'Colsanitas', 2),
('Carlos', 'López', '3209876543', 'carlos.lopez@gmail.com', 'B+', 'Compensar', 3);


INSERT INTO Grados (NombreGrado) VALUES
('Primero'),
('Segundo'),
('Tercero');


INSERT INTO Horarios (Hora, Dia, Aula) VALUES
('08:00 AM', 'Lunes', 'Aula 101'),
('10:00 AM', 'Martes', 'Aula 202'),
('02:00 PM', 'Miércoles', 'Aula 303');


INSERT INTO Estudiantes (IdEstudiante, IdUsuario, CodigoMatricula, IdGrado, DatosAcudiente) VALUES
(1, 1, 'MAT-001', 1, 'Pedro Pérez');


INSERT INTO Docentes (IdDocente, IdUsuario, IdGrado) VALUES
(1, 2, 2);


INSERT INTO Administradores (IdAdministrador, NombreAdministrador, IdUsuario) VALUES
(1, 'Kevin Valderrama', 1);


INSERT INTO Matriculas (IdEstudiante, IdHorario) VALUES
(1, 1),
(1, 2);


INSERT INTO Calificaciones (IdEstudiante, IdDocente, Nota) VALUES
(1, 1, 4.5);


--SELECT 
--    E.CodigoMatricula AS CodigoEstudiante,
--    U.Nombre + ' ' + U.Apellido AS NombreEstudiante,
--    G.NombreGrado AS Grado,
--    D.IdDocente AS CodigoDocente,
--    DU.Nombre + ' ' + DU.Apellido AS NombreDocente,
--    H.Hora AS HoraClase,
--    H.Dia AS DiaClase,
--    C.Nota AS Calificacion
--FROM 
--    Calificaciones C
--INNER JOIN Estudiantes E ON C.IdEstudiante = E.IdEstudiante
--INNER JOIN Usuarios U ON E.IdUsuario = U.IdUsuario
--INNER JOIN Grados G ON E.IdGrado = G.IdGrado
--INNER JOIN Docentes D ON C.IdDocente = D.IdDocente
--INNER JOIN Usuarios DU ON D.IdUsuario = DU.IdUsuario
--INNER JOIN Matriculas M ON E.IdEstudiante = M.IdEstudiante
--INNER JOIN Horarios H ON M.IdHorario = H.IdHorario
--ORDER BY C.Nota DESC;
