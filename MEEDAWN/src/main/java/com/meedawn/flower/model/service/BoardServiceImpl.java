package com.meedawn.flower.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.meedawn.flower.model.BoardDto;
import com.meedawn.flower.model.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardMapper boardMapper;
	
	@Override
	public List<BoardDto> list(Map<String, Integer> map) throws Exception {
		return boardMapper.list(map);
	}

	@Override
	public int write(BoardDto boardDto) throws Exception {
		System.out.println("서비스단:  "+ boardDto.toString());
		return boardMapper.write(boardDto);
	}

	@Override
	public int edit(BoardDto boardDto) throws Exception {
		return boardMapper.edit(boardDto);
	}

	@Override
	public int delete(int id) throws Exception {
		return boardMapper.delete(id);
	}

}
