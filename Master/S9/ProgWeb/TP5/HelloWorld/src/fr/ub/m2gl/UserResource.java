package fr.ub.m2gl;

import java.io.IOException;
import java.util.ArrayList;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

import org.bson.Document;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

@Path("/users")
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
	public User AddUser (String data) throws IOException{

		try {
			
			MongoDatabase bdd = mc.getDatabase("application");
			MongoCollection<Document> collection = bdd.getCollection("user");
			ObjectMapper mapper = new ObjectMapper();
			JsonNode rootNode = mapper.readTree(data);
			JsonNode fnameNode = rootNode.get("firstname");
			JsonNode lnameNode = rootNode.get("lastname");
			User user = new User(fnameNode.asText(), lnameNode.asText());
			String jsonString = mapper.writeValueAsString(user);

			Document doc = Document.parse(jsonString);
			collection.insertOne(doc);

			return user;
		} catch (JsonProcessingException e) {
			e.printStackTrace();
			return null;

		}
	}

	@POST
	@Produces(MediaType.APPLICATION_JSON)
	public User ChangeUser(String data) throws JsonProcessingException, IOException {
		MongoDatabase bdd = mc.getDatabase("application");
		ObjectMapper mapper = new ObjectMapper();
		MongoCollection<Document> collection = bdd.getCollection("user");

		JsonNode rootNode = mapper.readTree(data);
		JsonNode oldFirstName = rootNode.get("oldFirstName");
		JsonNode oldLastName = rootNode.get("oldLastName");
		JsonNode newFirstName = rootNode.get("newFirstName");
		JsonNode newLastName = rootNode.get("newLastName");
		
		Document query = new Document();
		query.append("firstname", oldFirstName.asText())
		.append("lastname", oldLastName.asText());
		Document update = new Document();
		update.append("firstname", newFirstName.asText())
		.append("lastname", newLastName.asText());
		Document operation = new Document("$set", update);
		collection.updateOne(query, operation);
		return new User(newFirstName.asText(), newLastName.asText());
	}

	@DELETE
	public void removeUser(String data) throws JsonProcessingException, IOException{
		
		MongoDatabase bdd = mc.getDatabase("application");
		MongoCollection<Document> collection = bdd.getCollection("user");
		
		ObjectMapper mapper = new ObjectMapper();
		JsonNode rootNode = mapper.readTree(data);
		JsonNode firstnameNode = rootNode.get("firstname");
		JsonNode lastnameNode = rootNode.get("lastname");
		Document userToRemove = new Document();
		userToRemove.append("firstname", firstnameNode.asText())
		.append("lastname", lastnameNode.asText());
		collection.findOneAndDelete(userToRemove);
	}

	@Path("/all")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public ArrayList<User> GetAllUsers () throws JsonProcessingException{

		MongoDatabase bdd = mc.getDatabase("application");
		MongoCollection<Document> collection = bdd.getCollection("user");
		ObjectMapper mapper = new ObjectMapper();
		ArrayList<User> users = new ArrayList<>();
		ArrayList<Document> doc = (ArrayList<Document>)collection.find().into(new ArrayList<Document>());
		
		for(Document user : doc) {
			String fname = user.getString("firstname");
			String lname = user.getString("lastname");
			users.add(new User(fname,lname));
		}
		
		return users;
	}
		
	@Path("/user")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public ArrayList<User> GetUserByName(@QueryParam("firstname") String firstname, 
			@QueryParam("lastname") String lastname) throws IOException {
		MongoDatabase bdd = mc.getDatabase("application");
		MongoCollection<Document> collection = bdd.getCollection("user");
		
		ArrayList<User> users = new ArrayList<>();

		Document query = new Document();
		if( firstname != null && firstname != "null")
			query.append("firstname", firstname);
		
		if( lastname!= null && lastname != "null") 
			query.append("lastname", lastname);
		
		
		ArrayList<Document> doc = (ArrayList<Document>)collection.find(query).into(new ArrayList<Document>());
		
		for(Document user : doc) {
			String fname = user.getString("firstname");
			String lname = user.getString("lastname");
			users.add(new User(fname,lname));
		}
		
		return users;
	}

}
