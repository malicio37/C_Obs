<?php
/**
 * Step 1: Require the Slim Framework
 *
 * If you are not using Composer, you need to require the
 * Slim Framework and register its PSR-0 autoloader.
 */
require 'Slim/Slim.php';

\Slim\Slim::registerAutoloader();

/**
 * Step 2: Instantiate a Slim application
 */
$app = new \Slim\Slim(array(
	'debug' => true,
  'MODE'  => 'development'
));

$request  = $app -> request();
$response = $app -> response();

// $response -> headers -> set('Content-Type', 'application/json');

$response -> headers -> set('Access-Control-Allow-Origin', '*');
$response -> headers -> set('Access-Control-Allow-Methods', "POST, GET, OPTIONS, PATCH, PUT, DELETE");
// $response -> headers -> set('Access-Control-Allow-Headers', 'accept, origin, content-type');
$response -> headers -> set('Access-Control-Allow-Headers', 'X-PINGOTHER');
$response -> headers -> set('Access-Control-Max-Age', '1728000');
$response -> headers -> set('Access-Control-Allow-Headers', 'Authorization');

define('BD_SERVIDOR', 'localhost');
define('BD_NOMBRE', 'carrera');
define('BD_USUARIO', 'root');
define('BD_PASSWORD', '');


$db = new PDO('mysql:host=' . BD_SERVIDOR . ';dbname=' . BD_NOMBRE . ';charset=utf8', BD_USUARIO, BD_PASSWORD);

$db -> setAttribute(PDO::ATTR_ERRMODE,
                    PDO::ERRMODE_EXCEPTION);

////////////////////////////////////////////////////////////////////////////////

$app->get('/', function() {
            echo "Pagina de gestión API REST de mi aplicación.";
        });

$app->get('/nodo', 'getNodos');
$app->get('/carrera', 'getCarreras');
$app->get('/usuario', 'getUsuarios');
$app->get('/pregunta', 'getPreguntas');
$app->get('/inscripcion', 'getInscripciones');
$app->get('/nodoDescubierto', 'getNodosDescubiertos');


$app->get('/nodo/:id', 'getNodo');
$app->get('/carrera/:id', 'getCarrera');
$app->get('/usuario/:mail', 'getUsuario');
$app->get('/pregunta/:id', 'getPregunta');
$app->get('/nodoDescubierto/:id', 'getNodoDescubierto');
$app->get('/inscripcion/:id', 'getInscripcion');

$app->post('/carrera', 'addCarrera');
$app->post('/usuario', 'addUsuario');
$app->post('/nodo', 'addNodo');
$app->post('/pregunta', 'addPregunta');
$app->post('/inscripcion', 'addInscripcion');
$app->post('/nodoDescubierto', 'addNodoDescubierto');


//actualizaciones completas de los elementos PUT


//get login con los datos ocultos
$app->post('/usuario/login', 'getLogin2');

/*filtre carreras en las que el usuario se encuentra inscrito y la carrera se encuentra activa
 *@param mail  el correo del usuario
 */
$app->post('/carrerasInscritas', 'getCarrerasInscritas');

//desactivar todas las carreras
$app->put('/carrera', 'desactivarCarreras');

//actualizar el estado de una carrera específica
$app->put('/carrera/:id', 'actualizarEstadoCarrera');







