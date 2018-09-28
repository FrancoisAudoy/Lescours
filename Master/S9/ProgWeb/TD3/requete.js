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


/*---------
   MAIN
----------*/

let application = new App();
application.start();
