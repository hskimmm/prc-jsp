package com.spring.prcjsp.dto;

import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class WriteBoardDTO {
    @NotEmpty(message = "게시글의 제목을 입력하세요")
    private String title;

    @NotEmpty(message = "게시글의 내용을 입력하세요")
    private String content;

    @NotEmpty(message = "게시글읠 타입을 선택하세요")
    private String boardType;

    @NotEmpty(message = "게시글의 작성자를 입력하세요")
    private String regUserName;
}
