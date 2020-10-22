package testCode;

import java.util.Arrays;


public class testCode {
	public static void main(String args[]) {
		
//		int[] input = new int[] {256741038, 623958417, 467905213, 714532089, 938071625};
//		miniMaxSum(input);
		
//		String output = timeConversion("07:05:45PM");
//		System.out.println(output);
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
