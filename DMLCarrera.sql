DROP TABLE IF EXISTS carrera;
CREATE TABLE carrera(
    id          int         NOT NULL AUTO_INCREMENT,
    nombre      VARCHAR(30) NOT NULL ,
    estado      tinyint(1)  NOT NULL ,
    descripcion VARCHAR(60),
    PRIMARY KEY (id)
);


DROP TABLE IF EXISTS usuario;
CREATE TABLE usuario(
    id          int         NOT NULL  AUTO_INCREMENT,
    nombres     VARCHAR(30) NOT NULL  ,
    apellidos   VARCHAR(30) NOT NULL ,
    fechaNacimiento DATE NOT NULL ,
    mail        VARCHAR(60) NOT NULL,
    color       VARCHAR(60)  NOT NULL ,
    genero      VARCHAR(20) NOT NULL ,
    tipo        VARCHAR(20) NOT NULL ,
    PRIMARY KEY (id),
    UNIQUE (mail)
);

DROP TABLE IF EXISTS inscripcion;
CREATE TABLE inscripcion(
    id            int         NOT NULL  AUTO_INCREMENT,
    carreraId     int         NOT NULL ,
    usuarioId     int         NOT NULL ,
    PRIMARY KEY (id, carreraId, usuarioId),
    FOREIGN KEY (carreraId)
    REFERENCES carrera(id),
    FOREIGN KEY (usuarioId)
    REFERENCES usuario(id)
);

DROP TABLE IF EXISTS nodo;
CREATE TABLE nodo(
    id            int         NOT NULL AUTO_INCREMENT,
    nombre        VARCHAR(30) NOT NULL ,
    descripcion   VARCHAR(60),
    codigo        VARCHAR(60) NOT NULL ,
    ubicacion     VARCHAR(60) NOT NULL ,
    pista         VARCHAR(60) NOT NULL ,
    carreraId     int         NOT NULL ,
    PRIMARY KEY (id),
    FOREIGN KEY (carreraId)
    REFERENCES carrera(id)
);

DROP TABLE IF EXISTS nodoDescubierto;
CREATE TABLE nodoDescubierto(
    id            int         NOT NULL AUTO_INCREMENT,
    nodoId        int         NOT NULL ,
    usuarioId     int         NOT NULL ,
    estado        tinyint(1)  NOT NULL ,
    fechaEstado1  DATETIME,
    fechaEstado2  DATETIME,
    fechaEstado3  DATETIME,
    PRIMARY KEY (id, nodoId, usuarioId),
    FOREIGN KEY (nodoId)
    REFERENCES nodo(id),
    FOREIGN KEY (usuarioId)
    REFERENCES usuario(id)
);

DROP TABLE IF EXISTS pregunta;
CREATE TABLE pregunta(
    id            int         NOT NULL AUTO_INCREMENT,
    enunciado     VARCHAR(60) NOT NULL ,
    respuesta     VARCHAR(60) NOT NULL ,
    nodoId        int         NOT NULL ,
    PRIMARY KEY (id),
    FOREIGN KEY (nodoId)
    REFERENCES nodo(id)
);


INSERT  INTO carrera (nombre, estado, descripcion) VALUES ('COSem12016', 1,'Primera carrera de observación');

INSERT  INTO usuario (nombres, apellidos, fechaNacimiento, mail, color, genero, tipo) VALUES ('JULIAN MAURICIO', 'MEJIA CARDONA', '28/01/1984', 'jmmejia@autonoma.edu.co', 'verde', 'hombre','administrador');
INSERT  INTO usuario (nombres, apellidos, fechaNacimiento, mail, color, genero, tipo) VALUES ('JORGE IVAN', 'MEZA MARTINEZ', '14/04/1978', 'jimezam@autonoma.edu.co', 'azul', 'hombre','usuario');


