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

//login
$app->get('/', function() {
            echo "Pagina de gestión API REST de Carrea de Observación UAM.";
        });

////////////////////////////////////////////////////////////////////////////////
// Business logic API
//get login con los datos ocultos
$app->post('/users/email', 'getLogin');
$app->post('/users/passwd', 'getLogin2');

/*filtre carreras en las que el usuario se encuentra inscrito y la carrera se encuentra activa
 *@param email  el email del usuario
 */
$app->post('/inscriptions/user', 'getCircuitInscripted');


////////////////////////////////////////////////////////////////////////////////
// Nodes
$app->get('/nodes', 'getNodes');
$app->get('/nodes/:id', 'getNode');
$app->post('/nodes', 'addNode');
$app->put('/nodes/:id', 'updateNode');
$app->delete('/nodes/:id', 'deleteNode');

////////////////////////////////////////////////////////////////////////////////
// Circuits
$app->get('/circuits', 'getCircuits');
$app->get('/circuits/:id', 'getCircuits');
$app->post('/circuits', 'addCircuit');
$app->put('/circuits/:id', 'updateCircuit');
$app->delete('/circuits/:id', 'deleteCircuit');

////////////////////////////////////////////////////////////////////////////////
// Users
$app->get('/users', 'getUsers');
$app->get('/users/:email', 'getUser');
$app->post('/users', 'addUser');
$app->put('/users/:id', 'updateUser');
$app->delete('/users/:id', 'deleteUser');

////////////////////////////////////////////////////////////////////////////////
// Questions
$app->get('/questions', 'getQuestions');
$app->get('/questions/:id', 'getQuestion');
$app->post('/questions', 'addQuestion');
$app->put('/questions/:id', 'updateQuestion');
$app->delete('/questions/:id', 'deleteQuestion');

////////////////////////////////////////////////////////////////////////////////
// Inscriptions
$app->get('/inscriptions', 'getInscriptions');
$app->get('/inscriptions/:id', 'getInscription');
$app->post('/inscriptions', 'addInscription');
$app->put('/inscriptions/:id', 'updateInscription');
$app->delete('/inscriptions/:id', 'deleteInscription');

////////////////////////////////////////////////////////////////////////////////
// NodesDiscovered
$app->get('/nodesdiscovered', 'getNodesDiscovered');
$app->get('/nodesdiscovered/:id', 'getNodeDiscovered');
$app->post('/nodesdiscovered', 'addNodeDiscovered');
$app->put('/nodesdiscovered/:id', 'updateNodeDiscovered');
$app->delete('/nodesdiscovered/:id', 'deleteNodeDiscovered');

////////////////////////////////////////////////////////////////////////////////

function getLogin() {
 global $db, $request;
	 //si status = 1 requiere un update antes de hacer el insert
	 $user = json_decode($request->getBody());
 	 $sql = "SELECT email FROM user WHERE email=:email";
	 try {
			 $stmt = $db->prepare($sql);
			 $stmt->bindParam("email", $user->email);
			 $stmt->execute();
			 $user = $stmt->fetchObject();
			 echo json_encode($user);
	 } catch(PDOException $e) {
			 echo '{"error":{"text":'. $e->getMessage() .'}}';
	 }
}
//{"email":"jmmejia@autonoma.edu.co"}

 function getLogin2() {
	global $db, $request;
    //si status = 1 requiere un update antes de hacer el insert
    $user = json_decode($request->getBody());
	$sql = "SELECT id FROM user WHERE email=:email AND password=MD5(:password)";
    try {
        $stmt = $db->prepare($sql);
        $stmt->bindParam("email", $user->email);
				$stmt->bindParam("password", $user->password);
        $stmt->execute();
				$user = $stmt->fetchObject();
        echo json_encode($user);
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
}

//{"email":"jmmejia@autonoma.edu.co", "password":"123"}


function getCircuitInscripted(){
 global $db, $request, $response;
 $inscription = json_decode($request->getBody());
		 /*filtre carreras en las que el user se encuentra inscrito y la carrera se encuentra activa
			*@param email  el email del user
			*/
		 $sql = "SELECT circuit.id, circuit.name FROM circuit INNER JOIN (SELECT circuit_id FROM inscription
						 WHERE user_id=:user_id)AS a ON circuit.id=a.circuit_id WHERE circuit.status=1";
		 try {
				$stmt = $db->prepare($sql);
				$stmt->bindParam("user_id", $inscription->user_id);
				$stmt->execute();
				$inscription = $stmt->fetchAll(PDO::FETCH_OBJ);
				$response->write( json_encode($inscription));
		} catch(PDOException $e) {
				echo '{"error":{"text":'. $e->getMessage() .'}}';
		}
 }
