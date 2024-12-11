<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>ȸ������</title>
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
            if(frm.idChecked.value!=='yes'){ alert("ID �ߺ��˻縦 �ؾ��մϴ�."); return false;	}
            if (password !== confirmPassword) {
                alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
                return false;  // ��й�ȣ ����ġ �� �� ���� ����
            }
            
            if (userId.length > 15 || userName.length > 15) {
                alert("���̵�� �̸��� 15�� ���Ϸ� �Է��� �ּ���.");
                return false;  // ���� ���� �ʰ� �� �� ���� ����
            }

            return true;  // ��� ������ ����ϸ� �� ����
        }

        function idCheck() {
        	var url="idCheck.do?userId="+document.frm.userId.value;
        	window.open(url, "_blank_", "width=450,height=200");
        }
    </script>
</head>
<body>

    <div class="form-container">
        <h2>ȸ������</h2>
        <form action="register.do" method="POST" onsubmit="return validateForm()" name="frm">
 			 <input type="hidden" id="idChecked" name="idChecked" value="">
            <div class="input-group" id="userIdGroup">
                <label for="userId">���̵�</label>
                <input type="text" id="userId" name="userId" maxlength="15" required>
                <span>15�� ����</span>
                <input type="button" value="�ߺ��˻�" onclick="idCheck()"/>
            </div>

            <div class="input-group" id="userPasswordGroup">	
                <label for="userPassword">��й�ȣ</label>
                <input type="password" id="userPassword" name="userPassword" maxlength="15" required>
                <span>15�� ����</span>
            </div>

            <div class="input-group" id="confirmPasswordGroup">
                <label for="confirmPassword">��й�ȣ Ȯ��</label>
                <input type="password" id="confirmPassword" name="confirmPassword" maxlength="15" required>
                <span>��й�ȣ�� �ٽ� �Է��� �ּ���</span>
            </div>

            <div class="input-group" id="userNameGroup">
                <label for="userName">�̸�</label>
                <input type="text" id="userName" name="userName" maxlength="15" required>
                <span>15�� ����</span>
            </div>

            <button type="submit" class="submit-btn">ȸ������</button>
        </form>

        <div class="already-member">
            <p>�̹� ȸ���̽Ű���? <a href="index.jsp">�α���</a></p>
        </div>
    </div>
</body>
</html>
