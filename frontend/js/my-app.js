// Initialize your app
var myApp = new Framework7();

// Export selectors engine
var $$ = Dom7;
var user;
var email;
//var password;
var circuit;
var backend='http://localhost/C_Obs/backendSlim'
// Add view
var mainView = myApp.addView('.view-main', {
    // Because we use fixed-through navbar we can enable dynamic navbar
    dynamicNavbar: true

});



myApp.onPageInit('index2', function (page) {
  var pageContainer = $$(page.container);
  pageContainer.find('.botonSiguiente').on('click', function () {
    email = pageContainer.find('input[name="email"]').val();
    if(email== ""){
      /*
       * Falta la validación completa del email antes de crear
       */
      myApp.alert('Debe ingresar un correo válido');
    }
    else{
      var params= '{"email":"' + email + '"}';
      $$.post(backend +'/users/email', params, function (data) {
        if (data =='false'){
        myApp.alert('El correo ingresado no se encuentra registrado, por favor realice el registro');
          //cargar la página del formulario de inscripcion
          mainView.router.loadPage("registroUsuario.html");
        }
        else{
          //cargar la página de elección de la carrera a trabajar (almacenar en variable local carrera)
          mainView.router.loadPage("login.html");
        }
      });
    }
  });
});


myApp.onPageInit('login', function (page) {

  var pageContainer = $$(page.container);
  pageContainer.find('.botonLogin').on('click', function () {
    password = pageContainer.find('input[name="password"]').val();
    if(password == ""){
      myApp.alert('Debe ingresar la contraseña para continuar');
    }
    else{
      var params= '{"email":"' + email + '",'+ '"password":"' + password + '"}';
      $$.post(backend +'/users/passwd', params, function (data) {
        if (data =='false'){
          myApp.alert('Contraseña incorrecta, intente de nuevo por favor');
          mainView.router.loadPage("login.html");
        }
        else{
          //devuelve el identificador del usuario logeado
          var arreglo=JSON.parse(data);
          user = arreglo.id;
          mainView.router.loadPage("seleccionCarrera.html");
        }
      });
    }
  });
});



myApp.onPageInit('registroUsuario', function (page) {
  var pageContainer = $$(page.container);
  pageContainer.find('input[name="email"]').val(email);
  pageContainer.find('.botonAddUser').on('click', function () {
    var nombres = pageContainer.find('input[name="nombres"]').val();
    var apellidos = pageContainer.find('input[name="apellidos"]').val();
    var fechaNacimiento = pageContainer.find('input[name="fechaNacimiento"]').val();
    var password = pageContainer.find('input[name="password"]').val();
    var color = pageContainer.find('input[name="color"]').val();
    var genero = pageContainer.find('select[name="genero"]').val();

    if(nombres == "" || apellidos =="" || fechaNacimiento == "" || password== "" || color == "" || genero ==""){
      myApp.alert('Debe ingresar todos los campos del formulario');
    }
    else{
      var params= '{"name":"' + nombres + '",' + '"lastname":"' + apellidos + '",'+
      '"birthDate":"' + fechaNacimiento + '",' + '"email":"' + email + '", "password":"' + password  + '",'+ '"color":"' + color + '",'+
      '"gender":"' + genero + '",'+ '"type":"usuario"}';
        console.log(params);
        $$.post(backend +'/users', params, function (data) {
        if(data.indexOf('error') > -1){

          myApp.alert('usuario no pudo crearse por: ' + data);
          //cargar la página del formulario de inscripcion
          mainView.router.loadPage("inscripcion.html");
        }
        else{
          console.log ('usuario creado exitosamente: ' + data);
          var arreglo=JSON.parse(data);
          user = arreglo.id;
          //cargar la pagina de inscripcion de carreras despues de mostrar carreras activas
          mainView.router.loadPage("seleccionCarrera.html");
        }
      });

    }
    });
  });


  myApp.onPageInit('seleccionCarrera', function (page) {
    //cargar los valores de carreras previos
    var pageContainer = $$(page.container);
    var params = '{"user_id":'+ user + '}';
    var selectObject= pageContainer.find('select[name="carrerasInscritas"]');
    $$.post(backend +'/inscriptions/user', params, function (data) {
      if(data=="[]"){
        myApp.alert('No tiene carreras inscritas, solicite su inscripción al administrador');
      }
      else{
        var arreglo=JSON.parse(data);
        //cargar valores en el select carrerasInscritas
        for(i=0;i < Object.keys(arreglo).length; i++){
          var opcion = document.createElement("option");
          opcion.text = arreglo[i].name;
          opcion.value = arreglo[i].id;
          selectObject.append(opcion);
        }
      }
    });

    pageContainer.find('.botonIngresar').on('click', function () {
        circuit= pageContainer.find('select[name="carrerasInscritas"]').val();
        if(circuit==""){
          myApp.alert('No tiene carreras inscritas, solicite su inscripción al administrador');
        }
        else{

          //$$.get(backend +'/circuits/'+circuit, function (data) {
          //var arreglo=JSON.parse(data);
          //document.getElementById("textoCarrera").innerHTML = arreglo.nombre;
          //pageContainer.find('a[name="textoCarrera"]').val(arreglo.nombre);
          //pageContainer.find('a[name="textoCorreo"]').val(email);
        //});
        mainView.router.loadPage("principal.html");
        }
    });
});

