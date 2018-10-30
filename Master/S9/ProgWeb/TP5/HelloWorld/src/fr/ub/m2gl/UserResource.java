package fr.ub.m2gl;

import java.net.URI;
import java.net.URISyntaxException;

import javax.ws.rs.*;
import javax.ws.rs.core.Response;
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

	@POST
	public Response AddUser (@FormParam("firstname") String firstname, 
			@FormParam("lastname") String lastname){

		try {

			MongoDatabase bdd = mc.getDatabase("application");
			MongoCollection<Document> collection = bdd.getCollection("user");

			ObjectMapper mapper = new ObjectMapper();

			String jsonString = mapper.writeValueAsString(new User(firstname, lastname));
			Document doc = Document.parse(jsonString);
			collection.insertOne(doc);
			return Response.seeOther(new URI("/Contact/")).build();
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return Response.serverError().build();

		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return Response.serverError().build();
		} finally {
			mc.close();
		}


	}

	@GET
	@Produces("application/json")
	public String GetUser (){

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
