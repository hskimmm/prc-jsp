package com.spring.prcjsp.service;

import com.spring.prcjsp.domain.Board;
import com.spring.prcjsp.dto.WriteBoardDTO;
import com.spring.prcjsp.response.ApiResponse;
import jakarta.validation.Valid;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface BoardService {
    List<Board> getBoards();

    ApiResponse<?> write(@Valid WriteBoardDTO writeBoardDTO, List<MultipartFile> files);
}
