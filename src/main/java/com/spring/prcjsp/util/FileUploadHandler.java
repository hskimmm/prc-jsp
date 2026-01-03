package com.spring.prcjsp.util;

import com.spring.prcjsp.domain.File;
import com.spring.prcjsp.mapper.FileMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

@Component
@RequiredArgsConstructor
@Slf4j
public class FileUploadHandler {
    private final FileMapper fileMapper;

    @Value("${file.upload.path}")
    private String uploadPath;

    /**
     * 파일 저장 (물리 파일 + DB)
     */
    public void saveFiles(List<MultipartFile> files, String refType, Long refId) throws IOException {
        if (files == null || files.isEmpty()) {
            return;
        }

        int order = 0;

        for (MultipartFile file : files) {
            if (file.isEmpty()) continue;

            // 파일 정보 생성
            String originalName = file.getOriginalFilename();
            String extension = getFileExtension(originalName);
            String savedName = generateSavedName(extension);
            String datePath = getDatePath();
            String fileType = getFileType(extension);

            // 물리 파일 저장
            savePhysicalFile(file, datePath, savedName);

            // DB 저장
            File fileVO = File.builder()
                    .refType(refType)
                    .refId(refId)
                    .fileType(fileType)
                    .originalName(originalName)
                    .savedName(savedName)
                    .filePath(datePath)
                    .fileSize(file.getSize())
                    .fileExt(extension)
                    .downloadCount(0)
                    .displayOrder(order++)
                    .build();

            fileMapper.insertFile(fileVO);
        }
    }

    /**
     * 확장자 추출
     */
    private String getFileExtension(String filename) {
        int lastDot = filename.lastIndexOf(".");
        if (lastDot == -1) return "";
        return filename.substring(lastDot + 1).toLowerCase();
    }

    /**
     * 저장 파일명 생성 (UUID)
     */
    private String generateSavedName(String extension) {
        String uuid = UUID.randomUUID().toString().replace("-", "");
        return extension.isEmpty() ? uuid : uuid + "." + extension;
    }

    /**
     * 날짜 경로 생성 (yyyy/MM/dd)
     */
    private String getDatePath() {
        LocalDate now = LocalDate.now();
        return String.format("%d/%02d/%02d", now.getYear(), now.getMonthValue(), now.getDayOfMonth());
    }

    /**
     * 파일 타입 판별
     */
    private String getFileType(String extension) {
        List<String> imageExts = Arrays.asList("jpg", "jpeg", "png", "gif", "bmp", "webp");
        List<String> docExts = Arrays.asList("pdf", "doc", "docx", "xls", "xlsx", "ppt", "pptx", "hwp");

        if (imageExts.contains(extension)) {
            return "IMAGE";
        } else if (docExts.contains(extension)) {
            return "DOCUMENT";
        } else {
            return "ATTACHMENT";
        }
    }

    /**
     * 물리 파일 저장
     */
    private void savePhysicalFile(MultipartFile file, String datePath, String savedName) throws IOException {
        String fullPath = uploadPath + java.io.File.separator + datePath;

        // 디렉토리 생성
        java.io.File dir = new java.io.File(fullPath);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        // 파일 저장
        Path path = Paths.get(fullPath, savedName);
        file.transferTo(path);
    }

    /**
     * 단일 파일 삭제 (물리 파일 삭제 + DB 삭제)
     */
    public void deleteFile(File fileVO) {
        if (fileVO == null) return;

        // 실제 파일 경로 생성
        String fullPath = uploadPath + java.io.File.separator
                + fileVO.getFilePath() + java.io.File.separator
                + fileVO.getSavedName();

        java.io.File physicalFile = new java.io.File(fullPath);

        // 실제 파일 삭제
        if (physicalFile.exists()) {
            boolean deleted = physicalFile.delete();
            if (!deleted) {
                log.warn("파일 삭제 실패: {}", fullPath);
            } else {
                log.info("파일 삭제 성공: {}", fullPath);
            }
        } else {
            log.warn("파일 존재하지 않음: {}", fullPath);
        }

        // DB 삭제
        fileMapper.deleteFile(fileVO.getId());
    }
}
