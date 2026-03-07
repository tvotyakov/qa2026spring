import org.apache.commons.lang3.StringUtils;
import org.testng.Assert;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

public class AbbreviationTest {

    @DataProvider(name="test-data-1")
    public Object[][] createTestData() {
        return new Object[][] {
                {"Привет всем кто живет на луне!", "Привет ...", 10},
                {"Привет всем кто живет на луне!", "Привет всем кто ж...", 20},
        };
    }

    @Test(dataProvider = "test-data-1")
    public void StringUtilsAbbreviateShouldReturnExpectedAbbreviationString(
            String srcStr,
            String expectedStr,
            int maxLength
    ) {
        var actual = StringUtils.abbreviate(srcStr, maxLength);

        Assert.assertEquals(actual, expectedStr);
    }

    @Test(expectedExceptions = IllegalArgumentException.class)
    public void StringUtilsAbbreviateThrowExceptionIfMaxLengthLessThan4() {
        var _ = StringUtils.abbreviate("Тестовая строка", 3);
    }
}
