package trace.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import com.jfinal.kit.StrKit;

public class WeiXinUtils {
	
	public static String filterWeixinEmoji(String source){
		if (containsEmoji(source)) {
			source = filterEmoji(source);
		}
		return source;
	}

	/**
	 * 检测是否有emoji字符
	 * 
	 * @param source
	 * @return 一旦含有就抛出
	 */
	public static boolean containsEmoji(String source) {
		if (StrKit.isBlank(source)) {
			return false;
		}
		int len = source.length();

		for (int i = 0; i < len; i++) {
			char codePoint = source.charAt(i);

			if (isEmojiCharacter(codePoint)) {
				// do nothing，判断到了这里表明，确认有表情字符
				return true;
			}
		}

		return false;
	}

	private static boolean isEmojiCharacter(char codePoint) {
		return (codePoint == 0x0) || (codePoint == 0x9) || (codePoint == 0xA) || (codePoint == 0xD)
				|| ((codePoint >= 0x20) && (codePoint <= 0xD7FF)) || ((codePoint >= 0xE000) && (codePoint <= 0xFFFD))
				|| ((codePoint >= 0x10000) && (codePoint <= 0x10FFFF));
	}

	/**
	 * 过滤emoji 或者 其他非文字类型的字符
	 * 
	 * @param source
	 * @return
	 */
	public static String filterEmoji(String source) {

		if (!containsEmoji(source)) {
			return source;// 如果不包含，直接返回
		}
		// 到这里铁定包含
		StringBuilder buf = null;

		int len = source.length();

		for (int i = 0; i < len; i++) {
			char codePoint = source.charAt(i);

			if (isEmojiCharacter(codePoint)) {
				if (buf == null) {
					buf = new StringBuilder(source.length());
				}

				buf.append(codePoint);
			} else {
			}
		}

		if (buf == null) {
			return source;// 如果没有找到 emoji表情，则返回源字符串
		} else {
			if (buf.length() == len) {// 这里的意义在于尽可能少的toString，因为会重新生成字符串
				buf = null;
				return source;
			} else {
				return buf.toString();
			}
		}
	}
	
	/** 
     * emoji表情转换(hex -> utf-16) 
     *  
     * @param hexEmoji 
     * @return 
     */  
    public static String emoji(int hexEmoji) {  
        return String.valueOf(Character.toChars(hexEmoji));  
    }
    
    /**  
     * 获取媒体文件  
     * @param accessToken 接口访问凭证  
     * @param media_id 媒体文件ID  
     * @param savePath 文件在服务器上的存储路径  
     * @param fileExt 文件类型  
     * */  
    public static String downloadMedia(String accessToken, String mediaId, String savePath,String fileExt) {  
      String filePath = null;  
      // 拼接请求地址  
      String requestUrl = "http://api.weixin.qq.com/cgi-bin/media/get?access_token="+accessToken+"&media_id="+mediaId;  
      requestUrl = requestUrl.replace("ACCESS_TOKEN", accessToken).replace("MEDIA_ID", mediaId);  
      try {  
        URL url = new URL(requestUrl);  
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();  
        conn.setDoInput(true);  
        conn.setRequestMethod("GET");  

        if (!savePath.endsWith("/")) {  
          savePath += "/";  
        }  
        // 将mediaId作为文件名  
        filePath = savePath + mediaId + "."+fileExt;  
        File file = new File(savePath);
        if(!file.exists()){
        	file.mkdirs();
        }
        BufferedInputStream bis = new BufferedInputStream(conn.getInputStream());  
        FileOutputStream fos = new FileOutputStream(new File(filePath));  
        byte[] buf = new byte[8096000];  
        int size = 0;  
        while ((size = bis.read(buf)) != -1)  
          fos.write(buf, 0, size);  
        fos.close();  
        bis.close();  
        conn.disconnect();  
        String info = String.format("下载媒体文件成功，filePath=" + filePath);  
        System.out.println(info);  
      } catch (Exception e) {  
        filePath = null;  
        String error = String.format("下载媒体文件失败：%s", e);  
        System.out.println(error);  
      }  
      return filePath;  
    }  
}