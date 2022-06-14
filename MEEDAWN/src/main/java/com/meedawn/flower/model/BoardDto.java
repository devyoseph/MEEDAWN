package com.meedawn.flower.model;

import javax.validation.constraints.*;

public class BoardDto {
	
	private int id;
	
	@NotNull
	private String subject;
	
	@NotNull
	private String content;
	private int like;
	
	@NotNull
	@Size(min = 2, max = 20)
	private String username;

	@NotNull
	@Size(min = 4, max = 12)
	private String userid;
	
	private String platform;
	
	private String create_date;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getLike() {
		return like;
	}
	public void setLike(int like) {
		this.like = like;
	}

	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	public String getPlatform() {
		return platform;
	}
	public void setPlatform(String platform) {
		this.platform = platform;
	}
	
	@Override
	public String toString() {
		return "BoardDto [id=" + id + ", subject=" + subject + ", content=" + content + ", like=" + like + ", username="
				+ username + ", userid=" + userid + ", platform=" + platform + ", create_date=" + create_date + "]";
	}

}
