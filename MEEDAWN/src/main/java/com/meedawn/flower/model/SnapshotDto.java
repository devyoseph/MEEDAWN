package com.meedawn.flower.model;

public class SnapshotDto {
	private String filename;
	private String path;
	private String host;
	private String type;
	private int order;
	private String member_userid;
	private String original_filename;
	
	public String getOriginal_filename() {
		return original_filename;
	}
	public void setOriginal_filename(String original_filename) {
		this.original_filename = original_filename;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getHost() {
		return host;
	}
	public void setHost(String host) {
		this.host = host;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getOrder() {
		return order;
	}
	public void setOrder(int order) {
		this.order = order;
	}
	public String getMember_userid() {
		return member_userid;
	}
	public void setMember_userid(String member_userid) {
		this.member_userid = member_userid;
	}
	
	@Override
	public String toString() {
		return "SnapshotDto [filename=" + filename + ", path=" + path + ", host=" + host + ", type=" + type + ", order="
				+ order + ", member_userid=" + member_userid + ", original_filename=" + original_filename + "]";
	}
	
}
