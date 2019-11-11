package com.aws.lambda;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.aws.lambda.data.RequestDetails;
import com.aws.lambda.data.ResponseDetails;

public class SqlRequestHandler implements RequestHandler<RequestDetails, ResponseDetails> {

    private Map<String, List<String>> func_prototypes = new HashMap<String, List<String>>() {
        private static final long serialVersionUID = -3643754104322652548L;
        {
            // ===========================Insert===========================
            put("insert_online_client", Arrays.asList("char", "char", "char", "char"));
            put("insert_replenish_m2w", Arrays.asList("int", "int", "int", "date"));
            put("insert_replenish_w2s", Arrays.asList("int", "int", "int", "int", "date"));
            put("insert_order_online", Arrays.asList("int", "int", "int", "int", "date", "char"));
            put("insert_order_store", Arrays.asList("int", "int", "int", "int", "date"));
            put("insert_contract", Arrays.asList("int", "int", "int", "int"));
            // ===========================Update===========================
            put("update_online_client_basic", Arrays.asList("int", "char", "char"));
            put("update_online_client_password", Arrays.asList("int", "char"));
            put("update_online_client_pay", Arrays.asList("int", "char", "char", "char", "char", "char"));
            put("update_contract", Arrays.asList("int", "int", "int", "int"));
            put("update_keep_warehouse", Arrays.asList("int", "int", "int"));
            put("update_keep_store", Arrays.asList("int", "int", "int"));
            put("confirm_replenish_m2w", Arrays.asList("int"));
            put("confirm_replenish_w2s", Arrays.asList("int"));
            put("review_order", Arrays.asList("int", "int", "char"));
            // ===========================Query===========================
            put("region", new ArrayList<String>());
            put("filter_by_category", Arrays.asList("char"));
            put("product_summary", new ArrayList<String>());
            put("select_online_client", Arrays.asList("char"));
        }
    };

    public ResponseDetails handleRequest(RequestDetails requestDetails, Context context) {
        ResponseDetails responseDetails = new ResponseDetails();
        try {
            process(requestDetails, responseDetails);
        } catch (SQLException sqlException) {
            responseDetails.setMessage("Error: " + sqlException);
        }
        return responseDetails;
    }

    private void process(RequestDetails requestDetails, ResponseDetails responseDetails) throws SQLException {
        Connection connection = getConnection();
        String func_name = requestDetails.getFunc_name();
        String func_argument = requestDetails.getFunc_argument();
        List<String> types = this.func_prototypes.get(func_name);
        String init = "SELECT * FROM " + func_name;
        if (types.size() > 0) {
            init += "(";
            for (int i = 0; i < types.size(); i++) {
                init += "?";
                if (i != types.size() - 1) {
                    init += ",";
                }
            }
            init += ")";
        }
        PreparedStatement ps = prepareQuery(connection, init, types, func_argument);
        executeStatement(ps, responseDetails);
    }

    private PreparedStatement prepareQuery(Connection connection, String init, List<String> types, String func_argument)
            throws SQLException {
        PreparedStatement ps = connection.prepareStatement(init);
        List<String> alist = Arrays.asList(func_argument.split("\\|"));
        for (int i = 0; i < types.size(); i++) {
            String cell = alist.get(i).trim();
            String type = types.get(i);
            if (type.equals("int")) {
                ps.setInt(i + 1, Integer.parseInt(cell));
            } else if (type.equals("char")) {
                ps.setString(i + 1, cell);
            } else if (type.equals("date")) {
                ps.setDate(i + 1, java.sql.Date.valueOf(cell));
            } else if (type.equals("float")) {
                ps.setFloat(i + 1, Float.parseFloat(cell));
            } else {
                System.out.println("Type not exist.");
            }
        }
        return ps;
    }

    private void executeStatement(PreparedStatement statement, ResponseDetails responseDetails) throws SQLException {
        ResultSet result = statement.executeQuery();
        responseDetails.setReturnValue(resultSetTOString(result));
        responseDetails.setMessage("Success");
    }

    private String resultSetTOString(ResultSet result) throws SQLException {
        String ret = "";
        ResultSetMetaData metadata = result.getMetaData();
        // first row as column header
        int cnum = metadata.getColumnCount();
        for (int i = 0; i < cnum; i++) {
            ret += metadata.getColumnName(i + 1);
            if (i != cnum - 1) {
                ret += "|";
            }
        }
        ret += "\n";
        // rows separated by \n and columns separated by |
        while (result.next()) {
            for (int i = 0; i < cnum; i++) {
                ret += result.getString(i + 1);
                if (i != cnum - 1) {
                    ret += "|";
                }
            }
            ret += "\n";
        }
        return ret;
    }

    private Connection getConnection() throws SQLException {
        String url = "jdbc:postgresql://cs425project.ck5idh9xvvie.us-east-1.rds.amazonaws.com:5432/cs425project";
        String username = "ppttzhu";
        String password = "csgogogo";
//        String url = "jdbc:postgresql:cs425";
//        String username = "haley";
//        String password = "haley";
        Connection conn = DriverManager.getConnection(url, username, password);
        return conn;
    }

}
