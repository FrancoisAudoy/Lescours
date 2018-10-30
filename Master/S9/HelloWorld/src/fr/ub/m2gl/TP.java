package fr.ub.m2gl;

import javax.ws.rs.*;

@Path("/tp")
public class TP {

	 @GET
	    @Produces("text/plain")
	    public String getHelloWorld() {
	        return "Hello World from text/plain";
	    }
}
