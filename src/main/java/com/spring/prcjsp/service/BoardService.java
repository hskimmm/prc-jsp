package com.spring.prcjsp.service;

import com.spring.prcjsp.domain.Board;
import com.spring.prcjsp.dto.ModifyBoardDTO;
import com.spring.prcjsp.dto.WriteBoardDTO;
import com.spring.prcjsp.response.ApiResponse;
import com.spring.prcjsp.util.Pagination;
import jakarta.validation.Valid;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface BoardService {
    List<Board> getBoards(Pagination pagination);

    ApiResponse<?> write(@Valid WriteBoardDTO writeBoardDTO, List<MultipartFile> files);

    Board getBoard(Long id);

    ApiResponse<?> modify(@Valid ModifyBoardDTO modifyBoardDTO, List<MultipartFile> files, String[] deletedFileIds);

    ApiResponse<?> delete(Long id);

    int getTotal(Pagination pagination);
}
