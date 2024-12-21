package ecom.app.entities;

public class SubAdmin {

   private int subAdminId;

	public SubAdmin(int subAdminId) {
		super();
		this.subAdminId = subAdminId;
	}

	public int getSubAdminId() {
		return subAdminId;
	}

	public void setSubAdminId(int subAdminId) {
		this.subAdminId = subAdminId;
	}

	@Override
	public String toString() {
		return "SubAdmin [subAdminId=" + subAdminId + "]";
	}
    


}
