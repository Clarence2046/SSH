package com.shark.ocean.util;

import java.text.SimpleDateFormat;

public class DateHelper {
	public  static SimpleDateFormat FMT_FULL = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public  static SimpleDateFormat FMT_YMD = new SimpleDateFormat("yyyy-MM-dd");
	public  static SimpleDateFormat FMT_HMS = new SimpleDateFormat("HH:mm:ss");
	public  static SimpleDateFormat FMT_HMS_C = new SimpleDateFormat("HHmmss");
	
	public  static SimpleDateFormat FMT_YMD_X = new SimpleDateFormat("yyyy/MM/dd");
	public  static SimpleDateFormat FMT_YMD_C = new SimpleDateFormat("yyyy��MM��dd��");
	
	
	public static String fmtMilliseconds(long millis){
		String fmtResult = "";
		if(millis/1000<60){
			fmtResult = millis/1000+"��";
		}else if(millis/1000/60<60){
			fmtResult = millis/1000/60+"��"+millis/1000%60+"��";
		}else if(millis/1000/60/60<24){
			fmtResult = millis/1000/60/60+"ʱ"+Math.floor(millis/1000/60%60*60)+"��"+Math.floor(millis/1000%60*60)+"��";
		}
		
		return fmtResult;
	}
}