function getNodos(){
	global $db, $response;
    $sql = "select * FROM nodo ORDER BY id";
    try {
        $stmt = $db->query($sql);
        $nodos = $stmt->fetchAll(PDO::FETCH_OBJ);
        $response->write( json_encode($nodos));
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
}

function getCarreras(){
	global $db, $response;
    $sql = "select * FROM carrera ORDER BY id";
    try {
        $stmt = $db->query($sql);
        $carreras = $stmt->fetchAll(PDO::FETCH_OBJ);
        $response->write( json_encode($carreras));
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
}

function getUsuarios(){
	global $db, $response;
    $sql = "select * FROM usuario ORDER BY id";
    try {
        $stmt = $db->query($sql);
        $usuarios = $stmt->fetchAll(PDO::FETCH_OBJ);
        $response->write( json_encode($usuarios));
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
}

function getPreguntas(){
	global $db, $response;
    $sql = "select * FROM pregunta ORDER BY id";
    try {
        $stmt = $db->query($sql);
        $preguntas = $stmt->fetchAll(PDO::FETCH_OBJ);
        $response->write( json_encode($preguntas));
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
}


function getInscripciones(){
	global $db, $response;
    $sql = "select * FROM inscripcion ORDER BY id";
    try {
        $stmt = $db->query($sql);
        $inscripciones = $stmt->fetchAll(PDO::FETCH_OBJ);
        $response->write( json_encode($inscripciones));
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
}

function getNodosDescubiertos(){
	global $db, $response;
    $sql = "select * FROM nododescubierto ORDER BY id";
    try {
        $stmt = $db->query($sql);
        $nodosDescubiertos = $stmt->fetchAll(PDO::FETCH_OBJ);
        $response->write( json_encode($nodosDescubiertos));
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
}



function getNodo($id){
	global $db;
     $sql = "SELECT * FROM nodo WHERE id=:id";
     try {

        $stmt = $db->prepare($sql);
        $stmt->bindParam("id", $id);
        $stmt->execute();
        $nodo = $stmt->fetchObject();

        echo json_encode($nodo);
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
 }

 function getCarrera($id){
 	global $db;
      $sql = "SELECT nombre FROM carrera WHERE id=:id";
      try {

         $stmt = $db->prepare($sql);
         $stmt->bindParam("id", $id);
         $stmt->execute();
         $carrera = $stmt->fetchObject();
         echo json_encode($carrera);
     } catch(PDOException $e) {
         echo '{"error":{"text":'. $e->getMessage() .'}}';
     }
  }

	function getUsuario($mail){
		global $db;
	     $sql = "SELECT * FROM usuario WHERE mail=:mail";
	     try {

	        $stmt = $db->prepare($sql);
	        $stmt->bindParam("mail", $mail);
	        $stmt->execute();
	        $usuario = $stmt->fetchObject();

	        echo json_encode($usuario);
	    } catch(PDOException $e) {
	        echo '{"error":{"text":'. $e->getMessage() .'}}';
	    }
	 }

	 function getPregunta($id){
	 	global $db, $response;
	     $sql = "SELECT * FROM pregunta WHERE id=:id";
			 try {
          $stmt = $db->prepare($sql);
          $stmt->bindParam("id", $id);
          $stmt->execute();
          $pregunta = $stmt->fetchObject();
          echo json_encode($pregunta);
      } catch(PDOException $e) {
          echo '{"error":{"text":'. $e->getMessage() .'}}';
      }
	 }


	 function getNodoDescubierto($id){
	 	global $db, $response;
	     $sql = "SELECT * FROM nododescubierto WHERE id=:id";
			 try {
          $stmt = $db->prepare($sql);
          $stmt->bindParam("id", $id);
          $stmt->execute();
          $nododescubierto = $stmt->fetchObject();
          echo json_encode($nododescubierto);
      } catch(PDOException $e) {
          echo '{"error":{"text":'. $e->getMessage() .'}}';
      }
	 }

	 function getInscripcion($id){
		global $db, $response;
			 $sql = "SELECT * FROM inscripcion WHERE id=:id";
			 try {
					 $stmt = $db->prepare($sql);
					 $stmt->bindParam("id", $id);
					 $stmt->execute();
					 $inscripcion = $stmt->fetchObject();
					 echo json_encode($inscripcion);
			 } catch(PDOException $e) {
					 echo '{"error":{"text":'. $e->getMessage() .'}}';
			 }
	 }


	function addInscripcion() {
	 global $db, $request;
		 //si estado = 1 requiere un update antes de hacer el insert
		 $inscripcion = json_decode($request->getBody());
	 	 $sql = "INSERT INTO inscripcion (carreraId, usuarioId) VALUES (:carreraId, :usuarioId)";
		 try {
				 $stmt = $db->prepare($sql);
				 $stmt->bindParam("carreraId", $inscripcion->carreraId);
				 $stmt->bindParam("usuarioId", $inscripcion->usuarioId);
				 $stmt->execute();
				 $inscripcion->id = $db->lastInsertId();
				 echo json_encode($inscripcion);
		 } catch(PDOException $e) {
				 echo '{"error":{"text":'. $e->getMessage() .'}}';
		 }
	}

	//{"carreraId":1, "usuarioId":1}
	//{"carreraId":1, "usuarioId":2}
	//{"carreraId":2, "usuarioId":1}


	function addNodoDescubierto() {
	 global $db, $request;
		 //si estado = 1 requiere un update antes de hacer el insert
		 $nododescubierto = json_decode($request->getBody());
	 $sql = "INSERT  INTO nododescubierto (nodoId, usuarioId, estado, fechaEstado1, fechaEstado2, fechaEstado3) VALUES (:nodoId, :usuarioId, :estado, :fechaEstado1, :fechaEstado2, :fechaEstado3)";
		 try {

				 $stmt = $db->prepare($sql);
				 $stmt->bindParam("nodoId", $nododescubierto->nodoId);
				 $stmt->bindParam("usuarioId", $nododescubierto->usuarioId);
		 	 	 $stmt->bindParam("estado", $nododescubierto->estado);
				 $stmt->bindParam("fechaEstado1", $nododescubierto->fechaEstado1);
				 $stmt->bindParam("fechaEstado2", $nododescubierto->fechaEstado2);
				 $stmt->bindParam("fechaEstado3", $nododescubierto->fechaEstado3);
				 $stmt->execute();
				 $nododescubierto->id = $db->lastInsertId();

				 echo json_encode($nododescubierto);
		 } catch(PDOException $e) {
				 echo '{"error":{"text":'. $e->getMessage() .'}}';
		 }
	}
//{"nodoId":1, "usuarioId":1,"estado": 0, "fechaEstado1":"2016-06-10 15:32:31"}


 function addCarrera() {
	global $db, $request;
    //si estado = 1 requiere un update antes de hacer el insert
    $carrera = json_decode($request->getBody());
	$sql = "INSERT  INTO carrera (nombre, estado, descripcion) VALUES (:nombre, :estado, :descripcion)";
    try {

        $stmt = $db->prepare($sql);
        $stmt->bindParam("nombre", $carrera->nombre);
        $stmt->bindParam("estado", $carrera->estado);
		$stmt->bindParam("descripcion", $carrera->descripcion);
        $stmt->execute();
        $carrera->id = $db->lastInsertId();

        echo json_encode($carrera);
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
}
//{"nombre":"nn","estado":1,"descripcion":"prueba"}

function addUsuario() {
 global $db, $request;
	 //si estado = 1 requiere un update antes de hacer el insert
	 $usuario = json_decode($request->getBody());
 $sql = "INSERT  INTO usuario (nombres, apellidos, fechaNacimiento, mail, color, genero, tipo) VALUES (:nombres, :apellidos, :fechaNacimiento, :mail, :color, :genero, :tipo)";
	 try {

			 $stmt = $db->prepare($sql);
			 $stmt->bindParam("nombres", $usuario->nombres);
			 $stmt->bindParam("apellidos", $usuario->apellidos);
			 $stmt->bindParam("fechaNacimiento", $usuario->fechaNacimiento);
			 $stmt->bindParam("mail", $usuario->mail);
			 $stmt->bindParam("color", $usuario->color);
			 $stmt->bindParam("genero", $usuario->genero);
			 $stmt->bindParam("tipo", $usuario->tipo);
			 $stmt->execute();
			 $usuario->id = $db->lastInsertId();
			 echo json_encode($usuario);
	 } catch(PDOException $e) {
			 echo '{"error":{"text":'. $e->getMessage() .'}}';
	 }
}
//{"nombres":"nn", "apellidos":"nn","fechaNacimiento":"1984-01-28","mail":"@algo","color":"#5454545","genero":"hombre","tipo":"usuario"}


function addNodo() {
 global $db, $request;
	 //si estado = 1 requiere un update antes de hacer el insert
	 $nodo = json_decode($request->getBody());
 	 $sql = "INSERT INTO nodo (nombre, descripcion, codigo, ubicacion, pista, carreraId) VALUES (:nombre, :descripcion, :codigo, :ubicacion, :pista, :carreraId)";
	 try {
			 $stmt = $db->prepare($sql);
			 $stmt->bindParam("nombre", $nodo->nombre);
			 $stmt->bindParam("descripcion", $nodo->descripcion);
			 $stmt->bindParam("codigo", $nodo->codigo);
			 $stmt->bindParam("ubicacion", $nodo->ubicacion);
			 $stmt->bindParam("pista", $nodo->pista);
			 $stmt->bindParam("carreraId", $nodo->carreraId);
			 $stmt->execute();
			 $nodo->id = $db->lastInsertId();
			 echo json_encode($nodo);
	 } catch(PDOException $e) {
			 echo '{"error":{"text":'. $e->getMessage() .'}}';
	 }
}
//{"nombre":"nn", "descripcion":"nn","codigo":"1984-01-28","ubicacion":"@algo","pista":"#5454545","carreraId":2}

function addPregunta() {
 global $db, $request;
	 //si estado = 1 requiere un update antes de hacer el insert
	 $pregunta = json_decode($request->getBody());
 	 $sql = "INSERT INTO pregunta (enunciado, respuesta, nodoId) VALUES (:enunciado, :respuesta, :nodoId)";
	 try {
			 $stmt = $db->prepare($sql);
			 $stmt->bindParam("enunciado", $pregunta->enunciado);
			 $stmt->bindParam("respuesta", $pregunta->respuesta);
			 $stmt->bindParam("nodoId", $pregunta->nodoId);
			 $stmt->execute();
			 $pregunta->id = $db->lastInsertId();
			 echo json_encode($pregunta);
	 } catch(PDOException $e) {
			 echo '{"error":{"text":'. $e->getMessage() .'}}';
	 }
}
//{"enunciado":"nn", "respuesta":"nn","nodoId":2}





 function getLogin2() {
	global $db, $request;
    //si estado = 1 requiere un update antes de hacer el insert
    $usuario = json_decode($request->getBody());
	$sql = "SELECT * FROM usuario WHERE mail=:mail";
    try {

        $stmt = $db->prepare($sql);
        $stmt->bindParam("mail", $usuario->correo);

        $stmt->execute();
				$usuario = $stmt->fetchObject();

        echo json_encode($usuario);
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
}

//{"correo":"jmmejia@autonoma.edu.co"}

//response: false if doesn't exist, userData in other case
function actualizarEstadoCarrera($id) {
    global $db, $request;
    $body = $request->getBody();
    $carrera = json_decode($body);
    $sql = "UPDATE carrera SET estado=:estado WHERE id=:id ";
    try {
        $stmt = $db->prepare($sql);
        $stmt->bindParam("estado", $carrera->estado);
        $stmt->bindParam("id", $id);
        $stmt->execute();
        echo json_encode($carrera);
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
}
//{"estado":"0"}


//cambiar todas las carreras a un estado específico (0)
function desactivarCarreras() {
    global $db, $request;
    $body = $request->getBody();
    $carrera = json_decode($body);
    $sql = "UPDATE carrera SET estado=:estado";
    try {
        $stmt = $db->prepare($sql);
        $stmt->bindParam("estado", $carrera->estado);
        $stmt->execute();
        echo json_encode($carrera);
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
}

function getCarrerasInscritas(){
 global $db, $request, $response;
 $inscripcion = json_decode($request->getBody());

		 /*filtre carreras en las que el usuario se encuentra inscrito y la carrera se encuentra activa
			*@param mail  el correo del usuario
			*/
		 $sql = "SELECT carrera.id, carrera.nombre FROM carrera INNER JOIN (SELECT carreraId FROM inscripcion
						 WHERE usuarioId=:usuarioId)AS a ON carrera.id=a.carreraId WHERE carrera.estado=1";
		 try {
				$stmt = $db->prepare($sql);
				$stmt->bindParam("usuarioId", $inscripcion->usuarioId);
				$stmt->execute();
				$inscripcion = $stmt->fetchAll(PDO::FETCH_OBJ);
				$response->write( json_encode($inscripcion));
		} catch(PDOException $e) {
				echo '{"error":{"text":'. $e->getMessage() .'}}';
		}
 }
//{"usuarioId":1}


$app->run();

?>
