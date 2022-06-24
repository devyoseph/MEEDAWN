package com.meedawn.flower.model.service;

import java.util.ArrayList;

import com.meedawn.flower.model.SnapshotDto;

public interface SnapshotService {
	ArrayList<SnapshotDto> getBasic() throws Exception;
	ArrayList<SnapshotDto> getUser(SnapshotDto snapshotDto) throws Exception;
	
	int register(SnapshotDto snapshotDto) throws Exception;
	String getPath(SnapshotDto snapshotDto) throws Exception;
}
