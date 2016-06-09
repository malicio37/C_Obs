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


$app->get('/nodo', 'getNodos');
$app->get('/nodo/:id', 'getNodo');
$app->post('/carrera', 'addCarrera');
$app->post('/usuario', 'addUsuario');
$app->post('/usuario/login', 'getLogin2');
$app->put('/carrera/:id', 'actualizarEstadoCarrera');
$app->put('/carrera', 'desactivarCarreras');
$app->get('/usuario/:mail', 'getLogin');

$app->get('/', function() {
            echo "Pagina de gestión API REST de mi aplicación.";
        });


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

 function addCarrera() {
	global $db, $request;
    //si estado = 1 requiere un update antes de hacer el insert
    $carrera = json_decode($request->getBody());
	$sql = "INSERT  INTO carrera (id, nombre, estado, descripcion) VALUES (:id, :nombre, :estado, :descripcion)";
    try {

        $stmt = $db->prepare($sql);
        $stmt->bindParam("id", $carrera->id);
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


function addUsuario() {
 global $db, $request;
	 //si estado = 1 requiere un update antes de hacer el insert
	 $usuario = json_decode($request->getBody());
 $sql = "INSERT  INTO usuario (id, nombres, apellidos, fechaNacimiento, mail, color, genero, tipo) VALUES (:id, :nombres, :apellidos, :fechaNacimiento, :mail, :color, :genero, :tipo)";
	 try {

			 $stmt = $db->prepare($sql);
			 $stmt->bindParam("id", $usuario->id);
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




function getLogin($mail){
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


$app->run();

?>
