package testCode;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.Scanner;


interface One {
	default void method() {
		System.out.println("One");
	}
}

interface Two {
	default void method() {
		System.out.println("One");
	}
}

class Three implements One, Two {
	public void method() {
		One.super.method();
	}
}


public class testCode {
	public static void main(String args[]) {
		
//		int[] input = new int[] {256741038, 623958417, 467905213, 714532089, 938071625};
//		miniMaxSum(input);
		
//		String output = timeConversion("07:05:45PM");
//		System.out.println(output);
		
//		String str = "abcde";
//		str.trim();
//		str.toUpperCase();
//		str.substring(3,4);
//		System.out.println(str);
//		
//		String str2 = "abcde";
//		str2 = str2.trim();
//		str2 = str2.toUpperCase();
//		str2 = str2.substring(3,4);
//		System.out.println(str2);
		
//		int x = 5;
//		x = 10;
//		System.out.println(x);
//		
//		System.out.println("strawberries".substring(2, 5));
//		System.out.println(Boolean.parseBoolean("FalSe"));
//		
//		int a = 1;
//		int b = 0;
//		int c = a/b;
//		System.out.println(c);
//		List<Integer> results = new ArrayList<Integer>();
		
		System.out.println(Math.pow(2, 1));
	}

    static String timeConversion(String s) {
    	
    	String[] timeArr = s.split(":");
    	
//    	for(int i = 0; i < timeArr.length; i++) {
//    		System.out.println(timeArr[i]);
//    	}
    	
    	String amPM = timeArr[2].substring(2, 4); 	
//    	System.out.println(amPM);
    	
    	int hh = Integer.parseInt(timeArr[0]);
    	int mm = Integer.parseInt(timeArr[1]);
    	int ss = Integer.parseInt(timeArr[2].substring(0, 2));
    	
    	if(amPM.equals("AM") && hh == 12) {
    		hh = 0;
    	} else if(amPM.equals("PM") && hh < 12) {
    		hh += 12;
    	}
    	
    	return String.format("%02d:%02d:%02d",hh,mm,ss);
    }
	
	static void miniMaxSum(int[] arr) {

		int[] sortedArray = arr;
		Arrays.sort(sortedArray);
		
//		for(int i = 1; i < arr.length; i++) {
//			System.out.println(sortedArray[i]);
//		}

		long minSum = 0;
		for (int i = 0; i < arr.length - 1; i++) {
			minSum = minSum + sortedArray[i];
		}
		long maxSum = 0;
		for (int i = 1; i < arr.length; i++) {
//			System.out.println(sortedArray[i]);
			maxSum = maxSum + sortedArray[i];
		}

		String output = String.valueOf(minSum);
		output = output.concat(" ");
		output = output.concat(String.valueOf(maxSum));
		System.out.print(output);
	}
}