INSERT  INTO nodo (nombre, descripcion,codigo, ubicacion, pista, carreraId) VALUES ( 'BIBLIOTECA', 'BIBLIOTECA', 'www.autonoma.edu.co/biblioteca', '20,120', 'SILENCIO, ESPACIO Y CONOCIMIENTO ENCONTRARAS EN ESTE LUGAR', 1);
INSERT  INTO nodo (nombre, descripcion,codigo, ubicacion, pista, carreraId) VALUES ( 'CAJA', 'CAJA', 'www.autonoma.edu.co/caja', '20,120', 'AQUÍ TU SEMESTRE Y LIBROS HAS DE PAGAR', 1);
INSERT  INTO nodo (nombre, descripcion,codigo, ubicacion, pista, carreraId) VALUES ( 'REGISTRO ACADEMICO', 'REGISTRO ACADEMICO', 'www.autonoma.edu.co/registro_academico', '20,120', 'EN ESTE LUGAR EL PROCESO DE INSCRIPCION ACENTARAS', 1);
INSERT  INTO nodo (nombre, descripcion,codigo, ubicacion, pista, carreraId) VALUES ( 'MERCADEO', 'MERCADEO', 'www.autonoma.edu.co/mercadeo', '20,120', 'SUS ENCARGADOS LA OFERTA ACADEMICA Y AYUDA ADMINISTRATIVA TE OFRECERAN', 1);
INSERT  INTO nodo (nombre, descripcion,codigo, ubicacion, pista, carreraId) VALUES ( 'RELACIONES INTERNACIONALES', 'RELACIONES INTERNACIONALES', 'www.autonoma.edu.co/relaciones_internacionales', '20,120', 'SI UN INTERCAMBIO QUIERES HACER A ESTE LUGAR DEBES LLEGAR', 1);
INSERT  INTO nodo (nombre, descripcion,codigo, ubicacion, pista, carreraId) VALUES ( 'CARTERA', 'CARTERA', 'www.autonoma.edu.co/cartera', '20,120', 'PLAZOS DE FINANCIAMIENTO Y OPCIONES A PROBLEMAS ECONOMICAS ACA TE DARAN', 1);
INSERT  INTO nodo (nombre, descripcion,codigo, ubicacion, pista, carreraId) VALUES ( 'DESARROLLO HUMANO', 'DESARROLLO HUMANO', 'www.autonoma.edu.co/desarrollo_humano', '20,120', 'SUS ENCARGADOS VELAN POR TU BIENESTAR MENTAL Y PSICOLOGICO, ADEMAS DE AYUDA CON DIFICULTADES ACADEMICAS', 1);
INSERT  INTO nodo (nombre, descripcion,codigo, ubicacion, pista, carreraId) VALUES ( 'SERVICIOS MEDICOS', 'SERVICIOS MEDICOS', 'www.autonoma.edu.co/servicios_medicos', '20,120', 'EN ESTE SITIO ENCONTRARAS UN MEDICO QUE TE PUEDE INDICAR QUE TRATAMIENTO TOMAR', 1);
INSERT  INTO nodo (nombre, descripcion,codigo, ubicacion, pista, carreraId) VALUES ( 'ATENCION PREHOSPITALARIA', 'ATENCION PREHOSPITALARIA', 'www.autonoma.edu.co/atencion_prehospitalaria', '20,120', 'SI TE SIENTES FISICAMENTE MAL EN ESTE LUGAR UNA PERSONA PROFESIONAL TE ATENDERA', 1);
INSERT  INTO nodo (nombre, descripcion,codigo, ubicacion, pista, carreraId) VALUES ( 'LABORATORIO ELECTRONICA', 'LABORATORIO ELECTRONICA', 'www.autonoma.edu.co/laboratorio_electronica', '20,120', 'LOS MONTAJES ELECTRONICOS Y EXPERIMENTOS FISICOS EN ESTE LUGAR DESARROLLARAS', 1);
INSERT  INTO nodo (nombre, descripcion,codigo, ubicacion, pista, carreraId) VALUES ( 'GIMNASIO', 'GIMNASIO', 'www.autonoma.edu.co/gimnasio', '20,120', 'ALLI EJERCICIO, JUGAR Y LIBERAR TENSION PUEDES REALIZAR', 1);
INSERT  INTO nodo (nombre, descripcion,codigo, ubicacion, pista, carreraId) VALUES ( 'GESTION DE TECNOLOGIA', 'GESTION DE TECNOLOGIA', 'www.autonoma.edu.co/laboratorio_de_ingles', '20,120', 'UNA FORMA DIFERENTE DE COMUNICARTE ALLI APRENDERAS', 1);
INSERT  INTO nodo (nombre, descripcion,codigo, ubicacion, pista, carreraId) VALUES ( 'DECANATURA INGENIERIA', 'DECANATURA INGENIERIA', 'www.autonoma.edu.co/gestion_de_tecnologia', '20,120', 'OLVIDO DE CONTRASEÑAS Y PROBLEMAS DE INGRESO A LOS SISTEMAS AQUÍ TE SOLUCIONARAN', 1);
INSERT  INTO nodo (nombre, descripcion,codigo, ubicacion, pista, carreraId) VALUES ( 'SALA DE PROFESORES DE INGENIERIA', 'SALA DE PROFESORES DE INGENIERIA', 'www.autonoma.edu.co/decanatura_ingenieria', '20,120', 'LOS PROCESOS ACADEMICOS DESDE ALLÍ SE GOBERNARAN', 1);
INSERT  INTO nodo (nombre, descripcion,codigo, ubicacion, pista, carreraId) VALUES ( 'CENTRO DE INFORMATICA', 'CENTRO DE INFORMATICA', 'www.autonoma.edu.co/sala_de_profesores_de_ingenieria', '20,120', 'ASISTENCIA Y CONSULTARIA DE QUIENES TE ENSEÑAN EN ESTE LUGAR TENDRAS', 1);
INSERT  INTO nodo (nombre, descripcion,codigo, ubicacion, pista, carreraId) VALUES ( 'VICERRECTORIA ACADEMICA', 'VICERRECTORIA ACADEMICA', 'www.autonoma.edu.co/centro_de_informatica', '20,120', 'LAS HERRAMIENTAS COMPUTACIONES EN ESTE PISO ENTERO ENCONTRARAS', 1);
INSERT  INTO nodo (nombre, descripcion,codigo, ubicacion, pista, carreraId) VALUES ( 'RECTORIA', 'RECTORIA', 'www.autonoma.edu.co/vicerrectoria_academica', '20,120', 'CUANDO PROBLEMAS ACADÉMICOS ENCUENTRES, ESTE ES EL MÁXIMO ESTAMENTO A CONSULTAR', 1);
INSERT  INTO nodo (nombre, descripcion,codigo, ubicacion, pista, carreraId) VALUES ( 'VICERRECTORIA ADMINISTRATIVA', 'VICERRECTORIA ADMINISTRATIVA', 'www.autonoma.edu.co/rectoria', '20,120', 'DESDE ALLÍ SE DIRIGE LA UAM', 1);



INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿CUÁL ES EL NOMBRE DEL COORDINADOR DE ÉSTE LUGAR?', 'WBEIMAR CANO RESTREPO', 1);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿CUÁL ES EL NOMBRE DE LA ZONA EN QUE ENCONTRARÁS REVISTAS ESPECIALIZADAS?', 'HEMEROTECA', 1);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿CUÁL ES EL NOMBRE DE LA SALA DE CONSULTA ELECTRÓNICA?', 'TELEMATICA', 1);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿CUÁL ES EL NOMBRE DE LA SALA DONDE VIDEOS Y PELÍCULAS PUEDES ENCONTRAR?', 'VIDEOTECA', 1);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿QUÉ BASE DE DATOS PUEDES CONSULTAR SI DIRECTAMENTE ARTÍCULOS CIENTÍFICOS QUIERES ENCONTRAR?', 'SCIENCE DIRECT', 1);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿CUÁL ES EL NOMBRE DE LA PERSONA QUE SIEMPRE ENCUENTRAS EN ESTE LUGAR?', 'JHON JAMES LOPEZ', 2);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿ADEMÁS DE LA MATRÍCULA ESTOS ELEMENTOS DE ESTUDIO ACÁ PUEDES PAGAR PARA LUEGO EN EL ALMACÉN RECLAMAR?', 'LIBROS', 2);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿CUÁL ES EL NOMBRE DEL COORDINADOR DE ÉSTE LUGAR?', 'YHON HENRY BARRETO MIRANDA', 3);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿QUÉ DOCUMENTO TE ENTREGARÁN EN ÉSTE LUGAR QUE TE SERVIRÁ PARA IDENTIFICARTE E INGRESAR A LA UAM?', 'CARNET ESTUDIANTIL', 3);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿CUÁL ES EL NOMBRE DEL COORDINADOR DE ÉSTE LUGAR?', 'SONIA PATRICIA VILLAMIL RODRIGUEZ', 4);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿INDICA CUAL ES EL CORREO GENERAL DE MERCADEO Y SERVICIO AL CLIENTE?', 'SERVICIOALCLIENTE@AUTONOMA.EDU.CO', 4);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿CUÁL ES EL NOMBRE DEL PROGRAMA DE MOVILIDAD ACADEMICA ENTRE COLOMBIA Y ARGENTINA?', 'MACA', 5);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿CUÁL ES EL NOMBRE DEL COORDINADOR DE ÉSTE LUGAR?', 'VIVIANA FERNANDA NIETO PADILLA', 5);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿CUÁL ES EL NOMBRE DEL COORDINADOR DE ÉSTE LUGAR?', 'CARMENZA GONZALEZ BURITICA', 6);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( 'DE ESTA INSTITUCIÓN GUBERNAMENTAL UN DELEGADO EN ESTA OFICINA ENCONTRARÁS, ¿CUAL ES SU NOMBRE?', 'ICETEX', 6);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿NOMBRA AL VICERRECTOR DE DESARROLLO HUMANO?', 'ALBERTO CARDONA AGUIRRE', 7);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿ELLA ES LA ENCARGADA DE ASIGNARTE CITAS Y RECIBIRTE EN ESTE LUGAR?', 'IRENE MARULANDA SALGADO', 8);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿ES UNO DE LOS ENCARGADOS Y SU PRIMER NOMBRE INICIA CON L Y EL SEGUNDO CON C?', 'LUIS CARLOS RIOS DIAZ', 9);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿CUÁL ES EL NOMBRE DEL COORDINADOR DE ÉSTE LUGAR?', 'HISNEL FRANCO MARQUEZ', 10);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿DI EL NOMBRE CON EL QUE SE CONOCE EL EDIFICIO EN QUE SE ENCUENTRA EL GIMNASIO?', 'SACATIN', 11);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿CUÁL ES EL CORRE DE ATENCIÓN GENERAL DE ESTE LUGAR?', 'GESTEC@AUTONOMA.EDU.CO', 12);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿CUÁL ES EL NOMBRE DE LA COMUNITY MANAGER UAM?', 'MARGARITA BENAVIDES', 12);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿CUÁL ES EL NOMBRE DE LA DECANO DE INGENIERIA?', 'ALBA PATRICIA ARIAS OSORIO', 13);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿CUAL ES EL NOMBRE DE LA AUXILIAR ADMINISTRATIVA DE INGENIERÍA EN EL DÍA?', 'BEATRIZ ALVARAN DAVILA', 13);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿CUAL ES EL NOMBRE DE LA AUXILIAR ADMINISTRATIVA DE INGENIERÍA EN LA NOCHE?', 'INES ARGELIA LOAIZA GARZON', 13);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿CUAL ES EL NOMBRE DE LA COORDINADORA DEL PROGRAMA DE INGENIERIA?', 'LINA MARIA LOPEZ URIBE', 14);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿NOMBRA AL PROFESOR CUYO CORREO ES JIMEZAM?', 'JORGE IVAN MEZA MARTINEZ', 14);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿INDICA EL NOMBRE DE LA ENCARGADA DEL CENTRO DE INFORMATICA?', 'MARTHA LILIA MORALES GONZALEZ', 15);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿NOMBRA AL VICERRECTOR ACADEMICO DE LA UAM?', 'IVAN ESCOBAR ESCOBAR', 16);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿NOMBRA AL RECTOR DE LA INSTITUCION?', 'GABRIEL CADENA GOMEZ', 17);
INSERT  INTO pregunta (enunciado, respuesta, nodoId) VALUES ( '¿NOMBRA AL VICERRECTOR ADMINISTRATIVO DE LA UAM?', 'CARLOS EDUARDO JARAMILLO SANINT', 18);
