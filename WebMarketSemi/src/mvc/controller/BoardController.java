package mvc.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.BoardDAO;
import mvc.model.BoardDTO;

public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final int LISTCOUNT = 5;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = requestURI.substring(contextPath.length());
		
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.print("<html><body>"+request.getRequestURL()+"<br>"+requestURI+"<br>"+contextPath+"<br>"+command+"</body></html>");
		RequestDispatcher rd = null;
		
		if(command.equals("/BoardListAction.do")) {
			requestBoardList(request);
			rd = request.getRequestDispatcher("./board/list.jsp");
		}else if(command.equals("/BoardWriteFormAction.do")) {
			rd = request.getRequestDispatcher("./board/writeForm.jsp");
		}else if(command.equals("/BoardWriteAction.do")) {
			rd = request.getRequestDispatcher("/BoardListAction.do");
		}
		rd.forward(request, response);
	}

	private void requestBoardList(HttpServletRequest request) {
		BoardDAO dao = BoardDAO.getInstance();
		List<BoardDTO> boardList = new ArrayList<>();
		int pageNum = 1;
		int limit = LISTCOUNT;
		
		if(request.getParameter("pageNum")!=null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		
		String items = request.getParameter("items");
		String text = request.getParameter("text");
		int total_record = dao.getListCount(items,text);
		
		boardList = dao.getBoardList(pageNum,limit,items,text);
		int total_page;
		
		if(total_record%limit==0) {
			total_page = total_record/limit;
			Math.floor(total_page);
		}else {
			total_page = total_record/limit;
			Math.floor(total_page);
			total_page+=1;
		}
		
		request.setAttribute("pageNum",pageNum);
		request.setAttribute("total_page",total_page);
		request.setAttribute("total_record",total_record);
		request.setAttribute("boardlist",boardList);
		request.setAttribute("items",items);
		request.setAttribute("text",text);
	}
}