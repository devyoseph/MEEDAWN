package com.meedawn.flower.model.service;

import java.util.List;
import java.util.Map;

import com.meedawn.flower.model.BoardDto;

public interface BoardService {
	List<BoardDto> list(Map<String, Integer> map) throws Exception;
	int write(BoardDto boardDto) throws Exception;
	int edit(BoardDto boardDto) throws Exception;
	int delete(int id) throws Exception;
}
