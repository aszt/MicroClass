package microclass.util;

import java.util.UUID;

/**
 * @ClassName: Uuid
 * @Description: 生成uuid
 * @author c-kx@outlook.com
 * @date 2015年12月20日 下午8:13:38
 */

/*
 * replace() 方法用于在字符串中用一些字符替换另一些字符，或替换一个与正则表达式匹配的子串。
 * toUpperCase()描述说明:该方法返回指定的char值的大写形式
 */
public class Uuid {
	public static String uuid() {
		return UUID.randomUUID().toString().replace("-", "").toUpperCase();
	}
}
