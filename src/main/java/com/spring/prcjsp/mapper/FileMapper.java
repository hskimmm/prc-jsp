package com.spring.prcjsp.mapper;

import com.spring.prcjsp.domain.File;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FileMapper {
    void insertFile(File fileVO);

    void deleteFile(Long id);
}
