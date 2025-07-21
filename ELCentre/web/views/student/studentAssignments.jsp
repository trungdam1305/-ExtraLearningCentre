<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/views/student/sidebar.jsp" %>
<c:if test="${empty sessionScope.user}">
    <c:redirect url="${pageContext.request.contextPath}/views/login.jsp" />
</c:if>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Bài tập của lớp</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-style.css">
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                margin: 0;
                padding: 0;
                display: flex;
                background-color: #f4f6f9;
            }
            .main-content {
                margin-left: 260px;
                flex: 1;
                padding: 40px;
            }
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
            }
            .assignment-card {
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
                padding: 20px;
                margin-bottom: 20px;
            }
            .assignment-card h3 {
                color: #1F4E79;
                margin-top: 0;
            }
            .assignment-card p {
                color: #555;
                line-height: 1.6;
            }
            .assignment-info {
                display: flex;
                justify-content: space-between;
                font-size: 0.9em;
                color: #777;
                margin-bottom: 15px;
                flex-wrap: wrap;
            }
            .assignment-info span {
                margin-right: 20px;
            }
            
            .sidebar {
            width: 260px;
            background-color: #1F4E79;
            height: 100vh;
            padding: 20px;
            color: white;
            position: fixed;
            }
            .sidebar-title {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 25px;
            }
            .sidebar-section {
                margin-top: 20px;
                font-size: 20px;
                font-weight: bold;
                color: #a9c0dc;
                letter-spacing: 1px;
                border-top: 1px solid #3e5f87;
                padding-top: 10px;
            }
            .sidebar a {
                display: block;
                text-decoration: none;
                color: white;
                padding: 8px 0;
                font-size: 20px;
                transition: background-color 0.2s ease;
            }
            .sidebar a:hover {
                background-color: #294f78;
                padding-left: 10px;
            }
            
            .submission-status {
                margin-top: 15px;
                padding-top: 15px;
                border-top: 1px solid #eee;
            }
            .submitted-file-info {
                background-color: #e6f7ff; /* Light blue background for submitted info */
                border: 1px solid #99dfff;
                border-radius: 5px;
                padding: 10px;
                margin-bottom: 10px;
            }
            .submitted-file-info p {
                margin: 5px 0;
            }
            .submitted-file-info .download-link {
                color: #1F4E79;
                text-decoration: none;
                font-weight: bold;
            }
            .submitted-file-info .download-link:hover {
                text-decoration: underline;
            }

            .submission-form {
                margin-top: 15px;
                border-top: 1px solid #eee;
                padding-top: 15px;
            }
            .submission-form label {
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
                color: #333;
            }
            .submission-form input[type="file"] {
                border: 1px solid #ccc;
                padding: 8px;
                border-radius: 5px;
                width: calc(100% - 18px); /* Adjust for padding */
                margin-bottom: 10px;
            }
            .submission-form button {
                background-color: #5E936C;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 1em;
                transition: background-color 0.2s ease;
            }
            .submission-form button:hover {
                background-color: #3E5F44;
            }
            .message.success {
                color: green;
                background-color: #e6ffe6;
                border: 1px solid green;
                padding: 10px;
                border-radius: 5px;
                margin-bottom: 15px;
            }
            .message.error {
                color: red;
                background-color: #ffe6e6;
                border: 1px solid red;
                padding: 10px;
                border-radius: 5px;
                margin-bottom: 15px;
            }
            .no-assignments {
                text-align: center;
                color: #888;
                padding: 30px;
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
            }
            /* Pagination styles */
            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 30px;
                padding-bottom: 20px;
            }
            .pagination a, .pagination span {
                color: #1F4E79;
                float: left;
                padding: 8px 16px;
                text-decoration: none;
                border: 1px solid #ddd;
                margin: 0 4px;
                border-radius: 5px;
                transition: background-color .3s;
            }
            .pagination a:hover:not(.active) {
                background-color: #f2f2f2;
            }
            .pagination span.active {
                background-color: #1F4E79;
                color: white;
                border: 1px solid #1F4E79;
            }
            
            .search-container {
                display: flex;
                justify-content: flex-end; /* Align to the right */
                margin-bottom: 20px;
                gap: 10px;
            }

            .search-container input[type="text"] {
                padding: 10px 15px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 1em;
                width: 300px; /* Adjust width as needed */
            }

            .search-container button {
                background-color: #1F4E79;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 1em;
                transition: background-color 0.2s ease;
            }

            .search-container button:hover {
                background-color: #163d5c;
            }
            
            .back-button-container {
                margin-top: 20px;
                text-align: left;
            }

            .back-button {
                display: inline-flex;
                align-items: center;
                padding: 10px 15px;
                background-color: #6c757d; 
                color: white;
                border: none;
                border-radius: 5px;
                text-decoration: none;
                font-size: 1em;
                cursor: pointer;
                transition: background-color 0.2s ease;
                margin-left:900px;
                transform: translateY(-80px);
            }

            .back-button i {
                margin-right: 8px;
            }

            .back-button:hover {
                background-color: #5a6268;
            
        </style>
    </head>
    <body>
        <div class="main-content">
            <div class="header">
                <h2>Bài tập của lớp ${className}</h2>
                <span>Xin chào ${sessionScope.user.email}</span>
            </div>

            <c:if test="${not empty successMessage}">
                <div class="message success">${successMessage}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="message error">${errorMessage}</div>
            </c:if>


            <div class="search-container">
                <form action="${pageContext.request.contextPath}/StudentAssignmentServlet" method="get">
                    <input type="hidden" name="classId" value="${classId}">
                    <input type="text" name="search" placeholder="Tìm kiếm bài tập..." value="${searchQuery != null ? searchQuery : ''}">
                    <button type="submit">Tìm kiếm</button>
                </form>
            </div>
            
            <c:choose>
                <c:when test="${not empty assignments}">
                    <c:forEach var="assignment" items="${assignments}">
                        <div class="assignment-card">
                            <h3>${assignment.tenBaiTap}</h3>
                            <div class="assignment-info">
                                <span>Ngày giao: <strong> ${assignment.ngayTao}</strong></span>
                                <span>Hạn nộp:<strong> ${assignment.deadline}</strong></span>
                            </div>
                            <p>${assignment.moTa}</p>
                            <c:if test="${not empty assignment.fileName}">
                                <p>Tệp đính kèm: <a href="${pageContext.request.contextPath}/uploads/${assignment.fileName}" download>${assignment.fileName}</a></p>
                            </c:if>

                            <div class="submission-status">
                                <h4>Trạng thái nộp bài</h4>
                                <c:set var="currentSubmission" value="${studentSubmissions[assignment.ID_BaiTap]}" />
                                <c:choose>                                        
                                    <!--If have submitted before-->
                                    <c:when test="${not empty currentSubmission}">
                                        <div class="submitted-file-info">
                                            <p>Bạn đã nộp bài vào: ${currentSubmission.ngayNop}</p>
                                            <p>Tệp bạn đã nộp:
                                                <a href="${pageContext.request.contextPath}/uploads/${currentSubmission.tepNop}" class="download-link" download>
                                                    <i class="fas fa-file-alt"></i> ${currentSubmission.tepNop}
                                                </a>
                                            </p>
                                            <c:if test="${not empty currentSubmission.diem}">
                                                <p>Điểm của bạn: <strong>${currentSubmission.diem}</strong></p>
                                            </c:if>
                                            <c:if test="${ empty currentSubmission.diem}">
                                                <p>Điểm của bạn: <strong>null</strong></p>
                                            </c:if>    
                                            <c:if test="${not empty currentSubmission.nhanXet}">
                                                <p>Nhận xét của giáo viên: <em>"${currentSubmission.nhanXet}"</em></p>
                                            </c:if>
                                            <c:if test="${ empty currentSubmission.nhanXet}">
                                                <p>Nhận xét của giáo viên: <em>null</em></p>
                                            </c:if>    
                                            <p class="resubmit-note">Bạn có thể nộp lại bài để cập nhật.</p>
                                        </div>
                                        <div class="submission-form">
                                            <h5>Nộp lại bài tập (sẽ ghi đè bản nộp trước)</h5>
                                            <form action="${pageContext.request.contextPath}/StudentAssignmentServlet" method="post" enctype="multipart/form-data">
                                                <input type="hidden" name="assignmentId" value="${assignment.ID_BaiTap}">
                                                <input type="hidden" name="classId" value="${classId}">
                                                <c:if test="${not empty searchQuery}">
                                                    <input type="hidden" name="search" value="${searchQuery}">
                                                </c:if>
                                                <label for="resubmitFile_${assignment.ID_BaiTap}">Chọn tệp để nộp lại:</label>
                                                <input type="file" id="resubmitFile_${assignment.ID_BaiTap}" name="submissionFile" required>
                                                <button type="submit">Nộp lại</button>
                                            </form>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <p>Bạn chưa nộp bài tập này.</p>
                                        <div class="submission-form">
                                            <h5>Nộp bài tập</h5>
                                            <form action="${pageContext.request.contextPath}/StudentAssignmentServlet" method="post" enctype="multipart/form-data">
                                                <input type="hidden" name="assignmentId" value="${assignment.ID_BaiTap}">
                                                <input type="hidden" name="classId" value="${classId}">
                                                <%-- Ensure search query is passed in POST form if active --%>
                                                <c:if test="${not empty searchQuery}">
                                                    <input type="hidden" name="search" value="${searchQuery}">
                                                </c:if>
                                                <label for="submissionFile_${assignment.ID_BaiTap}">Chọn tệp để nộp:</label>
                                                <input type="file" id="submissionFile_${assignment.ID_BaiTap}" name="submissionFile" required>
                                                <button type="submit">Nộp bài</button>
                                            </form>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>

                    <div class="pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="${pageContext.request.contextPath}/StudentAssignmentServlet?classId=${classId}&page=${currentPage - 1}${searchQuery != null ? '&search=' : ''}${searchQuery != null ? searchQuery : ''}">Trước</a>
                        </c:if>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <c:choose>
                                <c:when test="${i == currentPage}">
                                    <span class="active">${i}</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/StudentAssignmentServlet?classId=${classId}&page=${i}${searchQuery != null ? '&search=' : ''}${searchQuery != null ? searchQuery : ''}">${i}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <c:if test="${currentPage < totalPages}">
                            <a href="${pageContext.request.contextPath}/StudentAssignmentServlet?classId=${classId}&page=${currentPage + 1}${searchQuery != null ? '&search=' : ''}${searchQuery != null ? searchQuery : ''}">Sau</a>
                        </c:if>
                    </div>

                </c:when>
                <c:otherwise>
                    <div class="no-assignments">
                        <c:if test="${not empty searchQuery}">
                            Không tìm thấy bài tập nào với từ khóa "${searchQuery}".
                        </c:if>
                        <c:if test="${empty searchQuery}">
                            Không có bài tập nào được đăng cho lớp này.
                        </c:if>
                    </div>
                </c:otherwise>
            </c:choose>
                    
            <div class="back-button-container">
                <a href="${pageContext.request.contextPath}/StudentViewClassServlet?classCode=${classCode}" class="back-button">
                    <i class="fas fa-arrow-left"></i> Quay lại chi tiết lớp
                </a>
            </div>
        </div>
    </body>
</html>