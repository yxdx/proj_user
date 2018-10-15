package tw.proj.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import tw.proj.dao.UserDao;
import tw.proj.entity.User;
import tw.proj.mail.ProjMail;
import tw.proj.service.UserService;

import javax.annotation.Resource;

/**
 * @author ljc
 * @date 2018/10/11
 */
@Service("userService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class UserServiceImpl implements UserService {
	@Resource(name = "userDao")
	private UserDao userDao;

	@Resource(name = "projMail")
	private ProjMail projMail;

	@Override
	public void addUser(User user) {
		userDao.addUser(user);
	}

	@Override
	public void deleteUser(User user) {
		userDao.deleteUser(user);
	}

	@Override
	public User findUser(User user) {
		return userDao.findUser(user);
	}

	@Override
	public void updateUser(User oldUser, User newUser) {
		User userBack = userDao.findUser(oldUser);
		userBack.setName(newUser.getName());
		userBack.setPassword(newUser.getPassword());
		userBack.setEmail(newUser.getEmail());

		userDao.updateUser(userBack);
	}

	@Override
	public boolean findEmail(String email) {
		return userDao.findEmail(email);
	}

	@Override
	public void sendMail(String recipient, String subject, String context) {
		projMail.sendMail(recipient, subject, context);
	}
}
