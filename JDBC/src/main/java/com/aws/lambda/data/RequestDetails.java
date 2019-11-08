package com.aws.lambda.data;

public class RequestDetails {

    private String func_name;
    private String func_argument;

    public String getFunc_name() {
        return func_name;
    }

    public void setFunc_name(String func_name) {
        this.func_name = func_name;
    }

    public String getFunc_argument() {
        return func_argument;
    }

    public void setFunc_argument(String func_argument) {
        this.func_argument = func_argument;
    }

}
