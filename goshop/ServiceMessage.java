package com.go9.common;

import com.go9.common.ServiceMessage;

public class ServiceMessage<T> {
	private int status;
	private String message;
	private T data;

	public ServiceMessage() {
	}

	public ServiceMessage(int status, String message) {
		this.status = status;
		this.message = message;
	}

	public ServiceMessage(int status, String message, T data) {
		this.status = status;
		this.message = message;
		this.data = data;
	}

	// 成功时status==200,message=ok
	public static <T> ServiceMessage<T> ok() {
		return new ServiceMessage<T>(200, "OK");
	}

	// 成功时status==200,message=ok
	public static <T> ServiceMessage<T> ok(T data) {
		return new ServiceMessage<T>(200, "OK", data);
	}

	// 成功时status==200,message=ok
	public static ServiceMessage error() {
		return new ServiceMessage(500, "ERROR");
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}

}
