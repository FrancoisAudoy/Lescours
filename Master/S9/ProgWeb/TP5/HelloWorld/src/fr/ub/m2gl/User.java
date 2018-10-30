package fr.ub.m2gl;

import javax.ws.rs.*;

import org.bson.Document;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mongodb.MongoClient;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

public class User {

	private String firstname, lastname;
	private MongoClient mc = new MongoClient();

	public User(String Firstname, String Lastname) {
		// TODO Auto-generated constructor stub
		firstname = Firstname;
		lastname = Lastname;
	}

	public String getFirstname() {
		return firstname;
	}

	public String getLastname() {
		return lastname;
	}




}
