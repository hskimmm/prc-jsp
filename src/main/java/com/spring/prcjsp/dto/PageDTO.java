package com.spring.prcjsp.dto;

import com.spring.prcjsp.util.Pagination;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
    private int startPage;
    private int endPage;
    private boolean prev, next;
    private int total;
    private Pagination pagination;

    public PageDTO(Pagination pagination, int total) {
        this.pagination = pagination;
        this.total = total;

        if (total == 0) { //값이 없을 경우 1,0 으로 페이지 버튼 나오는 버그 방지
            this.startPage = 1;
            this.endPage = 1;
            this.prev = false;
            this.next = false;
            return;
        }

        this.endPage = (int) (Math.ceil(pagination.getPageNum() / 10.0)) * 10;
        this.startPage = endPage - 9;

        int realEnd = (int) Math.ceil((total * 1.0) / pagination.getAmount());

        if (realEnd <= this.endPage) {
            this.endPage = realEnd;
        }

        this.prev = this.startPage > 1;
        this.next = this.endPage < realEnd;
    }
}
