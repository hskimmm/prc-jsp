package com.spring.prcjsp.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Comment {
    private Long id;
    private Long boardId;
    private Long parentId;
    private String content;
    private String regUserName;
    private LocalDateTime regDate;
    private LocalDateTime modDate;
    private String delYn;
}
