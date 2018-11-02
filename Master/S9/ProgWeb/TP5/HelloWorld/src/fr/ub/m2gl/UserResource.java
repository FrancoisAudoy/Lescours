package fr.ub.m2gl;

import java.util.ArrayList;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

import org.bson.Document;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
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
	public User AddUser (@QueryParam("firstname") String firstname, 
			@QueryParam("lastname") String lastname){

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
			e.printStackTrace();
			return null;

		}
	}

	@POST
	@Produces(MediaType.APPLICATION_JSON)
	public User ChangeUser(@QueryParam("firstname") String firstname, 
			@QueryParam("lastname") String lastname, 
			@QueryParam("newfirstname") String newFirstName, @QueryParam("newlastname") String newLastName) {
		MongoDatabase bdd = mc.getDatabase("application");
		ObjectMapper mapper = new ObjectMapper();
		MongoCollection<Document> collection = bdd.getCollection("user");

		Document query = new Document();
		query.append("firstname", firstname).append("lastname", lastname);
		Document update = new Document();
		update.append("firstname", newFirstName).append("lastname", newLastName);

		collection.updateOne(query, update);
		return new User(newFirstName, newLastName);
	}

	@DELETE
	public void removeUser(@QueryParam("firstname") String firstname, 
			@QueryParam("lastname") String lastname){
		
		MongoDatabase bdd = mc.getDatabase("application");
		MongoCollection<Document> collection = bdd.getCollection("user");
		Document userToRemove = new Document();
		userToRemove.append("firstname", firstname).append("lastname", lastname);
		collection.findOneAndDelete(userToRemove);
	}

	@Path("/all")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public ArrayList<User> GetAllUsers (){

		MongoDatabase bdd = mc.getDatabase("application");
		MongoCollection<Document> collection = bdd.getCollection("user");
		
		ArrayList<User> users = new ArrayList<>();
		ArrayList<Document> doc = (ArrayList<Document>)collection.find().into(new ArrayList<Document>());
		
		for(Document user : doc) {
			String fname = user.getString("firstname");
			String lname = user.getString("lastname");
			users.add(new User(fname,lname));
		}
		
		return users;
	}

}
