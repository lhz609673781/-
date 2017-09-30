package trace.util;

public enum EnumcodeStatus {
	UNBIND(10),BOUND(20),INTRANSIT(30),ENDTASK(40) ; 
	private int status;
	private EnumcodeStatus(int status) {
		this.status = status;
	}
	public final static EnumcodeStatus valueOf(int status){
		switch (status) {
		case 10:
			return EnumcodeStatus.UNBIND;
		case 20:
			return EnumcodeStatus.BOUND;
		case 30:
			return EnumcodeStatus.INTRANSIT;
		case 40:
			return EnumcodeStatus.ENDTASK;
		default:
			return null;
		}
	}
	public int getStatus() {
		return status;
	}
}

