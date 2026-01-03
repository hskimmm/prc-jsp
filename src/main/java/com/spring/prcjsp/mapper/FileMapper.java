package com.spring.prcjsp.mapper;

import com.spring.prcjsp.domain.File;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface FileMapper {
    void insertFile(File fileVO);

    void deleteFile(Long id);

    List<File> getFileList(Long id);
}
