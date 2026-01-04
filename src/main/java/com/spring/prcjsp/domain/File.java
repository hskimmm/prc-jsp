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
public class File {
    private Long id;
    private String refType;
    private Long refId;
    private String fileType;
    private String originalName;
    private String savedName;
    private String filePath;
    private Long fileSize;
    private String fileExt;
    private Integer downloadCount;
    private Integer displayOrder;
    private LocalDateTime regDate;
}
