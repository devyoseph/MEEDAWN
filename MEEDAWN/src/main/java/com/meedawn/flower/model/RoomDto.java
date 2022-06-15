package com.meedawn.flower.model;

public class RoomDto {
	private int roomNumber;
	private String roomName;
	private int participatePerson;
	
	public int getRoomNumber() {
		return roomNumber;
	}
	public void setRoomNumber(int roomNumber) {
		this.roomNumber = roomNumber;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public int getParticipatePerson() {
		return participatePerson;
	}
	public void setParticipatePerson(int participatePerson) {
		this.participatePerson = participatePerson;
	}
	
	@Override
	public String toString() {
		return "RoomDto [roomNumber=" + roomNumber + ", roomName=" + roomName + ", participatePerson="
				+ participatePerson + "]";
	}	
}
