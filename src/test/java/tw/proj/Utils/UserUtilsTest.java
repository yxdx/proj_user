package tw.proj.Utils;

import org.junit.Test;


public class UserUtilsTest {

	@Test
	public void checkName() {
		String name = " =aaaaa_";
		System.out.println(UserUtils.checkName(name));

	}

	@Test
	public void checkPassword() {
		String password = "aaaadda";
		System.out.println(UserUtils.checkPassword(password));
	}

	@Test
	public void checkEmail() {
		String email = "te-st@abc.qq.136";
		System.out.println(UserUtils.checkEmail(email));
	}

	@Test
	public void checkAll() {
		String name = "aaaaa_";
		String password = "aaadddddda";
		String email = "te-st@abc.qq.136";
		System.out.println(UserUtils.checkAll(name, password, email));
	}


	@Test
	public void generateVerificationCode() {
		System.out.println(UserUtils.generateVerificationCode());
	}

	@Test
	public void getCipherText() {
		System.out.println(UserUtils.getCipherText("proj@proj.tw", "pass666i"));
	}

	@Test
	public void getEmail() {
		System.out.println(UserUtils.getEmail("vxupFvxup4z} vgyy<<<o"));
	}

	@Test
	public void getPasswords() {
		System.out.println(UserUtils.getPasswords("vxupFvxup4z} vgyy<<<o"));
	}

}