package com.ict.finalproject.util;

public class Paging {

    public static String getPaging(String pageURL,int nowPage, int rowTotal,int blockList, int blockPage){
		
		int totalPage/*전체페이지수*/,
            startPage/*시작페이지번호*/,
            endPage;/*마지막페이지번호*/

		boolean  isPrevPage,isNextPage;
		StringBuffer sb; //모든 상황을 판단하여 HTML코드를 저장할 곳
		
		
		isPrevPage=isNextPage=false;
		//입력된 전체 자원을 통해 전체 페이지 수를 구한다..
		totalPage = rowTotal/blockList;
		if(rowTotal%blockList!=0)totalPage++;
		

		//만약 잘못된 연산과 움직임으로 인하여 현재 페이지 수가 전체 페이지 수를
		//넘을 경우 강제로 현재페이지 값을 전체 페이지 값으로 변경
		if(nowPage > totalPage)nowPage = totalPage;
		

		//시작 페이지와 마지막 페이지를 구함.
		startPage = ((nowPage-1)/blockPage)*blockPage+1;
		endPage = startPage + blockPage - 1; //
		
		//마지막 페이지 수가 전체페이지수보다 크면 마지막페이지 값을 변경
		if(endPage > totalPage)endPage = totalPage;
		
		//마지막페이지가 전체페이지보다 작을 경우 다음 페이징이 적용할 수 있도록
		//boolean형 변수의 값을 설정
		if(endPage < totalPage) isNextPage = true;
		//시작페이지의 값이 1보다 작으면 이전페이징 적용할 수 있도록 값설정
		if(startPage > 1)isPrevPage = true;
		
		//HTML코드를 저장할 StringBuffer생성=>코드생성
		sb = new StringBuffer("<ul class=\"pagination\">");
//-----그룹페이지처리 이전 --------------------------------------------------------------------------------------------		
		if(isPrevPage){
			sb.append("<li><a href ='"+pageURL+"?page=");
			sb.append(startPage-1);
			sb.append("'>◀</a></li>");
		}
		else
			sb.append("<li class=\"disabled\"><a>◀</a></li>");
		
//------페이지 목록 출력 -------------------------------------------------------------------------------------------------
//		sb.append("|");
		for(int i=startPage; i<= endPage ;i++){
			if(i>totalPage)break;
			if(i == nowPage){ //현재 있는 페이지
				sb.append("<li class=\"active\"><a>");
				sb.append(i);
				sb.append("</a></li>");
			}
			else{//현재 페이지가 아니면
				sb.append("<li ><a href='"+pageURL+"?page=");
				sb.append(i);
				sb.append("'>");
				sb.append(i);
				sb.append("</a></li>");
			}
		}// end for
		
//		sb.append("&nbsp;|");
		
//-----그룹페이지처리 다음 ----------------------------------------------------------------------------------------------
		if(isNextPage){
			sb.append("<li ><a href='"+pageURL+"?page=");
			sb.append(endPage+1);
			sb.append("'>▶</a></li></ul>");
		}
		else
			sb.append("<li class=\"disabled\"><a>▶</a></li></ul>");
//---------------------------------------------------------------------------------------------------------------------	    

		return sb.toString();
	}

