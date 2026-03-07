public class MonthUtils {
    public static final Month JANUARY = new Month("Январь", 31, 20);
    public static final Month FEBRUARY = new Month("Февраль", 28, 20);
    public static final Month MARCH = new Month("Март", 31, 22);
    public static final Month APRIL = new Month("Апрель", 30, 21);
    public static final Month MAY = new Month("Май", 31, 20);
    public static final Month JUNE = new Month("Июнь", 30, 21);
    public static final Month JULY = new Month("Июль", 31, 23);
    public static final Month AUGUST = new Month("Август", 31, 21);
    public static final Month SEPTEMBER = new Month("Сентябрь", 30, 22);
    public static final Month OCTOBER = new Month("Октябрь", 31, 22);
    public static final Month NOVEMBER = new Month("Ноябрь", 30, 20);
    public static final Month DECEMBER = new Month("Декабрь", 31, 21);

    public static final Month[] MONTHS = {
            JANUARY, FEBRUARY, MARCH, APRIL, MAY, JUNE,
            JULY, AUGUST, SEPTEMBER, OCTOBER, NOVEMBER, DECEMBER,
    };

    public static final Month[][] QUARTERS = {
            { JANUARY, FEBRUARY, MARCH, },
            { APRIL, MAY, JUNE, },
            { JULY, AUGUST, SEPTEMBER, },
            { OCTOBER, NOVEMBER, DECEMBER },
    };

    public static final Month[][] HALF_YEARS = {
            { JANUARY, FEBRUARY, MARCH, APRIL, MAY, JUNE, },
            { JULY, AUGUST, SEPTEMBER, OCTOBER, NOVEMBER, DECEMBER },
    };
}
