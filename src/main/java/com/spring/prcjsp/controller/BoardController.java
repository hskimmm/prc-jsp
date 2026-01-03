package com.spring.prcjsp.controller;

import com.spring.prcjsp.domain.Board;
import com.spring.prcjsp.service.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
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
}
