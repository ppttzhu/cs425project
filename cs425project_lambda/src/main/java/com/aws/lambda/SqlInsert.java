package com.aws.lambda;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.aws.lambda.data.RequestDetails;
import com.aws.lambda.data.ResponseDetails;

public class SqlInsert implements RequestHandler<RequestDetails, ResponseDetails> {

	public ResponseDetails handleRequest(RequestDetails requestDetails, Context arg1) {
		ResponseDetails responseDetails = new ResponseDetails();
		try {
			insertDetails(requestDetails, responseDetails);
		} catch (SQLException sqlException) {
			responseDetails.setMessageID("999");
			responseDetails.setMessageReason("Unable to Registor " + sqlException);
		}
		return responseDetails;
	}

	private void insertDetails(RequestDetails requestDetails, ResponseDetails responseDetails) throws SQLException {
		Connection connection = getConnection();
		Statement statement = connection.createStatement();
		String query = getquery(requestDetails);
		int responseCode = statement.executeUpdate(query);
		if (1 == responseCode) {
			responseDetails.setMessageID(String.valueOf(responseCode));
			responseDetails.setMessageReason("Successfully updated details");
		}
	}

	private String getquery(RequestDetails requestDetails) {
		String query = "INSERT INTO test(id, name) VALUES (";
		if (requestDetails != null) {
			query = query.concat("'" + requestDetails.getId() + "','" + requestDetails.getName() + "')");
		}
		System.out.println("the query is " + query);
		return query;
	}

	private Connection getConnection() throws SQLException {
		String url = "jdbc:postgresql://cs425project.ck5idh9xvvie.us-east-1.rds.amazonaws.com:5432/cs425project";
		String username = "ppttzhu";
		String password = "csgogogo";
		Connection conn = DriverManager.getConnection(url, username, password);
		return conn;
	}

}
