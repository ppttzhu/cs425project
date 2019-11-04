package com.aws.lambda;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.aws.lambda.data.RequestDetails;
import com.aws.lambda.data.ResponseDetails;

public class SqlSelect implements RequestHandler<RequestDetails, ResponseDetails> {

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
		ResultSet response = statement.executeQuery(query);
        String ret = "";
        while (response.next()) {
           String id = response.getString("id");
           String name = response.getString("name");
           ret = ret + id + "," + name + "\t";
        }
        responseDetails.setReturnValue(ret);
	}

	private String getquery(RequestDetails requestDetails) {
		String query = "Select * From test;";
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
