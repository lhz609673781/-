import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.w3c.dom.ls.LSInput;

import com.ycgwl.kylin.web.report.utils.DateUtils;

import ycapp.dbinterface.bean.OperationClaimReportForOut;

public class Test {
	public static void main(String args[]){
//		List<Double> list = new ArrayList<Double>();
//		list.add(0.0);
//		list.add(1.0);
//		list.add(5.0);
//		list.add(2.3);
//		list.add(1.5);
//		list.add(1.5);
//		list.add(0.5);
//		list.add(0.5);
//		int f = list.size();
//		for (int i = 0; i < f; i++) {
//			for (int j = 0; j < f - i - 1; j++) {// 内部循环的边界要比长度小一
//				if (list.get(j)<list.get(j+1)) {
//					Double double1 = list.get(j+1);
//					list.set(j+1, list.get(j));
//					list.set(j, double1);
//				}
//			}
//		}
//		for (int i = 0; i < f; i++) {
//			System.out.println(list.get(i));
//		}
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
//		Integer beginYear = 2017;
//		Integer beginMonth = -1;
////		Integer day = 26;
//		Calendar rightNow = Calendar.getInstance();
//		rightNow.clear();
//		rightNow.set(Calendar.YEAR, beginYear);
//		rightNow.set(Calendar.MONTH, beginMonth-1);
////		rightNow.set(Calendar.DATE, day);
////		rightNow.add(Calendar.DATE, -0);
//		System.out.println(sdf.format(rightNow.getTime()));
		OperationClaimReportForOut forOut = new OperationClaimReportForOut();
		System.out.println(forOut.getAbnormalSum());
	}
}
