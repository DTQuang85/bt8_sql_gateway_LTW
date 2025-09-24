<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>SQL Gateway</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css" type="text/css"/>
    <style>
      body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f4f6f8;
        color: #333;
        margin: 0;
        padding: 0;
      }

      .container {
        max-width: 960px;
        margin: 30px auto;
        padding: 20px 25px;
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 6px 15px rgba(0, 0, 0, 0.08);
      }

      .header h1 {
        margin: 0 0 6px 0;
        font-size: 2rem;
        color: #2c3e50;
      }

      .header p {
        margin: 0 0 20px 0;
        color: #7f8c8d;
        font-size: 0.95rem;
      }

      .connection-status {
        padding: 10px 14px;
        margin-bottom: 18px;
        border-radius: 8px;
        font-weight: 500;
      }

      .connection-success {
        background-color: #e0f7e9;
        color: #2e7d32;
      }

      .connection-error {
        background-color: #fdecea;
        color: #c62828;
      }

      .sql-form label {
        display: block;
        margin-bottom: 6px;
        font-weight: 600;
      }

      textarea {
        width: 100%;
        min-height: 120px;
        padding: 10px 12px;
        border-radius: 8px;
        border: 1px solid #ccc;
        resize: vertical;
        font-family: monospace;
        font-size: 0.95rem;
        box-sizing: border-box;
        transition: border-color 0.3s;
      }

      textarea:focus {
        outline: none;
        border-color: #4a90e2;
        box-shadow: 0 0 5px rgba(74, 144, 226, 0.3);
      }

      .btn-execute {
        margin-top: 10px;
        padding: 10px 18px;
        border: none;
        border-radius: 8px;
        background-color: #4a90e2;
        color: white;
        font-weight: 600;
        cursor: pointer;
        transition: background-color 0.3s;
      }

      .btn-execute:hover {
        background-color: #357ab7;
      }

      .sql-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 14px;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
      }

      .sql-table th, .sql-table td {
        padding: 10px 12px;
        border: 1px solid #e0e0e0;
        text-align: left;
      }

      .sql-table th {
        background-color: #f1f3f6;
        font-weight: 600;
      }

      .sql-error {
        color: #c62828;
        font-weight: 500;
      }

      .sql-update {
        color: #2e7d32;
        font-weight: 500;
      }

      .result-section {
        margin-top: 20px;
      }

      .result-title {
        font-weight: 600;
        margin-bottom: 6px;
      }

      .result-content {
        padding: 12px;
        border-radius: 8px;
        background-color: #f9f9f9;
        border: 1px solid #e0e0e0;
        min-height: 40px;
        font-family: monospace;
        white-space: pre-wrap;
      }
  </style>

</head>
<body>
<div class="container">
  <div class="header">
    <h1>SQL Gateway</h1>
    <p>Spring Boot • Tomcat • MySQL</p>
  </div>

  <div class="main-content">
    <!-- Status -->
    <c:if test="${not empty errorMessage}">
      <div class="connection-status connection-error">${errorMessage}</div>
    </c:if>

    <c:if test="${empty errorMessage}">
      <div class="connection-status connection-success">Ready.</div>
    </c:if>

    <!-- SQL form -->
    <div class="sql-form">
      <label for="sqlStatement"><b>SQL statement</b></label>

      <c:if test="${empty sqlStatement}">
        <c:set var="sqlStatement" value="SELECT 1;" />
      </c:if>

      <form action="${pageContext.request.contextPath}/sqlGateway" method="post">
        <textarea id="sqlStatement" name="sqlStatement" cols="60" rows="8">${sqlStatement}</textarea>
        <br/>
        <button class="btn-execute" type="submit">Execute</button>
      </form>
    </div>

    <!-- Result -->
    <div class="result-section" style="margin-top:16px">
      <div class="result-title"><b>SQL result</b></div>
      <div class="result-content">
        <c:out value="${sqlResult}" escapeXml="false"/>
      </div>
    </div>
  </div>
</div>
</body>
</html>
