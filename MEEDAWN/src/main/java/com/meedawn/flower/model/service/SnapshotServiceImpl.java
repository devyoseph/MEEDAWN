package com.meedawn.flower.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.meedawn.flower.model.SnapshotDto;
import com.meedawn.flower.model.mapper.SnapshotMapper;

@Service
public class SnapshotServiceImpl implements SnapshotService{
	
	@Autowired
	private SnapshotMapper snapshotMapper;
	
	@Override
	public ArrayList<SnapshotDto> getBasic() throws Exception {
		
		return snapshotMapper.getBasic();
	}

	@Override
	public int register(SnapshotDto snapshotDto) throws Exception {
		return snapshotMapper.register(snapshotDto);
	}

	@Override
	public ArrayList<SnapshotDto> getUser(SnapshotDto snapshotDto) throws Exception {
		return snapshotMapper.getUser(snapshotDto);
	}

	@Override
	public String getPath(SnapshotDto snapshotDto) throws Exception {
		return snapshotMapper.getPath(snapshotDto);
	}

}
