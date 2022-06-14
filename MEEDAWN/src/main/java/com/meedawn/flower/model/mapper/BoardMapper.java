package com.meedawn.flower.model.mapper;

import java.util.List;
import java.util.Map;

import com.meedawn.flower.model.BoardDto;

public interface BoardMapper {
	List<BoardDto> list(Map<String, Integer> map) throws Exception;
	int write(BoardDto boardDto) throws Exception;
	int edit(BoardDto boardDto) throws Exception;
	int delete(int id) throws Exception;
}
