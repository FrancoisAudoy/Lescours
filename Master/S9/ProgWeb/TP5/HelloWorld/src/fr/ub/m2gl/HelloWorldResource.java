package fr.ub.m2gl;

import javax.ws.rs.*;

import com.fasterxml.jackson.core.JsonProcessingException;

@Path("/hello")
public class HelloWorldResource {

	@GET
	@Produces("application/json")
	public String getHelloWorld() {
		UserResource ur = new UserResource();
		try {
			return ur.StringJson(new User("toto","fernand"));
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}