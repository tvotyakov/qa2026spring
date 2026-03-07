import org.testng.Assert;
import org.testng.annotations.Test;
import school.redrover.tvotyakov.MathUtils;

import java.util.Random;

public class MathUtilsTest {

    @Test
    public void MathUtilsAddShouldReturnSumOfTwoIntegers() {
        Random rand = new Random();
        int a = rand.nextInt(-2000, 2000);
        int b = rand.nextInt(-2000, 2000);

        int sum = a + b;
        Assert.assertEquals(sum, MathUtils.add(a, b));
    }

    @Test
    public void MathUtilsSubShouldReturnSubstractionOfTwoIntegers() {
        Random rand = new Random();
        int a = rand.nextInt(-2000, 2000);
        int b = rand.nextInt(-2000, 2000);

        int sub = a - b;
        Assert.assertEquals(sub, MathUtils.sub(a, b));
    }

    @Test
    public void MathUtilsMulShouldReturnMultiplicationOfTwoIntegers() {
        Random rand = new Random();
        int a = rand.nextInt(-2000, 2000);
        int b = rand.nextInt(-2000, 2000);

        int multi = a * b;
        Assert.assertEquals(multi, MathUtils.mul(a, b));
    }

    @Test
    public void MathUtilsDivShouldReturnDivisionOfTwoIntegers() {
        Random rand = new Random();
        int a = rand.nextInt(-2000, 2000);
        int b = rand.nextInt(-2000, 2000);

        if (b == 0) {
            b = 1;
        }

        int div = a / b;
        Assert.assertEquals(div, MathUtils.div(a, b));
    }

    @Test(expectedExceptions = ArithmeticException.class)
    public void MathUtilsDivShouldThrowExceptionWhenDivisionByZero() {
        Random rand = new Random();
        int a = rand.nextInt(-2000, 2000);

        int _ = MathUtils.div(a, 0);
    }
}
