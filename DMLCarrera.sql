DROP TABLE IF EXISTS circuit;
CREATE TABLE circuit(
    id          int         NOT NULL AUTO_INCREMENT,
    name      VARCHAR(30) NOT NULL ,
    status      tinyint(1)  NOT NULL ,
    description VARCHAR(60),
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
    PRIMARY KEY (id, circuit_id, user_id),
    FOREIGN KEY (circuit_id)
    REFERENCES circuit(id),
    FOREIGN KEY (user_id)
    REFERENCES user(id)
);

DROP TABLE IF EXISTS node;
CREATE TABLE node(
    id            int         NOT NULL AUTO_INCREMENT,
    name        VARCHAR(30) NOT NULL ,
    description   VARCHAR(240),
    code        VARCHAR(60) NOT NULL ,
    latitude     VARCHAR(60) NOT NULL ,
    longitude     VARCHAR(60) NOT NULL ,
    hint         VARCHAR(240) NOT NULL ,
    circuit_id     int         NOT NULL ,
    PRIMARY KEY (id),
    FOREIGN KEY (circuit_id)
    REFERENCES circuit(id)
);

DROP TABLE IF EXISTS nodeDiscovered;
CREATE TABLE nodeDiscovered(
    id            int         NOT NULL AUTO_INCREMENT,
    node_id        int         NOT NULL ,
    user_id     int         NOT NULL ,
    status        tinyint(1)  NOT NULL ,
    statusDate1  DATETIME,
    statusDate2  DATETIME,
    statusDate3  DATETIME,
    PRIMARY KEY (id, node_id, user_id),
    FOREIGN KEY (node_id)
    REFERENCES node(id),
    FOREIGN KEY (user_id)
    REFERENCES user(id)
);

DROP TABLE IF EXISTS question;
CREATE TABLE question(
    id            int         NOT NULL AUTO_INCREMENT,
    question     VARCHAR(60) NOT NULL ,
    answer     VARCHAR(60) NOT NULL ,
    node_id        int         NOT NULL ,
    PRIMARY KEY (id),
    FOREIGN KEY (node_id)
    REFERENCES node(id)
);


INSERT  INTO circuit (name, status, description) VALUES ('COSem12016', 1,'Primera carrera de observación');

INSERT  INTO user (name, lastname, birthDate, email, password, color, gender, type) VALUES ('JULIAN MAURICIO', 'MEJIA CARDONA', '1984-01-28', 'jmmejia@autonoma.edu.co', MD5('123'), 'verde', 'hombre','administrador');
INSERT  INTO user (name, lastname, birthDate, email, password, color, gender, type) VALUES ('JORGE IVAN', 'MEZA MARTINEZ', '1978-04-14', 'jimezam@autonoma.edu.co', MD5('123'), 'azul', 'hombre','usuario');


