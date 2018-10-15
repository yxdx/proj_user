package tw.proj.dao;

import tw.proj.entity.User;

/**
 * @author ljc
 * @date 2018/10/10
 */
public interface UserDao {
	void addUser(User user);

	void deleteUser(User user);

	User findUser(User user);

	void updateUser(User user);

	boolean findEmail(String email);

}
