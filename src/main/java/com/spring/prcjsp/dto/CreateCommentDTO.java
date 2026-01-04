package com.spring.prcjsp.dto;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CreateCommentDTO {
    @NotNull(message = "게시글이 존재하지 않습니다")
    private Long boardId;

    @NotEmpty(message = "댓글 내용을 입력하세요")
    private String content;

    @NotEmpty(message = "댓글 작성자를 입력하세요")
    private String regUserName;
}
