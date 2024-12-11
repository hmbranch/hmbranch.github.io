<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>회원가입</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 50px;
        }

        .form-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            margin: auto;
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            margin-bottom: 10px;
            display: block;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        .input-group {
            margin-bottom: 15px;
        }

        .input-group span {
            font-size: 12px;
            color: #888;
        }

        .input-group.error input {
            border-color: red;
        }

        .input-group.error span {
            color: red;
        }

        .submit-btn {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        .submit-btn:hover {
            background-color: #0056b3;
        }

        .already-member {
            text-align: center;
            margin-top: 20px;
        }

        .already-member a {
            color: #007bff;
            text-decoration: none;
        }
    </style>
    <script>
        function validateForm() {
            const password = document.getElementById("userPassword").value;
            const confirmPassword = document.getElementById("confirmPassword").value;
            const userId = document.getElementById("userId").value;
            const userName = document.getElementById("userName").value;
            if(frm.idChecked.value!=='yes'){ alert("ID 중복검사를 해야합니다."); return false;	}
            if (password !== confirmPassword) {
                alert("비밀번호가 일치하지 않습니다.");
                return false;  // 비밀번호 불일치 시 폼 제출 방지
            }
            
            if (userId.length > 15 || userName.length > 15) {
                alert("아이디와 이름은 15자 이하로 입력해 주세요.");
                return false;  // 길이 제한 초과 시 폼 제출 방지
            }

            return true;  // 모든 검증을 통과하면 폼 제출
        }

        function idCheck() {
        	var url="idCheck.do?userId="+document.frm.userId.value;
        	window.open(url, "_blank_", "width=450,height=200");
        }
    </script>
</head>
<body>

    <div class="form-container">
        <h2>회원가입</h2>
        <form action="register.do" method="POST" onsubmit="return validateForm()" name="frm">
 			 <input type="hidden" id="idChecked" name="idChecked" value="">
            <div class="input-group" id="userIdGroup">
                <label for="userId">아이디</label>
                <input type="text" id="userId" name="userId" maxlength="15" required>
                <span>15자 이하</span>
                <input type="button" value="중복검사" onclick="idCheck()"/>
            </div>

            <div class="input-group" id="userPasswordGroup">	
                <label for="userPassword">비밀번호</label>
                <input type="password" id="userPassword" name="userPassword" maxlength="15" required>
                <span>15자 이하</span>
            </div>

            <div class="input-group" id="confirmPasswordGroup">
                <label for="confirmPassword">비밀번호 확인</label>
                <input type="password" id="confirmPassword" name="confirmPassword" maxlength="15" required>
                <span>비밀번호를 다시 입력해 주세요</span>
            </div>

            <div class="input-group" id="userNameGroup">
                <label for="userName">이름</label>
                <input type="text" id="userName" name="userName" maxlength="15" required>
                <span>15자 이하</span>
            </div>

            <button type="submit" class="submit-btn">회원가입</button>
        </form>

        <div class="already-member">
            <p>이미 회원이신가요? <a href="index.jsp">로그인</a></p>
        </div>
    </div>
</body>
</html>
