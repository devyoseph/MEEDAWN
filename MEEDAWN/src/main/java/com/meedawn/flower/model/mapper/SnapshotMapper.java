package com.meedawn.flower.model.mapper;
import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.meedawn.flower.model.SnapshotDto;

@Mapper
public interface SnapshotMapper {
	ArrayList<SnapshotDto> getBasic() throws Exception;
	ArrayList<SnapshotDto> getUser(SnapshotDto snapshotDto) throws Exception;
	
	int register(SnapshotDto snapshotDto) throws Exception;
	String getPath(SnapshotDto snapshotDto) throws Exception;
}
