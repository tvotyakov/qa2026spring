public class Month {
    private final String name;
    private final int daysCount;
    private final int workdaysCount;

    public Month(String name, int daysCount, int workdaysCount) {
        this.name = name;
        this.daysCount = daysCount;
        this.workdaysCount = workdaysCount;
    }

    public String getName() {
        return name;
    }

    public int getDaysCount() {
        return daysCount;
    }

    public int getWorkdaysCount() {
        return workdaysCount;
    }
}
