package com.spring.prcjsp.service;

import com.spring.prcjsp.domain.Board;
import com.spring.prcjsp.domain.File;
import com.spring.prcjsp.dto.ModifyBoardDTO;
import com.spring.prcjsp.dto.WriteBoardDTO;
import com.spring.prcjsp.mapper.BoardMapper;
import com.spring.prcjsp.mapper.FileMapper;
import com.spring.prcjsp.response.ApiResponse;
import com.spring.prcjsp.util.FileUploadHandler;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Service
@RequiredArgsConstructor
@Log4j2
public class BoardServiceImpl implements BoardService{

    private final BoardMapper boardMapper;
    private final FileMapper fileMapper;
    private final FileUploadHandler fileUploadHandler;

    @Transactional(readOnly = true)
    @Override
    public List<Board> getBoards() {
        try {
            return boardMapper.getBoards();
        } catch (DataAccessException e) {
            log.error("게시판 조회(데이터베이스 오류) = {}", e.getMessage());
            throw new RuntimeException("게시판 조회 중 오류가 발생하였습니다");
        } catch (Exception e) {
            log.error("게시판 조회(기타 오류) = {}", e.getMessage());
            throw new RuntimeException("게시판 조회 중 오류가 발생하였습니다");
        }
    }

    @Transactional
    @Override
    public ApiResponse<?> write(WriteBoardDTO writeBoardDTO, List<MultipartFile> files) {
        try {
            Board board = Board.builder()
                    .title(writeBoardDTO.getTitle())
                    .content(writeBoardDTO.getContent())
                    .boardType(writeBoardDTO.getBoardType())
                    .regUserName(writeBoardDTO.getRegUserName())
                    .build();

            boardMapper.write(board);

            //파일이 존재하는 경우 처리
            if (files != null && !files.isEmpty()) {
                fileUploadHandler.saveFiles(files, "BOARD", board.getId());
            }

            return new ApiResponse<>(true, "게시글을 등록하였습니다");
        } catch (IOException e) {
            log.error("게시글 등록(파일 오류) = {}", e.getMessage());
            throw new RuntimeException("게시글 등록 중 파일 오류가 발생하였습니다");
        } catch (DataAccessException e) {
            log.error("게시글 등록(데이터베이스 오류) = {}", e.getMessage());
            throw new RuntimeException("게시글 등록 중 데이터베이스 오류가 발생하였습니다");
        } catch (Exception e) {
            log.error("게시글 등록(기타 오류) = {}", e.getMessage());
            throw new RuntimeException("게시글 등록 중 오류가 발생하였습니다");
        }
    }

    @Override
    public Board getBoard(Long id) {
        boardMapper.incrementViewCount(id);
        return boardMapper.getBoard(id);
    }

    @Transactional
    @Override
    public ApiResponse<?> modify(ModifyBoardDTO modifyBoardDTO, List<MultipartFile> files, String[] deletedFileIds) {
        try {
            Board board = Board.builder()
                    .id(modifyBoardDTO.getId())
                    .title(modifyBoardDTO.getTitle())
                    .content(modifyBoardDTO.getContent())
                    .regUserName(modifyBoardDTO.getRegUserName())
                    .build();

            boardMapper.modify(board);

            if (files != null && !files.isEmpty()) {
                fileUploadHandler.saveFiles(files, "BOARD", board.getId());
            }

            if (deletedFileIds != null) {
                for (String file : deletedFileIds) {
                    Long fileId = Long.parseLong(file);
                    fileMapper.deleteFile(fileId);
                }
            }

            return new ApiResponse<>(true, "게시글을 수정하였습니다");
        } catch (IOException e) {
            log.error("게시글 수정(파일 오류) = {}", e.getMessage());
            throw new RuntimeException("게시글 수정 중 파일 오류가 발생하였습니다");
        } catch (DataAccessException e) {
            log.error("게시글 수정(데이터베이스 오류) = {}", e.getMessage());
            throw new RuntimeException("게시글 수정 중 데이터베이스 오류가 발생하였습니다");
        } catch (Exception e) {
            log.error("게시글 수정(기타 오류) = {}", e.getMessage());
            throw new RuntimeException("게시글 수정 중 오류가 발생하였습니다");
        }
    }

    @Transactional
    @Override
    public ApiResponse<?> delete(Long id) {
        try {
            List<File> fileList = fileMapper.getFileList(id);
            if (fileList != null && !fileList.isEmpty()) {
                for (File file : fileList) {
                    fileUploadHandler.deleteFile(file);
                }
            }

            boardMapper.delete(id);
            return new ApiResponse<>(true, "게시글을 삭제하였습니다");
        } catch (DataAccessException e) {
            log.error("게시글 삭제(데이터베이스 오류) = {}", e.getMessage());
            throw new RuntimeException("게시글 삭제 중 데이터베이스 오류가 발생하였습니다");
        } catch (Exception e) {
            log.error("게시글 삭제(기타 오류) = {}", e.getMessage());
            throw new RuntimeException("게시글 삭제 중 오류가 발생하였습니다");
        }
    }
}
