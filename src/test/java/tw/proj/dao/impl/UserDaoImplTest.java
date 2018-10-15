package tw.proj.dao.impl;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import tw.proj.entity.User;
import tw.proj.service.UserService;

import javax.annotation.Resource;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class UserDaoImplTest {
	@Resource(name = "userService")
	private UserService userService;

	@Test
	public void addUser() {
		User user = new User();
		user.setEmail("zhaoliu@qq.com");
		user.setName("赵六");
		user.setPassword("pass.666");

		userService.addUser(user);
	}

	@Test
	public void findUser() {
		User user = new User();
		User userBack = userService.findUser(user);
		System.out.println(userBack);
	}

	@Test
	public void updateUser() {
		User oldUser = new User();
		oldUser.setId(1);
		oldUser.setName("李四");
		oldUser.setPassword("lahglwa");
		oldUser.setEmail("ww@proj.tw");

		User newUser = new User();
		newUser.setName("王五");
		newUser.setPassword("666666");
		newUser.setEmail("66666666");

		userService.updateUser(oldUser, newUser);
	}

	@Test
	public void methodTest() {
		User user = new User();
		System.out.println(user);
	}

	@Test
	public void deleteUser() {
		User user = new User();
		userService.deleteUser(user);

	}
}