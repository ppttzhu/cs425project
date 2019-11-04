package com.aws.lambda.data;

public class ResponseDetails {

	private String messageID;
	private String messageReason;
	private String returnValue;

	public String getMessageID() {
		return messageID;
	}

	public void setMessageID(String messageID) {
		this.messageID = messageID;
	}

	public String getMessageReason() {
		return messageReason;
	}

	public void setMessageReason(String messageReason) {
		this.messageReason = messageReason;
	}

	public String getReturnValue() {
		return returnValue;
	}

	public void setReturnValue(String returnValue) {
		this.returnValue = returnValue;
	}
	
}
