package com.aws.lambda;

import com.aws.lambda.SqlRequestHandler;
import com.aws.lambda.data.RequestDetails;
import com.aws.lambda.data.ResponseDetails;

public class LocalTest
{ 
    public static void main(String [] args)
    {
        SqlRequestHandler sh = new SqlRequestHandler();
        RequestDetails requestDetails = new RequestDetails();
        String func_name = "product_summary";
        String func_argument = "";//"1|1|1|3|2019-11-10|33333";
        requestDetails.setFunc_name(func_name);
        requestDetails.setFunc_argument(func_argument);
        ResponseDetails responseDetails = sh.handleRequest(requestDetails, null);
        System.out.println(responseDetails.getMessage());
        System.out.println(responseDetails.getReturnValue());
    }
}
