package com.spring.prcjsp.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Board {
    private Long id;
    private String title;
    private String content;
    private String boardType;
    private Integer viewCount;
    private String isTop;
    private String regUserName;
    private LocalDateTime regDate;
    private LocalDateTime modDate;
    private String delYn;
    private List<File> fileList;
}
