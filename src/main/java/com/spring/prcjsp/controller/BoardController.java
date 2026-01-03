package com.spring.prcjsp.controller;

import com.spring.prcjsp.domain.Board;
import com.spring.prcjsp.dto.WriteBoardDTO;
import com.spring.prcjsp.response.ApiResponse;
import com.spring.prcjsp.service.BoardService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
@Log4j2
public class BoardController {

    private final BoardService boardService;

    @GetMapping
    public String list(Model model) {
        List<Board> boardList = boardService.getBoards();
        model.addAttribute("boardList", boardList);
        return "board/list";
    }

    @GetMapping("/{id}")
    public String read(@PathVariable(value = "id") Long id) {
        return "board/read";
    }

    @GetMapping("/write")
    public String writeForm() {
        return "board/write";
    }

    @PostMapping
    public ResponseEntity<ApiResponse<?>> write(@Valid @ModelAttribute WriteBoardDTO writeBoardDTO, @RequestParam(value = "files", required = false) List<MultipartFile> files) {
        ApiResponse<?> response = boardService.write(writeBoardDTO, files);
        return ResponseEntity.ok(response);
    }
}