	public static String getPaging(String pageURL,int nowPage, int rowTotal,int blockList, int blockPage,String search_filter){
		
		int totalPage/*전체페이지수*/,
		startPage/*시작페이지번호*/,
		endPage;/*마지막페이지번호*/
		
		boolean  isPrevPage,isNextPage;
		StringBuffer sb; //모든 상황을 판단하여 HTML코드를 저장할 곳
		
		
		isPrevPage=isNextPage=false;
		//입력된 전체 자원을 통해 전체 페이지 수를 구한다..
		totalPage = rowTotal/blockList;
		if(rowTotal%blockList!=0)totalPage++;
		
		
		//만약 잘못된 연산과 움직임으로 인하여 현재 페이지 수가 전체 페이지 수를
		//넘을 경우 강제로 현재페이지 값을 전체 페이지 값으로 변경
		if(nowPage > totalPage)nowPage = totalPage;
		
		
		//시작 페이지와 마지막 페이지를 구함.
		startPage = ((nowPage-1)/blockPage)*blockPage+1;
		endPage = startPage + blockPage - 1; //
		
		//마지막 페이지 수가 전체페이지수보다 크면 마지막페이지 값을 변경
		if(endPage > totalPage)endPage = totalPage;
		
		//마지막페이지가 전체페이지보다 작을 경우 다음 페이징이 적용할 수 있도록
		//boolean형 변수의 값을 설정
		if(endPage < totalPage) isNextPage = true;
		//시작페이지의 값이 1보다 작으면 이전페이징 적용할 수 있도록 값설정
		if(startPage > 1)isPrevPage = true;
		
		//HTML코드를 저장할 StringBuffer생성=>코드생성
		sb = new StringBuffer("<ul class=\"pagination\">");
//-----그룹페이지처리 이전 --------------------------------------------------------------------------------------------		
		if(isPrevPage){
			sb.append(String.format("<li ><a href='%s?page=%d%s'>◀</a></li>",pageURL,startPage-1,search_filter));
		}
		else
			sb.append("<li class=\"disabled\"><a>◀</a></li>");
		
//------페이지 목록 출력 -------------------------------------------------------------------------------------------------
//		sb.append("|");
		for(int i=startPage; i<= endPage ;i++){
			if(i>totalPage)break;
			if(i == nowPage){ //현재 있는 페이지
				sb.append("<li class=\"active\"><a>");
				sb.append(i);
				sb.append("</a></li>");
			}
			else{//현재 페이지가 아니면
				sb.append(String.format("<li ><a href='%s?page=%d%s'>%d</a></li>",pageURL,i,search_filter,i));
			}
		}// end for
		
//		sb.append("&nbsp;|");
		
//-----그룹페이지처리 다음 ----------------------------------------------------------------------------------------------
		if(isNextPage){
			sb.append(String.format("<li ><a href='%s?page=%d%s'>▶</a></li></ul>",pageURL,endPage+1,search_filter));
		}
		else
			sb.append("<li class=\"disabled\"><a>▶</a></li></ul>");
//---------------------------------------------------------------------------------------------------------------------	    
		
		return sb.toString();
	}
	
//에이젝스 페이징
public static String getAjaxPaging(int nowPage, int rowTotal,int blockList, int blockPage){
		
		int totalPage/*전체페이지수*/,
            startPage/*시작페이지번호*/,
            endPage;/*마지막페이지번호*/

		boolean  isPrevPage,isNextPage;
		StringBuffer sb; //모든 상황을 판단하여 HTML코드를 저장할 곳
		
		
		isPrevPage=isNextPage=false;
		//입력된 전체 자원을 통해 전체 페이지 수를 구한다..
		totalPage = rowTotal/blockList;
		if(rowTotal%blockList!=0)totalPage++;
		

		//만약 잘못된 연산과 움직임으로 인하여 현재 페이지 수가 전체 페이지 수를
		//넘을 경우 강제로 현재페이지 값을 전체 페이지 값으로 변경
		if(nowPage > totalPage)nowPage = totalPage;
		

		//시작 페이지와 마지막 페이지를 구함.
		startPage = ((nowPage-1)/blockPage)*blockPage+1;
		endPage = startPage + blockPage - 1; //
		
		//마지막 페이지 수가 전체페이지수보다 크면 마지막페이지 값을 변경
		if(endPage > totalPage)endPage = totalPage;
		
		//마지막페이지가 전체페이지보다 작을 경우 다음 페이징이 적용할 수 있도록
		//boolean형 변수의 값을 설정
		if(endPage < totalPage) isNextPage = true;
		//시작페이지의 값이 1보다 작으면 이전페이징 적용할 수 있도록 값설정
		if(startPage > 1)isPrevPage = true;

        // System.out.println("nowPage : "+nowPage);
        // System.out.println("rowTotal : "+rowTotal);
        // System.out.println("totalPage : "+totalPage);
        // System.out.println("blockList : "+blockList);
        // System.out.println("blockPage : "+blockPage);
		
		//HTML코드를 저장할 StringBuffer생성=>코드생성
		sb = new StringBuffer("<nav class=\"pagiset pagiset-circ\">");
//-----그룹페이지처리 이전 --------------------------------------------------------------------------------------------		
		if(isPrevPage){
			sb.append(String.format("<div class=\"pagiset-ctrl\" onclick=\"page_move(%d);\"><a class=\"pagiset-link pagiset-prev\" href=\"javascript:void(0)\"><span class=\"visually-hidden\">이전</span></a></div>",startPage-1));
		}
		else
			sb.append("<div class=\"pagiset-ctrl\"></div>");
		
//------페이지 목록 출력 -------------------------------------------------------------------------------------------------
		sb.append("<div class=\"pagiset-list\">");
		for(int i=startPage; i<= endPage ;i++){
			if(i>totalPage)break;
			if(i == nowPage){ //현재 있는 페이지
				sb.append(String.format("<a class=\"pagiset-link active-fill\" href=\"javascript:void(0)\">%d</a>",i));
			}
			else{//현재 페이지가 아니면
				sb.append(String.format("<a class=\"pagiset-link\" href=\"javascript:void(0)\" onclick=\"page_move(%d);\">%d</a>",i,i));
			}
		}// end for
		
		sb.append("</div>");
		
//-----그룹페이지처리 다음 ------------------- 	---------------------------------------------------------------------------
		if(isNextPage){
			sb.append(String.format("<div class=\"pagiset-ctrl\" onclick=\"page_move(%d);\"><a class=\"pagiset-link pagiset-next\" href=\"javascript:void(0)\"><span class=\"visually-hidden\">다음</span></a></div>",endPage+1));
		}
		else
			sb.append("<div class=\"pagiset-ctrl\"></div>");
//---------------------------------------------------------------------------------------------------------------------	    

		return sb.toString();
	}
	
    
}
