package dao;

import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import login.LoginDTO;
import user.RegisterDTO;

public class UserCrud {
	private final String MAPPER_NAME="userMapper";//매퍼의 이름을 선언한다.
	
	public String getIdByLogin(LoginDTO dto) {
		SqlSession ss = this.getSession(); String result = null;
		try {
			result = ss.selectOne(MAPPER_NAME+".getUserIdByLogin", dto);
		}finally {
			ss.close();
		}
		return result;
	}
	
	public boolean checkUserId(String userId) {
        SqlSession session = this.getSession(); int count; boolean result = true;
        try {
            // UserMapper를 사용하여 아이디 중복 확인
           count = session.selectOne(MAPPER_NAME + ".checkUserId", userId);
           if(count<1) result = false;
        } finally {
            session.close();
        }
        return result;
        
    }
	public boolean registerUser(RegisterDTO user) {
        SqlSession session = this.getSession(); boolean result = false;
        try {
            // UserMapper를 사용하여 회원가입
            session.insert(MAPPER_NAME + ".registerUser", user);
            session.commit(); // 커밋
            result = true;
        } finally {
            session.close();
        }
        return result;
    }
	
	private SqlSession getSession() {
		String config ="mybatisConfig.xml";//SqlSession을 생성하기 위해 데이터베이스 정보가 필요하고,
						  //데이터베이스 정보를 XML파일에 작성한다. 따라서, SqlSession을 생성할 때
						  //XML파일에서 데이터베이스 정보를 불러온다.
		InputStream is = null;//파일을 불러올 때 필요한 객체(InputStream)선언
		try {
			is = Resources.getResourceAsStream(config);//XML파일을 연다.
		}catch(Exception e) {}
		SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
		SqlSessionFactory factory = builder.build(is);
		SqlSession ss = factory.openSession();//SqlSession 인스턴스 생성!!!
		return ss;
	}
}
