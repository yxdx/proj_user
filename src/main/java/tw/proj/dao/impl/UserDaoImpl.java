package tw.proj.dao.impl;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import tw.proj.dao.UserDao;
import tw.proj.entity.User;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author ljc
 * @date 2018/10/10
 */
@Repository("userDao")
public class UserDaoImpl implements UserDao {
	@Resource(name = "sessionFactory")
	private SessionFactory sessionFactory;

	/**
	 * 增
	 *
	 * @date 2018/10/11
	 * @Param [user]
	 * @return void
	 */
	@Override
	public void addUser(User user) {
		sessionFactory.getCurrentSession().save(user);
	}

	/**
	 * 删
	 *
	 * @date 2018/10/11
	 * @Param [user]
	 * @return void
	 */
	@Override
	public void deleteUser(User user) {
		User userBack = findUser(user);
		if (userBack != null) {
		sessionFactory.getCurrentSession().delete(userBack);
		}
	}

	/**
	 * 查
	 *
	 * @date 2018/10/11
	 * @Param [user]
	 * @return tw.proj.entity.User
	 */
	@Override
	public User findUser(User user) {
		Session session = sessionFactory.getCurrentSession();
		String email = user.getEmail();
		String password = user.getPassword();
		Query query = session.createQuery("from User where email=:email and password=:password");
		query.setParameter("email", email).setParameter("password", password);
		List list = query.list();
		if (list.size() > 0) {
			return (User) list.get(0);
		} else {
			return null;
		}
	}

	/**
	 * 改
	 *
	 * @date 2018/10/11
	 * @Param [user]
	 * @return void
	 */
	@Override
	public void updateUser(User user) {
		sessionFactory.getCurrentSession().update(user);
	}

	@Override
	public boolean findEmail(String email) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from User where email=:email");
		query.setParameter("email", email);
		List list = query.list();
		return list.size() > 0;
	}
}
