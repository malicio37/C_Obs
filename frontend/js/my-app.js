// Initialize your app
var myApp = new Framework7();

// Export selectors engine
var $$ = Dom7;
var email='';
var password='';
var codigoCarrera;
var backend='http://localhost:8080'
// Add view
var mainView = myApp.addView('.view-main', {
    // Because we use fixed-through navbar we can enable dynamic navbar
    dynamicNavbar: true

});



myApp.onPageInit('index2', function (page) {
  var pageContainer = $$(page.container);


  $$.get(backend +'/users', function (data) {
    console.log(data);
  });

  pageContainer.find('.botonSiguiente').on('click', function () {
    email = pageContainer.find('input[name="email"]').val();

    if(email== ""){
      myApp.alert('Debe ingresar un correo válido');
    }
    else{
      var params= '{"correo":"' + email + '",'+ '"password":"' + password + '"}';
      $$.post(backend +'/usuario/login', params, function (data) {
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
      var params= '{"correo":"' + email + '",'+ '"password":"' + password + '"}';
      $$.post(backend +'/usuario/login', params, function (data) {
        if (data =='false'){
          console.log ('usuario no existe');
          //cargar la página del formulario de inscripcion
          myApp.alert('Contraseña incorrecta, intente de nuevo por favor');
          mainView.router.loadPage("login.html");
        }
        else{
          //cargar la página de elección de la carrera a trabajar (almacenar en variable local carrera)
          mainView.router.loadPage("seleccionCarrera.html");
        }
      });
    }
  });
});



myApp.onPageInit('registroUsuario', function (page) {
  var pageContainer = $$(page.container);

  pageContainer.find('input[name="mail"]').val(email);
  pageContainer.find('input[name="password"]').val(password);

  pageContainer.find('.botonAddUser').on('click', function () {
    var id= 3; //debe ser autonumerica
    var nombres = pageContainer.find('input[name="nombres"]').val();
    var apellidos = pageContainer.find('input[name="apellidos"]').val();
    var fechaNacimiento = pageContainer.find('input[name="fechaNacimiento"]').val();
    mail = pageContainer.find('input[name="mail"]').val();
    password = pageContainer.find('input[name="password"]').val();
    var color = pageContainer.find('input[name="color"]').val();
    var genero = pageContainer.find('select[name="genero"]').val();

    if(nombres == "" || apellidos =="" || fechaNacimiento == "" || mail== "" || password== "" || color == "" || genero ==""){
      myApp.alert('Debe ingresar todos los campos del formulario');
    }
    else{
      var params= '{"id":3' + ','+ '"nombres":"' + nombres + '",' + '"apellidos":"' + apellidos + '",'+
      '"fechaNacimiento":"' + fechaNacimiento + '",' + '"mail":"' + mail + '", "password":"' + password  + '",'+ '"color":"' + color + '",'+
      '"genero":"' + genero + '",'+ '"tipo":"usuario"}';

        $$.post(backend +'/usuario', params, function (data) {
        if(data.indexOf('error') > -1){

          myApp.alert('usuario no pudo crearse por: ' + data);
          //cargar la página del formulario de inscripcion
          mainView.router.loadPage("inscripcion.html");
        }
        else{
          console.log ('usuario creado exitosamente: ' + data);
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
    var params = '{"usuarioMail":"'+ email + '"}';
    var selectObject= pageContainer.find('select[name="carrerasInscritas"]');
    $$.post(backend +'/carrerasInscritas', params, function (data) {
      var arreglo=JSON.parse(data);
      //console.log(arreglo[0].nombre);
      //cargar valores en el select carrerasInscritas
      for(i=0;i < Object.keys(arreglo).length; i++){
        var opcion = document.createElement("option");
        opcion.text = arreglo[i].nombre;
        opcion.value = arreglo[i].id;
        selectObject.append(opcion);
      }
    });
    pageContainer.find('.botonIngresar').on('click', function () {
        codigoCarrera= pageContainer.find('select[name="carrerasInscritas"]').val();
        $$.get(backend +'/carrera/'+codigoCarrera, params, function (data) {
          var arreglo=JSON.parse(data);
          document.getElementById("textoCarrera").innerHTML = arreglo.nombre;
          pageContainer.find('a[name="textoCarrera"]').val(arreglo.nombre);
          pageContainer.find('a[name="textoCorreo"]').val(email);
      });
      mainView.router.loadPage("principal.html");
    });
  });




$$(document).on('pageBeforeInit', function (e) {
	var page = e.detail.page;
  var params = '{"idCarrera":' + codigoCarrera + ',' + '"mail":"' + email + '"}';
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


function signOut() {
  email='';
  password='';
  codigoCarrera=null;
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
