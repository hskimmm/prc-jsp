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
public class UpdateCommentDTO {
    
    @NotNull(message = "댓글이 존재하지 않습니다")
    private Long id;
    
    @NotEmpty(message = "댓글 내용을 입력하세요")
    private String content;
}
