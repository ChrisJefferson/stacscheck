import java.util.Scanner;
class Calculator
{
	public static void main(String args[])
	{ 
		System.out.println("Enter numbers:");
		Scanner in = new Scanner(System.in);
		int sum = 0;
		int val = in.nextInt();
		while(val != 0) {
			sum += val;
			val = in.nextInt();
		}
		System.out.println("" + sum);
	}
}
