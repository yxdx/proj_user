package tw.proj.service;

import tw.proj.entity.User;

/**
 * @author ljc
 * @date 2018/10/11
 */
public interface UserService {
	void addUser(User user);

	void deleteUser(User user);

	User findUser(User user);

	void updateUser(User oldUser, User newUser);

	boolean findEmail(String email);

	void sendMail(String recipient, String subject, String context);
}
