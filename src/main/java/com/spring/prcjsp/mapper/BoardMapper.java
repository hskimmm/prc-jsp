package com.spring.prcjsp.mapper;

import com.spring.prcjsp.domain.Board;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {
    List<Board> getBoard();
}
