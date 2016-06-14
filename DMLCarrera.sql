DROP TABLE IF EXISTS circuit;
CREATE TABLE circuit(
    id          int         NOT NULL AUTO_INCREMENT,
    name      VARCHAR(30) NOT NULL ,
    status      tinyint(1)  NOT NULL ,
    description VARCHAR(240),
    PRIMARY KEY (id)
);


DROP TABLE IF EXISTS user;
CREATE TABLE user(
    id          int         NOT NULL  AUTO_INCREMENT,
    name     VARCHAR(30) NOT NULL  ,
    lastname   VARCHAR(30) NOT NULL ,
    birthDate DATE NOT NULL ,
    email        VARCHAR(60) NOT NULL,
    password        VARCHAR(60) NOT NULL,
    color       VARCHAR(60)  NOT NULL ,
    gender      VARCHAR(20) NOT NULL ,
    type        VARCHAR(20) NOT NULL ,
    PRIMARY KEY (id),
    UNIQUE (email)
);

DROP TABLE IF EXISTS inscription;
CREATE TABLE inscription(
    id            int         NOT NULL  AUTO_INCREMENT,
    circuit_id     int         NOT NULL ,
    user_id     int         NOT NULL ,
    inscriptionDate  DATETIME,
    PRIMARY KEY (id, circuit_id, user_id),
    FOREIGN KEY (circuit_id)
    REFERENCES circuit(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id)
    REFERENCES user(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS node;
CREATE TABLE node(
    id            int         NOT NULL AUTO_INCREMENT,
    name        VARCHAR(30) NOT NULL ,
    description   TEXT,
    code        VARCHAR(60) NOT NULL ,
    latitude     FLOAT NOT NULL ,
    longitude     FLOAT NOT NULL ,
    hint         TEXT NOT NULL ,
    circuit_id     int         NOT NULL ,
    PRIMARY KEY (id),
    FOREIGN KEY (circuit_id)
    REFERENCES circuit(id),
    UNIQUE (code)
);
DROP TABLE IF EXISTS question;
CREATE TABLE question(
    id            int         NOT NULL AUTO_INCREMENT,
    question     TEXT NOT NULL ,
    answer     TEXT NOT NULL ,
    node_id        int         NOT NULL ,
    PRIMARY KEY (id),
    FOREIGN KEY (node_id)
    REFERENCES node(id)
);

DROP TABLE IF EXISTS nodeDiscovered;
CREATE TABLE nodeDiscovered(
    id            int         NOT NULL AUTO_INCREMENT,
    node_id        int         NOT NULL ,
    user_id     int         NOT NULL ,
    question_id     int         NOT NULL ,
    status        tinyint(1)  NOT NULL ,
    statusDate1  DATETIME,
    statusDate2  DATETIME,
    statusDate3  DATETIME,
    PRIMARY KEY (id, node_id, user_id),
    FOREIGN KEY (node_id)
    REFERENCES node(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id)
    REFERENCES user(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id)
    REFERENCES question(id) ON DELETE CASCADE
);




INSERT  INTO circuit (name, status, description) VALUES ('COSem12016', 1,'Primera carrera de observación');
INSERT  INTO circuit (name, status, description) VALUES ('Intersemestral2016', 1,'carrera de observación intersemestral');

INSERT  INTO user (name, lastname, birthDate, email, password, color, gender, type) VALUES ('JULIAN MAURICIO', 'MEJIA CARDONA', '1984-01-28', 'jmmejia@autonoma.edu.co', MD5('123'), 'verde', 'hombre','administrador');
INSERT  INTO user (name, lastname, birthDate, email, password, color, gender, type) VALUES ('JORGE IVAN', 'MEZA MARTINEZ', '1978-04-14', 'jimezam@autonoma.edu.co', MD5('123'), 'azul', 'hombre','usuario');

INSERT  INTO node (name, description,code, latitude, longitude, hint,  circuit_Id) VALUES ( 'BIBLIOTECA', 'BIBLIOTECA', RAND(), 20.1, 120.5, 'SILENCIO, ESPACIO Y CONOCIMIENTO ENCONTRARAS EN ESTE LUGAR', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint,  circuit_Id) VALUES ( 'CAJA', 'CAJA', RAND(), 20.1, 120.5, 'AQUÍ TU SEMESTRE Y LIBROS HAS DE PAGAR', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint,  circuit_Id) VALUES ( 'REGISTRO ACADEMICO', 'REGISTRO ACADEMICO', RAND(), 20.1, 120.5, 'EN ESTE LUGAR EL PROCESO DE INSCRIPCION ACENTARAS', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint,  circuit_Id) VALUES ( 'MERCADEO', 'MERCADEO', RAND(), 20.1, 120.5, 'SUS ENCARGADOS LA OFERTA ACADEMICA Y AYUDA ADMINISTRATIVA TE OFRECERAN', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint,  circuit_Id) VALUES ( 'RELACIONES INTERNACIONALES', 'RELACIONES INTERNACIONALES', RAND(), 20.1, 120.5, 'SI UN INTERCAMBIO QUIERES HACER A ESTE LUGAR DEBES LLEGAR', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint,  circuit_Id) VALUES ( 'CARTERA', 'CARTERA', RAND(), 20.1, 120.5, 'PLAZOS DE FINANCIAMIENTO Y OPCIONES A PROBLEMAS ECONOMICAS ACA TE DARAN', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint,  circuit_Id) VALUES ( 'DESARROLLO HUMANO', 'DESARROLLO HUMANO', RAND(), 20.1, 120.5, 'SUS ENCARGADOS VELAN POR TU BIENESTAR MENTAL Y PSICOLOGICO, ADEMAS DE AYUDA CON DIFICULTADES ACADEMICAS', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint,  circuit_Id) VALUES ( 'SERVICIOS MEDICOS', 'SERVICIOS MEDICOS', RAND(), 20.1, 120.5, 'EN ESTE SITIO ENCONTRARAS UN MEDICO QUE TE PUEDE INDICAR QUE TRATAMIENTO TOMAR', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint,  circuit_Id) VALUES ( 'ATENCION PREHOSPITALARIA', 'ATENCION PREHOSPITALARIA', RAND(), 20.1, 120.5, 'SI TE SIENTES FISICAMENTE MAL EN ESTE LUGAR UNA PERSONA PROFESIONAL TE ATENDERA', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint,  circuit_Id) VALUES ( 'LABORATORIO ELECTRONICA', 'LABORATORIO ELECTRONICA', RAND(), 20.1, 120.5, 'LOS MONTAJES ELECTRONICOS Y EXPERIMENTOS FISICOS EN ESTE LUGAR DESARROLLARAS', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint,  circuit_Id) VALUES ( 'GIMNASIO', 'GIMNASIO', RAND(), 20.1, 120.5, 'ALLI EJERCICIO, JUGAR Y LIBERAR TENSION PUEDES REALIZAR', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint,  circuit_Id) VALUES ( 'GESTION DE TECNOLOGIA', 'GESTION DE TECNOLOGIA', RAND(), 20.1, 120.5, 'OLVIDO DE CONTRASEÑAS Y PROBLEMAS DE INGRESO A LOS SISTEMAS AQUÍ TE SOLUCIONARAN', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint,  circuit_Id) VALUES ( 'DECANATURA INGENIERIA', 'DECANATURA INGENIERIA', RAND(), 20.1, 120.5, 'LOS PROCESOS ACADEMICOS DESDE ALLÍ SE GOBERNARAN', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint,  circuit_Id) VALUES ( 'SALA DE PROFESORES DE INGENIERIA', 'SALA DE PROFESORES DE INGENIERIA', RAND(), 20.1, 120.5, 'ASISTENCIA Y CONSULTARIA DE QUIENES TE ENSEÑAN EN ESTE LUGAR TENDRAS', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint,  circuit_Id) VALUES ( 'CENTRO DE INFORMATICA', 'CENTRO DE INFORMATICA', RAND(), 20.1, 120.5, 'LAS HERRAMIENTAS COMPUTACIONES EN ESTE PISO ENTERO ENCONTRARAS', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint,  circuit_Id) VALUES ( 'VICERRECTORIA ACADEMICA', 'VICERRECTORIA ACADEMICA', RAND(), 20.1, 120.5, 'CUANDO PROBLEMAS ACADÉMICOS ENCUENTRES, ESTE ES EL MÁXIMO ESTAMENTO A CONSULTAR', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint,  circuit_Id) VALUES ( 'RECTORIA', 'RECTORIA', RAND(), 20.1, 120.5, 'DESDE ALLÍ SE DIRIGE LA UAM', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint,  circuit_Id) VALUES ( 'BIBLIOTECA', 'BIBLIOTECA', RAND(), 20.1, 120.5, 'SILENCIO, ESPACIO Y CONOCIMIENTO ENCONTRARAS EN ESTE LUGAR', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint,  circuit_Id) VALUES ( 'CAJA', 'CAJA', RAND(), 20.1, 120.5, 'AQUÍ TU SEMESTRE Y LIBROS HAS DE PAGAR', 2);
INSERT  INTO node (name, description,code, latitude, longitude, hint,  circuit_Id) VALUES ( 'REGISTRO ACADEMICO', 'REGISTRO ACADEMICO', RAND(), 20.1, 120.5, 'EN ESTE LUGAR EL PROCESO DE INSCRIPCION ACENTARAS', 2);



INSERT  INTO question (question, answer, node_id) VALUES ( '¿CUÁL ES EL NOMBRE DEL COORDINADOR DE ÉSTE LUGAR?', 'WBEIMAR CANO RESTREPO', 1);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿CUÁL ES EL NOMBRE DE LA ZONA EN QUE ENCONTRARÁS REVISTAS ESPECIALIZADAS?', 'HEMEROTECA', 1);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿CUÁL ES EL NOMBRE DE LA SALA DE CONSULTA ELECTRÓNICA?', 'TELEMATICA', 1);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿CUÁL ES EL NOMBRE DE LA SALA DONDE VIDEOS Y PELÍCULAS PUEDES ENCONTRAR?', 'VIDEOTECA', 1);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿QUÉ BASE DE DATOS PUEDES CONSULTAR SI DIRECTAMENTE ARTÍCULOS CIENTÍFICOS QUIERES ENCONTRAR?', 'SCIENCE DIRECT', 1);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿CUÁL ES EL NOMBRE DE LA PERSONA QUE SIEMPRE ENCUENTRAS EN ESTE LUGAR?', 'JHON JAMES LOPEZ', 2);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿ADEMÁS DE LA MATRÍCULA ESTOS ELEMENTOS DE ESTUDIO ACÁ PUEDES PAGAR PARA LUEGO EN EL ALMACÉN RECLAMAR?', 'LIBROS', 2);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿CUÁL ES EL NOMBRE DEL COORDINADOR DE ÉSTE LUGAR?', 'YHON HENRY BARRETO MIRANDA', 3);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿QUÉ DOCUMENTO TE ENTREGARÁN EN ÉSTE LUGAR QUE TE SERVIRÁ PARA IDENTIFICARTE E INGRESAR A LA UAM?', 'CARNET ESTUDIANTIL', 3);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿CUÁL ES EL NOMBRE DEL COORDINADOR DE ÉSTE LUGAR?', 'SONIA PATRICIA VILLAMIL RODRIGUEZ', 4);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿INDICA CUAL ES EL CORREO GENERAL DE MERCADEO Y SERVICIO AL CLIENTE?', 'SERVICIOALCLIENTE@AUTONOMA.EDU.CO', 4);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿CUÁL ES EL NOMBRE DEL PROGRAMA DE MOVILIDAD ACADEMICA ENTRE COLOMBIA Y ARGENTINA?', 'MACA', 5);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿CUÁL ES EL NOMBRE DEL COORDINADOR DE ÉSTE LUGAR?', 'VIVIANA FERNANDA NIETO PADILLA', 5);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿CUÁL ES EL NOMBRE DEL COORDINADOR DE ÉSTE LUGAR?', 'CARMENZA GONZALEZ BURITICA', 6);
INSERT  INTO question (question, answer, node_id) VALUES ( 'DE ESTA INSTITUCIÓN GUBERNAMENTAL UN DELEGADO EN ESTA OFICINA ENCONTRARÁS, ¿CUAL ES SU NOMBRE?', 'ICETEX', 6);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿NOMBRA AL VICERRECTOR DE DESARROLLO HUMANO?', 'ALBERTO CARDONA AGUIRRE', 7);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿ELLA ES LA ENCARGADA DE ASIGNARTE CITAS Y RECIBIRTE EN ESTE LUGAR?', 'IRENE MARULANDA SALGADO', 8);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿ES UNO DE LOS ENCARGADOS Y SU PRIMER NOMBRE INICIA CON L Y EL SEGUNDO CON C?', 'LUIS CARLOS RIOS DIAZ', 9);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿CUÁL ES EL NOMBRE DEL COORDINADOR DE ÉSTE LUGAR?', 'HISNEL FRANCO MARQUEZ', 10);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿DI EL NOMBRE CON EL QUE SE CONOCE EL EDIFICIO EN QUE SE ENCUENTRA EL GIMNASIO?', 'SACATIN', 11);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿CUÁL ES EL CORRE DE ATENCIÓN GENERAL DE ESTE LUGAR?', 'GESTEC@AUTONOMA.EDU.CO', 12);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿CUÁL ES EL NOMBRE DE LA COMUNITY MANAGER UAM?', 'MARGARITA BENAVIDES', 12);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿CUÁL ES EL NOMBRE DE LA DECANO DE INGENIERIA?', 'ALBA PATRICIA ARIAS OSORIO', 13);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿CUAL ES EL NOMBRE DE LA AUXILIAR ADMINISTRATIVA DE INGENIERÍA EN EL DÍA?', 'BEATRIZ ALVARAN DAVILA', 13);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿CUAL ES EL NOMBRE DE LA AUXILIAR ADMINISTRATIVA DE INGENIERÍA EN LA NOCHE?', 'INES ARGELIA LOAIZA GARZON', 13);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿CUAL ES EL NOMBRE DE LA COORDINADORA DEL PROGRAMA DE INGENIERIA?', 'LINA MARIA LOPEZ URIBE', 14);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿NOMBRA AL PROFESOR CUYO CORREO ES JIMEZAM?', 'JORGE IVAN MEZA MARTINEZ', 14);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿INDICA EL NOMBRE DE LA ENCARGADA DEL CENTRO DE INFORMATICA?', 'MARTHA LILIA MORALES GONZALEZ', 15);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿NOMBRA AL VICERRECTOR ACADEMICO DE LA UAM?', 'IVAN ESCOBAR ESCOBAR', 16);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿NOMBRA AL RECTOR DE LA INSTITUCION?', 'GABRIEL CADENA GOMEZ', 17);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿CUÁL ES EL NOMBRE DEL COORDINADOR DE ÉSTE LUGAR?', 'WBEIMAR CANO RESTREPO', 18);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿CUÁL ES EL NOMBRE DE LA ZONA EN QUE ENCONTRARÁS REVISTAS ESPECIALIZADAS?', 'HEMEROTECA', 18);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿CUÁL ES EL NOMBRE DE LA SALA DE CONSULTA ELECTRÓNICA?', 'TELEMATICA', 18);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿CUÁL ES EL NOMBRE DE LA SALA DONDE VIDEOS Y PELÍCULAS PUEDES ENCONTRAR?', 'VIDEOTECA', 18);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿QUÉ BASE DE DATOS PUEDES CONSULTAR SI DIRECTAMENTE ARTÍCULOS CIENTÍFICOS QUIERES ENCONTRAR?', 'SCIENCE DIRECT', 18);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿CUÁL ES EL NOMBRE DE LA PERSONA QUE SIEMPRE ENCUENTRAS EN ESTE LUGAR?', 'JHON JAMES LOPEZ', 19);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿ADEMÁS DE LA MATRÍCULA ESTOS ELEMENTOS DE ESTUDIO ACÁ PUEDES PAGAR PARA LUEGO EN EL ALMACÉN RECLAMAR?', 'LIBROS', 19);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿CUÁL ES EL NOMBRE DEL COORDINADOR DE ÉSTE LUGAR?', 'YHON HENRY BARRETO MIRANDA', 19);
INSERT  INTO question (question, answer, node_id) VALUES ( '¿QUÉ DOCUMENTO TE ENTREGARÁN EN ÉSTE LUGAR QUE TE SERVIRÁ PARA IDENTIFICARTE E INGRESAR A LA UAM?', 'CARNET ESTUDIANTIL', 20);
