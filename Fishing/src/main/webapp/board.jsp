<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="board.Board"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<link rel="stylesheet" href="resource/css/bootstrap.css">
<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
</style>
<title>Fishing</title>
</head>
<body>
	<%
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	%>
	<jsp:include page="header.jsp"></jsp:include>
	
	<div class="container">
		<br>
		<h1>자유 게시판</h1>
		<p>자유롭게 글을 쓰는 곳입니다. 서로 존중하며 글과 댓글을 남깁시다.</p>
	</div>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						BoardDAO boardDAO = new BoardDAO();
						ArrayList<Board> list = boardDAO.getList(pageNumber);
						for (int i = 0; i < list.size(); i++) {
					%>
						<tr>
							<td><%= list.get(i).getBoardID() %></td>
							<td><a href="view.jsp?boardID=<%=list.get(i).getBoardID()%>"><%= list.get(i).getBoardTitle().replaceAll(" ", "&nbps;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td>
							<td><%= list.get(i).getUserID() %></td>
							<td><%= list.get(i).getBoardDate().substring(0, 11) + list.get(i).getBoardDate().substring(11, 13) + "시 " + list.get(i).getBoardDate().substring(14, 16) + "분" %></td>
						</tr>
					<%
						}
					%>
				</tbody>
				<tr>
					<td colspan="6">
						<%
							if (pageNumber != 1) {
						%>
							<a href="board.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arraw-left">이전</a>
						<%
							} if (boardDAO.nextPage(pageNumber + 1)) {
						%>
							<a href="board.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arraw-left">다음</a>
						<%
							}
						%>
						<a href="write.jsp" class="btn btn-secondary">글쓰기</a>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<script src="resource/js/bootstrap.js"></script>
</body>
</html>