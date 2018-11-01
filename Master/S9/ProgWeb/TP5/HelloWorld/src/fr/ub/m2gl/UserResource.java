package fr.ub.m2gl;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

import org.bson.BSON;
import org.bson.Document;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

@Path("/user")
public class UserResource {

	ObjectMapper mapper;
	MongoClient mc;


	public UserResource() {
		mapper = new ObjectMapper();

		MongoClientURI uri = new MongoClientURI("mongodb://faudoy:trucbidon33@ds137913.mlab.com:37913/application");
		mc = new MongoClient(uri);
	}

	public String StringJson(User user) throws JsonProcessingException {
		return mapper.writeValueAsString(user);
	}

	@PUT
	@Produces(MediaType.APPLICATION_JSON)
	public User AddUser (@PathParam("firstname") String firstname, 
			@PathParam("lastname") String lastname){

		try {

			MongoDatabase bdd = mc.getDatabase("application");
			MongoCollection<Document> collection = bdd.getCollection("user");

			ObjectMapper mapper = new ObjectMapper();
			User user = new User(firstname, lastname);
			String jsonString = mapper.writeValueAsString(user);
			
			Document doc = Document.parse(jsonString);
			collection.insertOne(doc);
			
			return user;
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;

		} finally {
			mc.close();
		}
	}

	@POST
	@Produces(MediaType.APPLICATION_JSON)
	public User ChangeUser(@PathParam("firstname") String firstname, 
			@PathParam("lastname") String lastname, 
			@PathParam("newfirstname") String newFirstName, @PathParam("newlastname") String newLastName) {
		MongoDatabase bdd = mc.getDatabase("application");
		ObjectMapper mapper = new ObjectMapper();
		MongoCollection<Document> collection = bdd.getCollection("user"); 
		FindIterable<Document> doc = collection.find();
		
		return null;
	}
	
	@Path("all")
	@GET
	@Produces("application/json")
	public String GetAllUsers (){

		try {
			MongoDatabase bdd = mc.getDatabase("application");
			MongoCollection<Document> collection = bdd.getCollection("user");

			FindIterable<Document> doc = collection.find();

			ObjectMapper mapper = new ObjectMapper();

			return mapper.writeValueAsString(doc);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}

}