INSERT  INTO node (name, description,code, latitude, longitude, hint, circuit_id) VALUES ( 'BIBLIOTECA', 'BIBLIOTECA', SHA('BIBLIOTECA'), '20','120', 'SILENCIO, ESPACIO Y CONOCIMIENTO ENCONTRARAS EN ESTE LUGAR', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint, circuit_id) VALUES ( 'CAJA', 'CAJA', SHA('CAJA'), '20','120', 'AQUÍ TU SEMESTRE Y LIBROS HAS DE PAGAR', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint, circuit_id) VALUES ( 'REGISTRO ACADEMICO', 'REGISTRO ACADEMICO', SHA('REGISTRO ACADEMICO'), '20','120', 'EN ESTE LUGAR EL PROCESO DE INSCRIPCION ACENTARAS', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint, circuit_id) VALUES ( 'MERCADEO', 'MERCADEO', SHA('MERCADEO'), '20','120', 'SUS ENCARGADOS LA OFERTA ACADEMICA Y AYUDA ADMINISTRATIVA TE OFRECERAN', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint, circuit_id) VALUES ( 'RELACIONES INTERNACIONALES', 'RELACIONES INTERNACIONALES', SHA('RELACIONES INTERNACIONALES'), '20','120', 'SI UN INTERCAMBIO QUIERES HACER A ESTE LUGAR DEBES LLEGAR', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint, circuit_id) VALUES ( 'CARTERA', 'CARTERA', SHA('CARTERA'), '20','120', 'PLAZOS DE FINANCIAMIENTO Y OPCIONES A PROBLEMAS ECONOMICAS ACA TE DARAN', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint, circuit_id) VALUES ( 'DESARROLLO HUMANO', 'DESARROLLO HUMANO', SHA('DESARROLLO HUMANO'), '20','120', 'SUS ENCARGADOS VELAN POR TU BIENESTAR MENTAL Y PSICOLOGICO, ADEMAS DE AYUDA CON DIFICULTADES ACADEMICAS', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint, circuit_id) VALUES ( 'SERVICIOS MEDICOS', 'SERVICIOS MEDICOS', SHA('SERVICIOS MEDICOS'), '20','120', 'EN ESTE SITIO ENCONTRARAS UN MEDICO QUE TE PUEDE INDICAR QUE TRATAMIENTO TOMAR', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint, circuit_id) VALUES ( 'ATENCION PREHOSPITALARIA', 'ATENCION PREHOSPITALARIA', SHA('ATENCION PREHOSPITALARIA'), '20','120', 'SI TE SIENTES FISICAMENTE MAL EN ESTE LUGAR UNA PERSONA PROFESIONAL TE ATENDERA', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint, circuit_id) VALUES ( 'LABORATORIO ELECTRONICA', 'LABORATORIO ELECTRONICA', SHA('LABORATORIO ELECTRONICA'), '20','120', 'LOS MONTAJES ELECTRONICOS Y EXPERIMENTOS FISICOS EN ESTE LUGAR DESARROLLARAS', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint, circuit_id) VALUES ( 'GIMNASIO', 'GIMNASIO', SHA('GIMNASIO'), '20','120', 'ALLI EJERCICIO, JUGAR Y LIBERAR TENSION PUEDES REALIZAR', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint, circuit_id) VALUES ( 'GESTION DE TECNOLOGIA', 'GESTION DE TECNOLOGIA', SHA('GESTION DE TECNOLOGIA'), '20','120', 'UNA FORMA DIFERENTE DE COMUNICARTE ALLI APRENDERAS', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint, circuit_id) VALUES ( 'DECANATURA INGENIERIA', 'DECANATURA INGENIERIA', SHA('DECANATURA INGENIERIA'), '20','120', 'OLVIDO DE CONTRASEÑAS Y PROBLEMAS DE INGRESO A LOS SISTEMAS AQUÍ TE SOLUCIONARAN', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint, circuit_id) VALUES ( 'SALA DE PROFESORES DE INGENIERIA', 'SALA DE PROFESORES DE INGENIERIA', SHA('SALA DE PROFESORES DE INGENIERIA'), '20','120', 'LOS PROCESOS ACADEMICOS DESDE ALLÍ SE GOBERNARAN', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint, circuit_id) VALUES ( 'CENTRO DE INFORMATICA', 'CENTRO DE INFORMATICA', SHA('CENTRO DE INFORMATICA'), '20','120', 'ASISTENCIA Y CONSULTARIA DE QUIENES TE ENSEÑAN EN ESTE LUGAR TENDRAS', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint, circuit_id) VALUES ( 'VICERRECTORIA ACADEMICA', 'VICERRECTORIA ACADEMICA', SHA('VICERRECTORIA ACADEMICA'), '20','120', 'LAS HERRAMIENTAS COMPUTACIONES EN ESTE PISO ENTERO ENCONTRARAS', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint, circuit_id) VALUES ( 'RECTORIA', 'RECTORIA', SHA('RECTORIA'), '20','120', 'CUANDO PROBLEMAS ACADÉMICOS ENCUENTRES, ESTE ES EL MÁXIMO ESTAMENTO A CONSULTAR', 1);
INSERT  INTO node (name, description,code, latitude, longitude, hint, circuit_id) VALUES ( 'VICERRECTORIA ADMINISTRATIVA', 'VICERRECTORIA ADMINISTRATIVA', SHA('VICERRECTORIA ADMINISTRATIVA'), '20','120', 'DESDE ALLÍ SE DIRIGE LA UAM', 1);



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
INSERT  INTO question (question, answer, node_id) VALUES ( '¿NOMBRA AL VICERRECTOR ADMINISTRATIVO DE LA UAM?', 'CARLOS EDUARDO JARAMILLO SANINT', 18);