//{"user_id":1}



///////////////////////////////////////////////////////////////////////////////

/**
* GET /nodes
* @return array
*/
function getNodes(){
	global $db, $response;
    $sql = "select * FROM node ORDER BY id";
    try {
        $stmt = $db->query($sql);
        $nodes = $stmt->fetchAll(PDO::FETCH_OBJ);
        $response->write( json_encode($nodes));
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
}


/**
* GET /circuits
* @return array
*/
function getCircuits(){
	global $db, $response;
    $sql = "select * FROM circuit ORDER BY id";
    try {
        $stmt = $db->query($sql);
        $circuits = $stmt->fetchAll(PDO::FETCH_OBJ);
        $response->write( json_encode($circuits));
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
}

/**
* GET /users
* @return array
*/
function getUsers(){
	global $db, $response;
    $sql = "select * FROM user ORDER BY id";
    try {
        $stmt = $db->query($sql);
        $users = $stmt->fetchAll(PDO::FETCH_OBJ);
        $response->write( json_encode($users));
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
}

/**
* GET /Questions
* @return array
*/
function getQuestions(){
	global $db, $response;
    $sql = "select * FROM question ORDER BY id";
    try {
        $stmt = $db->query($sql);
        $questions = $stmt->fetchAll(PDO::FETCH_OBJ);
        $response->write( json_encode($questions));
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
}

/**
* GET /inscriptions
* @return array
*/
function getInscriptions(){
	global $db, $response;
    $sql = "select * FROM inscription ORDER BY id";
    try {
        $stmt = $db->query($sql);
        $inscriptions = $stmt->fetchAll(PDO::FETCH_OBJ);
        $response->write( json_encode($inscriptions));
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
}

/**
* GET /NodesDiscovered
* @return array
*/
function getNodesDiscovered(){
	global $db, $response;
    $sql = "select * FROM nodediscovered ORDER BY id";
    try {
        $stmt = $db->query($sql);
        $nodesDiscovered = $stmt->fetchAll(PDO::FETCH_OBJ);
        $response->write( json_encode($nodesDiscovered));
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
}

///////////////////////////////////////////////////////////////////////////////

/**
* GET /nodes/{id}
* @param integer $id
* @return mixed
*/
function getNode($id){
	global $db;
     $sql = "SELECT * FROM node WHERE id=:id";
     try {

        $stmt = $db->prepare($sql);
        $stmt->bindParam("id", $id);
        $stmt->execute();
        $node = $stmt->fetchObject();

        echo json_encode($node);
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
 }

 /**
 * GET /circuits/{id}
 * @param integer $id
 * @return mixed
 */
 function getCircuit($id){
 	global $db;
      $sql = "SELECT * FROM circuit WHERE id=:id";
      try {
         $stmt = $db->prepare($sql);
         $stmt->bindParam("id", $id);
         $stmt->execute();
         $circuit = $stmt->fetchObject();
         echo json_encode($circuit);
     } catch(PDOException $e) {
         echo '{"error":{"text":'. $e->getMessage() .'}}';
     }
  }

	/**
  * GET /users/{id}
  * @param integer $id
  * @return mixed
  */
	function getUser($id){
		global $db;
	     $sql = "SELECT * FROM user WHERE id=:id";
	     try {

	        $stmt = $db->prepare($sql);
	        $stmt->bindParam("id", $id);
	        $stmt->execute();
	        $user = $stmt->fetchObject();

	        echo json_encode($user);
	    } catch(PDOException $e) {
	        echo '{"error":{"text":'. $e->getMessage() .'}}';
	    }
	 }

	 /**
   * GET /questions/{id}
   * @param integer $id
   * @return mixed
   */
function getQuestion($id){
	 	global $db, $response;
	     $sql = "SELECT * FROM question WHERE id=:id";
			 try {
          $stmt = $db->prepare($sql);
          $stmt->bindParam("id", $id);
          $stmt->execute();
          $question = $stmt->fetchObject();
          echo json_encode($question);
      } catch(PDOException $e) {
          echo '{"error":{"text":'. $e->getMessage() .'}}';
      }
	}

	 /**
   * GET /inscriptions/{id}
   * @param integer $id
   * @return mixed
   */
	 function getInscription($id){
		global $db, $response;
			 $sql = "SELECT * FROM inscription WHERE id=:id";
			 try {
					 $stmt = $db->prepare($sql);
					 $stmt->bindParam("id", $id);
					 $stmt->execute();
					 $inscription = $stmt->fetchObject();
					 echo json_encode($inscription);
			 } catch(PDOException $e) {
					 echo '{"error":{"text":'. $e->getMessage() .'}}';
			 }
	 }

	 /**
	 * GET /nodesDiscovered/{id}
	 * @param integer $id
	 * @return mixed
	 */
	 function getNodeDiscovered($id){
	  global $db, $response;
	 		$sql = "SELECT * FROM nodeDiscovered WHERE id=:id";
	 		try {
	 				$stmt = $db->prepare($sql);
	 				$stmt->bindParam("id", $id);
	 				$stmt->execute();
	 				$nodeDiscovered = $stmt->fetchObject();
	 				echo json_encode($nodeDiscovered);
	 		} catch(PDOException $e) {
	 				echo '{"error":{"text":'. $e->getMessage() .'}}';
	 		}
	 }


	 ////////////////////////////////////////////////////////////////////////////


	 /**
	 * POST /nodes
	 * @param Request $request
	 * @return JsonResponse
	 */
	 function addNode() {
	  global $db, $request;
	 	 //si status = 1 requiere un update antes de hacer el insert
	 	 $node = json_decode($request->getBody());
	  	 $sql = "INSERT INTO node (name, description, code, latitude, longitude, hint, circuit_id) VALUES (:name, :description, :code, :latitude, :longitude, :hint, :circuit_id)";
	 	 try {
	 			 $stmt = $db->prepare($sql);
	 			 $stmt->bindParam("name", $node->name);
	 			 $stmt->bindParam("description", $node->description);
	 			 $stmt->bindParam("code", $node->code);
	 			 $stmt->bindParam("latitude", $node->latitude);
	 			 $stmt->bindParam("longitude", $node->longitude);
	 			 $stmt->bindParam("hint", $node->hint);
	 			 $stmt->bindParam("circuit_id", $node->circuit_id);
	 			 $stmt->execute();
	 			 $node->id = $db->lastInsertId();
	 			 echo json_encode($node);
	 	 } catch(PDOException $e) {
	 			 echo '{"error":{"text":'. $e->getMessage() .'}}';
	 	 }
	 }
	 //{"name":"nn", "description":"nn","code":"1984-01-28","latitude":"@algo", "longitude":"@algo","hint":"#5454545","circuit_id":1}



/**
* POST /circuits
* @param Request $request
* @return JsonResponse
*/
 function addCircuit() {
	global $db, $request;
    //si status = 1 requiere un update antes de hacer el insert
    $circuit = json_decode($request->getBody());
	$sql = "INSERT  INTO circuit (name, status, description) VALUES (:name, :status, :description)";
    try {
        $stmt = $db->prepare($sql);
        $stmt->bindParam("name", $circuit->name);
        $stmt->bindParam("status", $circuit->status);
				$stmt->bindParam("description", $circuit->description);
        $stmt->execute();
        $circuit->id = $db->lastInsertId();
        echo json_encode($circuit);
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
}
//{"name":"nn","status":1,"description":"prueba"}

/**
* POST /users
* @param Request $request
* @return JsonResponse
*/
function addUser() {
 global $db, $request;
	 //si status = 1 requiere un update antes de hacer el insert
	 $user = json_decode($request->getBody());
 $sql = "INSERT  INTO user (name, lastname, birthDate, email, password, color, gender, type) VALUES (:name, :lastname, :birthDate, :email, MD5(:password),:color, :gender, :type)";
	 try {

			 $stmt = $db->prepare($sql);
			 $stmt->bindParam("name", $user->name);
			 $stmt->bindParam("lastname", $user->lastname);
			 $stmt->bindParam("birthDate", $user->birthDate);
			 $stmt->bindParam("email", $user->email);
			 $stmt->bindParam("password", $user->password);
			 $stmt->bindParam("color", $user->color);
			 $stmt->bindParam("gender", $user->gender);
			 $stmt->bindParam("type", $user->type);
			 $stmt->execute();
			 $user->id = $db->lastInsertId();
			 echo json_encode($user);
	 } catch(PDOException $e) {
			 echo '{"error":{"text":'. $e->getMessage() .'}}';
	 }
}
//{"name":"nn", "lastname":"nn","birthDate":"1984-01-28","email":"@algo","password":"@password","color":"#5454545","gender":"hombre","type":"user"}



/**
* POST /questions
* @param Request $request
* @return JsonResponse
*/
function addQuestion() {
 global $db, $request;
	 //si status = 1 requiere un update antes de hacer el insert
	 $question = json_decode($request->getBody());
 	 $sql = "INSERT INTO question (question, answer, node_id) VALUES (:question, :answer, :node_id)";
	 try {
			 $stmt = $db->prepare($sql);
			 $stmt->bindParam("question", $question->question);
			 $stmt->bindParam("answer", $question->answer);
			 $stmt->bindParam("node_id", $question->node_id);
			 $stmt->execute();
			 $question->id = $db->lastInsertId();
			 echo json_encode($question);
	 } catch(PDOException $e) {
			 echo '{"error":{"text":'. $e->getMessage() .'}}';
	 }
}
//{"question":"nn", "answer":"nn","node_id":2}


/**
* POST /inscriptions
* @param Request $request
* @return \Illuminate\Http\JsonResponse
*/
function addInscription() {
global $db, $request;
	//si status = 1 requiere un update antes de hacer el insert
	$body = $request->getBody();
	$inscription = json_decode($body);
	$sql = "INSERT INTO inscription (circuit_id, user_id) VALUES (:circuit_id, :user_id)";
	try {
			$stmt = $db->prepare($sql);
			$stmt->bindParam("circuit_id", $inscription->circuit_id);
			$stmt->bindParam("user_id", $inscription->user_id);
			$stmt->execute();
			$inscription->id = $db->lastInsertId();
			echo json_encode($inscription);
	} catch(PDOException $e) {
			echo '{"error":{"text":'. $e->getMessage() .'}}';
	}
}

//{"circuit_id":1, "user_id":1}
//{"circuit_id":1, "user_id":2}
//{"circuit_id":2, "user_id":2}


/**
* POST /nodesDiscovered
* @param Request $request
* @return \Illuminate\Http\JsonResponse
*/
function addNodeDiscovered() {
global $db, $request;
	//si status = 1 requiere un update antes de hacer el insert
	$nodeDiscovered = json_decode($request->getBody());
$sql = "INSERT  INTO nodeDiscovered (node_id, user_id, status, statusDate1, statusDate2, statusDate3) VALUES (:node_id, :user_id, :status, :statusDate1, :statusDate2, :statusDate3)";
	try {
			$stmt = $db->prepare($sql);
			$stmt->bindParam("node_id", $nodeDiscovered->node_id);
			$stmt->bindParam("user_id", $nodeDiscovered->user_id);
			$stmt->bindParam("status", $nodeDiscovered->status);
			$stmt->bindParam("statusDate1", $nodeDiscovered->statusDate1);
			$stmt->bindParam("statusDate2", $nodeDiscovered->statusDate2);
			$stmt->bindParam("statusDate3", $nodeDiscovered->statusDate3);
			$stmt->execute();
			$nodeDiscovered->id = $db->lastInsertId();

			echo json_encode($nodeDiscovered);
	} catch(PDOException $e) {
			echo '{"error":{"text":'. $e->getMessage() .'}}';
	}
}
//{"node_id":1, "user_id":1,"status": 0, "statusDate1":"2016-06-10 15:32:31"}

////////////////////////////////////////////////////////////////////////////////


/**
* PUT /nodes/{id}
* @param integer $id, Request $request
* @return JsonResponse
*/
	 function updateNode($id) {
	  global $db, $request;
	 	 //si status = 1 requiere un update antes de hacer el insert
		 $body = $request->getBody();
     $node = json_decode($body);
  	 $sql = "UPDATE node SET name= :name, description= :description, code= :code, latitude= :latitude, longitude= :longitude, hint= :hint, circuit_id= :circuit_id WHERE id= :id";
	 	 try {
	 			 $stmt = $db->prepare($sql);
	 			 $stmt->bindParam("name", $node->name);
	 			 $stmt->bindParam("description", $node->description);
	 			 $stmt->bindParam("code", $node->code);
	 			 $stmt->bindParam("latitude", $node->latitude);
	 			 $stmt->bindParam("longitude", $node->longitude);
	 			 $stmt->bindParam("hint", $node->hint);
	 			 $stmt->bindParam("circuit_id", $node->circuit_id);
				 $stmt->bindParam("id", $id);
	 			 $stmt->execute();
	 			 echo json_encode($node);
	 	 } catch(PDOException $e) {
	 			 echo '{"error":{"text":'. $e->getMessage() .'}}';
	 	 }
	 }
	 //{"name":"nn", "description":"nn","code":"1984-01-28","latitude":"@algo","hint":"#5454545","circuit_id":2}


/**
* PUT /circuit/{id}
* @param integer $id, Request $request
* @return JsonResponse
*/
function updateCircuit($id) {
    global $db, $request;
    $body = $request->getBody();
    $circuit = json_decode($body);
    $sql = "UPDATE circuit SET name=:name, status=:status, description=:description WHERE id=:id ";
    try {
        $stmt = $db->prepare($sql);
				$stmt->bindParam("name", $circuit->name);
        $stmt->bindParam("status", $circuit->status);
				$stmt->bindParam("description", $circuit->description);
        $stmt->bindParam("id", $id);
        $stmt->execute();
        echo json_encode($circuit);
    } catch(PDOException $e) {
        echo '{"error":{"text":'. $e->getMessage() .'}}';
    }
}
//{"name":"nn","status":1,"description":"prueba"}

/**
* PUT /users/{id}
* @param integer $id, Request $request
* @return JsonResponse
*/
function updateUser($id) {
 global $db, $request;
	 //si status = 1 requiere un update antes de hacer el insert
	 $body = $request->getBody();
	 $user = json_decode($body);
 	 $sql = "UPDATE user set name=:name, lastname=:lastname, birthDate=:birthDate, email=:email, password=:password, color=:color, gender=:gender, type=:type WHERE id=:id";
	 try {

			 $stmt = $db->prepare($sql);
			 $stmt->bindParam("name", $user->name);
			 $stmt->bindParam("lastname", $user->lastname);
			 $stmt->bindParam("birthDate", $user->birthDate);
			 $stmt->bindParam("email", $user->email);
			 $stmt->bindParam("password", $user->password);
			 $stmt->bindParam("color", $user->color);
			 $stmt->bindParam("gender", $user->gender);
			 $stmt->bindParam("type", $user->type);
			 $stmt->bindParam("id", $id);
			 $stmt->execute();
			 echo json_encode($user);
	 } catch(PDOException $e) {
			 echo '{"error":{"text":'. $e->getMessage() .'}}';
	 }
}
//{"name":"nn", "lastname":"nn","birthDate":"1984-01-28","email":"@algo","password":"@password","color":"#5454545","gender":"hombre","type":"user"}


/**
* PUT /questions/{id}
* @param integer $id, Request $request
* @return JsonResponse
*/
function updateQuestion($id) {
 global $db, $request;
   $body = $request->getBody();
	 $question = json_decode($body);
 	 $sql = "UPDATE question SET question= :question, answer= :answer, node_id= :node_id WHERE id= :id";
	 try {
			 $stmt = $db->prepare($sql);
			 $stmt->bindParam("question", $question->question);
			 $stmt->bindParam("answer", $question->answer);
			 $stmt->bindParam("node_id", $question->node_id);
			 $stmt->bindParam("id", $id);
			 $stmt->execute();
			 echo json_encode($question);
	 } catch(PDOException $e) {
			 echo '{"error":{"text":'. $e->getMessage() .'}}';
	 }
}
//{"question":"nn", "answer":"nn","node_id":2}


/**
* PUT /inscriptions/{id}
* @param integer $id, Request $request
* @return JsonResponse
*/
function updateInscription($id) {
global $db, $request;
	//si status = 1 requiere un update antes de hacer el insert
	$body = $request->getBody();
	$inscription = json_decode($body);
	$sql = "UPDATE inscription SET circuit_id=:circuit_id, user_id=:user_id WHERE id=:id";
	try {
			$stmt = $db->prepare($sql);
			$stmt->bindParam("circuit_id", $inscription->circuit_id);
			$stmt->bindParam("user_id", $inscription->user_id);
			$stmt->bindParam("id", $id);
			$stmt->execute();
			echo json_encode($inscription);
	} catch(PDOException $e) {
			echo '{"error":{"text":'. $e->getMessage() .'}}';
	}
}

//{"circuit_id":1, "user_id":3}
//{"circuit_id":1, "user_id":2}
//{"circuit_id":2, "user_id":1}


/**
* PUT /nodesDiscovered/{id}
* @param integer $id, Request $request
* @return JsonResponse
*/
function updateNodeDiscovered($id) {
global $db, $request;
	//si status = 1 requiere un update antes de hacer el insert
	$body = $request->getBody();
	$nodeDiscovered = json_decode($body);
$sql = "UPDATE nodeDiscovered SET node_id=:node_id, user_id=:user_id, status=:status, statusDate1=:statusDate1, statusDate2=:statusDate2, statusDate3=:statusDate3 WHERE id=:id";
	try {
			$stmt = $db->prepare($sql);
			$stmt->bindParam("node_id", $nodeDiscovered->node_id);
			$stmt->bindParam("user_id", $nodeDiscovered->user_id);
			$stmt->bindParam("status", $nodeDiscovered->status);
			$stmt->bindParam("statusDate1", $nodeDiscovered->statusDate1);
			$stmt->bindParam("statusDate2", $nodeDiscovered->statusDate2);
			$stmt->bindParam("statusDate3", $nodeDiscovered->statusDate3);
			$stmt->bindParam("id", $id);
			$stmt->execute();
			echo json_encode($nodeDiscovered);
	} catch(PDOException $e) {
			echo '{"error":{"text":'. $e->getMessage() .'}}';
	}
}
//el null tiene que ir en minùsculas
//{"node_id":1, "user_id":1,"status": 0, "statusDate1":"2016-06-10 15:32:31", "statusDate2":null, "statusDate3":null}



////////////////////////////////////////////////////////////////////////////////

/**
* DELETE /nodes/{id}
* @param integer $id
* @return mixed
*/
function deleteNode($id){
 global $db;
	 $sql = "DELETE FROM node WHERE id=:id";
	 try {
			 $stmt = $db->prepare($sql);
			 $stmt->bindParam("id", $id);
			 $stmt->execute();
			 echo ("object deleted");
	 } catch(PDOException $e) {
			 echo '{"error":{"text":'. $e->getMessage() .'}}';
	 }
}

/**
* DELETE /circuits/{id}
* @param integer $id
* @return mixed
*/
function deleteCircuit($id){
 global $db;
	 $sql = "DELETE FROM circuit WHERE id=:id";
	 try {
			 $stmt = $db->prepare($sql);
			 $stmt->bindParam("id", $id);
			 $stmt->execute();
			 echo ("object deleted");
	 } catch(PDOException $e) {
			 echo '{"error":{"text":'. $e->getMessage() .'}}';
	 }
}


/**
* DELETE /users/{id}
* @param integer $id
* @return mixed
*/
function deleteUser($id){
 global $db;
	 $sql = "DELETE FROM user WHERE id=:id";
	 try {
			 $stmt = $db->prepare($sql);
			 $stmt->bindParam("id", $id);
			 $stmt->execute();
			 echo ("object deleted");
	 } catch(PDOException $e) {
			 echo '{"error":{"text":'. $e->getMessage() .'}}';
	 }
}


/**
* DELETE /questions/{id}
* @param integer $id
* @return mixed
*/
function deleteQuestion($id){
 global $db;
	 $sql = "DELETE FROM question WHERE id=:id";
	 try {
			 $stmt = $db->prepare($sql);
			 $stmt->bindParam("id", $id);
			 $stmt->execute();
			 $question = $stmt;
			 echo ("object deleted");
	 } catch(PDOException $e) {
			 echo '{"error":{"text":'. $e->getMessage() .'}}';
	 }
}


/**
* DELETE /inscriptions/{id}
* @param integer $id
* @return mixed
*/
function deleteInscription($id){
 global $db;
	 $sql = "DELETE FROM inscription WHERE id=:id";
	 try {
			 $stmt = $db->prepare($sql);
			 $stmt->bindParam("id", $id);
			 $stmt->execute();
			 echo ("object deleted");
	 } catch(PDOException $e) {
			 echo '{"error":{"text":'. $e->getMessage() .'}}';
	 }
}

/**
* DELETE /nodesDiscovered/{id}
* @param integer $id
* @return mixed
*/
function deleteNodeDiscovered($id){
 global $db;
	 $sql = "DELETE FROM nodeDiscovered WHERE id=:id";
	 try {
			 $stmt = $db->prepare($sql);
			 $stmt->bindParam("id", $id);
			 $stmt->execute();
			 echo ("object deleted");
	 } catch(PDOException $e) {
			 echo '{"error":{"text":'. $e->getMessage() .'}}';
	 }
}

////////////////////////////////////////////////////////////////////////////////




$app->run();

?>
