package school.redrover.tvotyakov.tests.ui;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.Assert;
import org.testng.annotations.Test;

import java.time.Duration;
import java.util.Arrays;

public class SwagLabsLoginTest {
    private static final String BASE_URL = "https://www.saucedemo.com";

    private WebDriver driver;

    @BeforeMethod
    public void beforeMethod() {
        // Arrange
        driver = new ChromeDriver();
        driver
            .manage()
            .timeouts()
            .implicitlyWait(Duration.ofMillis(500));

        driver.get(BASE_URL);
        String title = driver.getTitle();

        // Ensure we are on the right page
        Assert.assertEquals(title, "Swag Labs");
    }

    @Test
    public void TestStandardLogin_ShouldOpenProductPage() {
        // Act
        login("standard_user");

        // Asserts
        var url = driver.getCurrentUrl();
        Assert.assertEquals(url, BASE_URL + "/inventory.html");

        var header = driver
            .findElement(By
                .cssSelector("[data-test='primary-header'] .app_logo"))
            .getText();
        Assert.assertEquals(header, "Swag Labs");

        var secondHeader = driver
            .findElement(By
                .cssSelector("[data-test='secondary-header'] [data-test='title']"))
            .getText();

        Assert.assertEquals(secondHeader, "Products");
    }

    @Test
    public void TestUnknownLogin_ShouldShowError() {
        // Act
        login("unknown_user");

        // Asserts
        Assert.assertTrue(
            hasErrorClass(getUsername()),
            "UserName should be marked by error class");

        Assert.assertTrue(
            hasErrorClass(getPassword()),
            "Password should be marked by error class");

        var errorMessageEl = driver.findElement(By.cssSelector("[data-test='error']"));
        Assert.assertTrue(
            errorMessageEl.isDisplayed(),
            "Error message should be displayed");

        var errorMessage = errorMessageEl.getText();
        Assert.assertTrue(
            errorMessage.contains("do not match any user"),
            "Not expected error message. Actual text: " + errorMessage);
    }

    @Test
    public void TestLockedOutLogin_ShouldShowError() {
        login("locked_out_user");

        // Asserts
        Assert.assertTrue(
            hasErrorClass(getUsername()),
            "UserName should be marked by error class");

        Assert.assertTrue(
            hasErrorClass(getPassword()),
            "UserName should be marked by error class");

        var errorMessageEl = driver.findElement(By.cssSelector("[data-test='error']"));
        Assert.assertTrue(
            errorMessageEl.isDisplayed(),
            "Error message should be displayed");

        var errorMessage = errorMessageEl.getText();
        Assert.assertTrue(
            errorMessage.contains("user has been locked out"),
            "Not expected error message. Actual text: " + errorMessage);
    }

    @AfterMethod
    public void afterMethod() {
        driver.quit();
    }

    private void login(String username) {
        getUsername().sendKeys(username);

        getPassword().sendKeys("secret_sauce");

        driver
            .findElement(By.cssSelector("input[data-test='login-button']"))
            .click();
    }

    private boolean hasErrorClass(WebElement element) {
        var classes = element.getAttribute("class");

        if (classes == null || classes.isEmpty()) {
            return false;
        }

        var classesList = Arrays.asList(classes.split(" "));

        return classesList
            .contains("error");
    }

    private WebElement getUsername() {
        return driver
            .findElement(By.cssSelector("input[data-test='username']"));
    }

    private WebElement getPassword() {
        return driver
            .findElement(By.cssSelector("input[data-test='password']"));
    }
}
