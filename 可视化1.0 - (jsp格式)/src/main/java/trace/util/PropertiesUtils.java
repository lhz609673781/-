package trace.util;

import java.io.File;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;
/**
 * Properties文件工具类
 * @author Administrator
 *
 */
public class PropertiesUtils {
	private static Map<String, Properties> loaderMap = new HashMap<String, Properties>();
    private static ConcurrentMap<String, String> configMap = new ConcurrentHashMap<String, String>();  
    private static final String DEFAULT_CONFIG_FILE = "wx.properties";  
  
    private static Properties prop = null; 
    
  /**
   * 根据指定文件获取key值
   * @param key
   * @param propName 加载配置文件名
   * @return
   */
    public static String getStringByKey(String key, String fileName) {  
        try {  
            prop = PropertiesUtils.getPropFromProperties(fileName);  
        } catch (Exception e) {  
            throw new RuntimeException(e);  
        }  
        key = key.trim();  
        if (!configMap.containsKey(key)) {  
            if (prop.getProperty(key) != null) {  
                configMap.put(key, prop.getProperty(key));  
            }  
        }  
        return configMap.get(key);  
    }  
  
    /**
     * 根据默认配置文件获取key值
     * @param key
     * @return
     */
    public static String getValue(String key) {  
        return getStringByKey(key, DEFAULT_CONFIG_FILE);  
    } 
    
  /**
   * 获取Properties文件全部属性
   * @return
   */
    public static Properties getProperties() {  
        try {  
            return PropertiesUtils.getPropFromProperties(DEFAULT_CONFIG_FILE);  
        } catch (Exception e) {  
            e.printStackTrace();  
            return null;  
        }  
    }
    
    public static Properties getPropFromProperties(String fileName) throws Exception {  
        Properties prop = loaderMap.get(fileName);  
        if (prop != null) {  
            return prop;  
        }  
        String filePath = null;  
        String configPath = System.getProperty("configurePath");  
        if (configPath == null) {  
            filePath = PropertiesUtils.class.getClassLoader().getResource(fileName).getPath();  
        } else {  
            filePath = configPath + "/" + fileName;  
        }  
        prop = new Properties();  
        prop.load(new FileInputStream(new File(filePath)));  
        loaderMap.put(fileName, prop);  
        return prop;  
    } 
}  

