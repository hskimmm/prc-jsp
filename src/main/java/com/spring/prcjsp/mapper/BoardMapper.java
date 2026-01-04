package com.spring.prcjsp.mapper;

import com.spring.prcjsp.domain.Board;
import com.spring.prcjsp.util.Pagination;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {
    List<Board> getBoards(Pagination pagination);

    void write(Board board);

    Board getBoard(Long id);

    void incrementViewCount(Long id);

    void modify(Board board);

    void delete(Long id);

    int getTotal(Pagination pagination);
}
