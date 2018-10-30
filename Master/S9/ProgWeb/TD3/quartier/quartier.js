/**
faire un builder pour transformar quartiers en HTML
**/
class quartier{
    constructor(id, nomQuartier){
	this.id = id;
	this.quartier= nomQuartier;
	this.rues=[];
	this.addStreet = this.addStreet.bind(this);
    }

    addStreet(streetName){
	this.rues.push(streetName);
    }

    getHTML() {
    /* TODO */
    }
}

/**
Ajouter fct pour ajouter rue dans quartier 
**/
class proxyQuartier{

    constructor(){
	this.street=[]:
	this.addQuartier = this.addQuartier.bind(this);
    }

    addStreet(id, streetName ){
	this.street.splice(id,0, streetName);
    }
}

/**
Utiliser fetch au lieu de jquery
pour voir différente façon de faire
**/
class request{
    
    constructor(url, callbackFunction){
	this._url = url;
	this._callback = callbackFunction;
	this.getJson = this.getJson.bind(this);
    }

    getJson(){
	$.getJSON(this._url, this._callback);
    }
}
/**
Définir fct pour créer nouver nouveaux quartiers dans proxy 
corriger fct callback 
**/
class App{

    constructor(){
	this.reqToilets = new request('http://odata.bordeaux.fr/v1/databordeaux/sigsanitaire/?format=json&callback=?', this.fillList);
	this.reqKidArea = new request('http://odata.bordeaux.fr/v1/databordeaux/airejeux/?format=json&callback=?', this.fillList);
    }
    
    start(){
	$( "#btn-toilets").on("click",this.reqToilets.getJson);
	$( "#btn-kidareas").click(this.reqKidArea.getJson);
    }

    fillList(response){
	if(response.status < 200 || response.status >= 300){
	    this.fail(response.status);
	    return;
	}
	
	let data = JSON.stringify(response);
	let parsed = JSON.parse(data);
	
	$("#data-list").html('');
	parsed.d.forEach(function(element) {
	    $("#data-list").append("<li>"+ element.num_quartier + " : " + element.nom+ "</li>");
	});
    }

    fail(codeError){
	console.log("Error : " + codeError);
    }
}

let url_test = "https://randomuser.me/api/?results=10&format=json";

let myheaderBDX = new Headers();
myheaderBDX.append('Accept', 'application/json, text/plain, text/json, */*');
myheaderBDX.append("Content-Type", "application/json");
myheaderBDX.append("Access-Control-Allow-Origin", "origin");

let initBDX = {method : 'GET' ,
	    headers : myheaderBDX,
	    mode : 'no-cors',
	    cache : 'default'
	   };

async function doFetch(url, init){
    return fetch(url, init)
	.then(onSuccess)
	.catch(function(error){
	    console.log(error);
	});
}

function get_test (){
    rep = doFetch(url_test, {method : 'GET' ,
			     headers : myheaderBDX,
			     mode : 'cors',
			     cache : 'default'
			    });

}
