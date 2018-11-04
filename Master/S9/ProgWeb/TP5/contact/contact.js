let API_URL = "http://127.0.0.1:8080/ContactAPI/app/users"
let format = "?format=json&callback=?";

class request {

    constructor(url_api, format){
	this.url = url_api;
	this.format = format;
	this.defaultCallback = this.defaultCallback.bind(this);
    }

    defaultCallback(req,res){
	console.log(req);
    }
    
    send(url, type_req, data = null, callback = this.defaultCallback, useDefaultFormat = true){
	let finalUrl = this.url + url;
	if(useDefaultFormat)
	    finalUrl += format;
	$.ajax({
	    header : {
		'Accept': 'application/json',
		'Content-Type': 'application/json'
	    },
	    url : finalUrl,
	    type : type_req,
	    datatype : "json",
	    data : data
	}).done(callback);
    }
}

class application {

    constructor() {
	this.reloadContactList = this.reloadContactList.bind(this);
	this.createContact = this.createContact.bind(this);
	this.changeContact = this.changeContact.bind(this);
	this.deleteContact = this.deleteContact.bind(this);
	this.findContact = this.findContact.bind(this);
	this.req = new request(API_URL, format);
    }

    refreshListContact(res){

	$("#list-contact").html('');

	let jsonString = JSON.stringify(res);
	let data = JSON.parse(jsonString);

	data.forEach(function(element) {
	    $("#list-contact").append('<li class="list-group-item">' +
				      element.firstname + " " + element.lastname);
	    $("#list-contact").append('</li>');
	});
    }
	
    reloadContactList(){
	this.req.send("/all","GET", null, this.refreshListContact);
	    
    }

    refreshWithoutReload(res){
	let jsonString = JSON.stringify(res);
	let data = JSON.parse(jsonString);
	
	$("#list-contact").append('<li class="list-group-item">' +
				  data.firstname + " " + data.lastname);
	$("#list-contact").append('</li>');
    }

    
    createContact() {
	let fname = document.getElementById("add-fn").value;
	let lname = document.getElementById("add-ln").value;
	let contact = {firstname : fname, lastname : lname};
	console.log(JSON.stringify(contact));
	this.req.send("","PUT", JSON.stringify(contact), this.refreshWithoutReload);
    }

    changeContact() {
	let oldfname = document.getElementById("change-old-fn").value;
	let oldlname = document.getElementById("change-old-ln").value;
	let newfname = document.getElementById("change-new-fn").value;
	let newlname = document.getElementById("change-new-ln").value;

	let correctContact = {
	    oldFirstName : oldfname,
	    oldLastName : oldlname,
	    newFirstName : newfname,
	    newLastName : newlname
	}
	console.log(JSON.stringify(correctContact));
	this.req.send("","POST",JSON.stringify(correctContact));
	this.reloadContactList();
    }

    deleteContact(){
	let fname = document.getElementById("suppr-fn").value;
	let lname = document.getElementById("suppr-ln").value;

	let contact = {firstname : fname, lastname : lname};
	this.req.send("","DELETE", JSON.stringify(contact), null);
	this.reloadContactList();
    }

    fillFoundList(res){
	$("#found-contact").html('');

	let jsonString = JSON.stringify(res);
	let data = JSON.parse(jsonString);

	data.forEach(function(element) {
	    $("#found-contact").append('<li class="list-group-item">' +
				      element.firstname + " " + element.lastname);
	    $("#found-contact").append('</li>');
	});
    }
    
    findContact(){
	let fname = document.getElementById("find-fn").value;
	let lname = document.getElementById("find-ln").value;

	let url = "/user?firstname="+fname + "&lastname=" + lname +
	    "format=json&callback=?";

	this.req.send(url, "GET",null,this.fillFoundList,false);
	
    }
    
    run() {
	$("#add-contact").click(this.createContact);
	$("#change-contact").click(this.changeContact);
	$("#suppr-contact").click(this.deleteContact);
	$("#find-contact").click(this.findContact);
	this.reloadContactList();
    }
}

let app = new application();
app.run();