myApp.onPageInit('principal2', function (page) {
  var pageContainer = $$(page.container);
  //var circuitName= pageContainer.find('text[name="nombreCarrera"]');
  $$.get(backend +'/circuits/'+circuit, function (data) {
    var arreglo=JSON.parse(data);
    document.getElementById("circuitName").innerHTML = "Carrera: " +arreglo.name;
    document.getElementById("userMail").innerHTML = "Usuario: " + email;
    //pageContainer.find('a[name="textoCarrera"]').val(arreglo[0].name);
  });
});

myApp.onPageInit('verPista', function (page) {
  var pageContainer = $$(page.container);
  var params = '{"user_id":'+ user + ', "circuit_id":'+circuit+'}';
  //var circuitName= pageContainer.find('text[name="nombreCarrera"]');
  $$.post(backend +'/nodes/showhint',params, function (data) {
    var arreglo=JSON.parse(data);
    console.log(data);
    var test="";
    for(i=0;i < Object.keys(arreglo).length; i++){
      test+= arreglo[i].hint + '<br><br>';
    }
    document.getElementById("listview").innerHTML = test;
  });
});


/*
$$(document).on('pageInit', function (e) {
	var page = e.detail.page;
  var params = '{"idCarrera":' + circuit + ',' + '"mail":"' + email + '"}';
    if (page.name === 'verPista') {
  		$$.get(backend + '/nodo', function (data) {
        var arreglo=JSON.parse(data);
        //console.log(arreglo[0].nombre);
        //cargar valores en el select carrerasInscritas
        var test="";
        for(i=0;i < Object.keys(arreglo).length; i++){
          test+= arreglo[i].pista;
          test+='<br><br>';
        }
  			document.getElementById("listview").innerHTML = test;
  		});
  	};
  	if (page.name === 'verPregunta') {

  	};
  	if (page.name === 'responder') {

  	};
  	if (page.name === 'verPuntuacion') {

  	};
  	if (page.name === 'estadoCompetencia') {

  	};
  	if (page.name === 'verMapa') {

  	};

});
*/

function signOut() {
  user='';
  email='';
  circuit='';
  mainView.router.loadPage("index.html");
};


/*
        myApp.alert('Email: ' + email + ', Password: ' + password, function () {
          mainView.goBack();
        });
*/
/*
     metodo para hacer get con parametros
    console.log(backend+'/mensajeria/usuario/' + email);
    $$.get(backend+'/mensajeria/usuario/' + email, function (data) {
      console.log (data);
		});
*/
