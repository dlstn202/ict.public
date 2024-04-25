package com.ict.finalproject.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("notice_file")
public class NoticeFileVo {
	
	int	   file_idx;		//파일 idx
	int	   not_idx;			//공지사항 idx
	String file_name;		//파일이름
	String file_regdate;	//등록일자
	String file_del_yn;		//삭제유무
	String file_deldate;	//삭제일자

}
