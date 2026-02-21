public class Task3 {
    public static void divideAndPrint() {
        int piratesCount = 26;
        int spoilAmount = 10500;

        int ownerShare = spoilAmount / 2;
        int captainShare = (spoilAmount - ownerShare) / 2;
        int pirateShare = (spoilAmount - ownerShare - captainShare) / piratesCount;

        ownerShare += spoilAmount - (ownerShare + captainShare + pirateShare * piratesCount);
        captainShare += pirateShare;

        System.out.println("Pirates on the boat: " + piratesCount);
        System.out.println("Spoil amount: " + spoilAmount);
        System.out.println("Owner share: " + ownerShare);
        System.out.println("Captain share: " + captainShare);
        System.out.println("Pirate share: " + pirateShare + " per pirate including captain");
    }
}
