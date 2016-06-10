// Initialize your app
var myApp = new Framework7();

// Export selectors engine
var $$ = Dom7;
var email='';
var password='';
var backend='http://localhost/C_Obs/backendSlim'
// Add view
var mainView = myApp.addView('.view-main', {
    // Because we use fixed-through navbar we can enable dynamic navbar
    dynamicNavbar: true
});

// Callbacks to run specific code for specific pages, for example for About page:
myApp.onPageInit('about', function (page) {
    // run createContentPage func after link was clicked
    $$('.create-page').on('click', function () {
        createContentPage();
    });
});


myApp.onPageInit('login', function (page) {

  var pageContainer = $$(page.container);
  pageContainer.find('.botonLogin').on('click', function () {
    email = pageContainer.find('input[name="email"]').val();
    password = pageContainer.find('input[name="password"]').val();
    if(email== "" || password == ""){
      myApp.alert('Debe ingresar todos los campos del formulario');
    }
    else{
      var params= '{"correo":"' + email + '",'+ '"password":"' + password + '"}';
      $$.post(backend +'/usuario/login', params, function (data) {
        if (data =='false'){
          console.log ('usuario no existe');
          //cargar la página del formulario de inscripcion


          mainView.router.loadPage("registroUsuario.html");
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
    var tipo = pageContainer.find('select[name="tipo"]').val();

    if(nombres == "" || apellidos =="" || fechaNacimiento == "" || mail== "" || password== "" || color == "" || genero =="" || tipo == ""){
      myApp.alert('Debe ingresar todos los campos del formulario');
    }
    else{
      var params= '{"id":3' + ','+ '"nombres":"' + nombres + '",' + '"apellidos":"' + apellidos + '",'+
      '"fechaNacimiento":"' + fechaNacimiento + '",' + '"mail":"' + mail + '", "password":"' + password  + '",'+ '"color":"' + color + '",'+
      '"genero":"' + genero + '",'+ '"tipo":"' + tipo + '"}';

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
    var params = '{"usuarioMail":"'+ email + '"}';
    $$.post(backend +'/carrerasInscritas', params, function (data) {
      var arreglo=JSON.parse(data);
      //console.log(arreglo[0].nombre);
      //cargar valores en el select carrerasInscritas
      for(i=0;i < Object.keys(arreglo).length; i++){
        console.log(arreglo[i].id + ': ' +arreglo[i].nombre);
      }

    });



    var pageContainer = $$(page.container);
    var objeto= pageContainer.find('select[name="carrerasInscritas"]');

    var opcion = document.createElement("option");
    opcion.text = "Kiwi";
    opcion.value = 10;
    objeto.append(opcion);


    pageContainer.find('.botonIngresar').on('click', function () {
        console.log('ingresando a principal');
    });
  });




$$(document).on('pageBeforeInit', function (e) {
	var page = e.detail.page;
    if (page.name === 'verPista') {
		$$.get(backend + '/carrera/nodos', function (data) {
			var test = data;
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
