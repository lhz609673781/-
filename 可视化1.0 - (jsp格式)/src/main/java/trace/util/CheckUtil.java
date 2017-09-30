package trace.util;

public class CheckUtil {
	private static final String token = "weixin";
    public static boolean checkSignature(String signature,String timestamp,String nonce,String encrypt){

       /* String[] arr = new String[] { token, timestamp, nonce };
        // 排序
        Arrays.sort(arr);
        // 生成字符串
        StringBuilder content = new StringBuilder();
        for (int i = 0; i < arr.length; i++) {
            content.append(arr[i]);
        }
        // sha1加密
        String temp=null;
		try {
			temp = SHA1.getSHA1(token, timestamp, nonce, encrypt);
		} catch (AesException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/

        return false/*temp.equals(signature)*/; // 与微信传递过来的签名进行比较
    }
}
