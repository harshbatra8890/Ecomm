package ecom.app.entities;

public class SuperAdmin {
	
	private int Id;
	private String firstName;
	private String lastName;
	private String emailId;
	private String mobileNo;
	private String username;
	private String passwordSalt;
	private String passwordHash;
	
	
	
	public SuperAdmin() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public SuperAdmin(int id, String firstName, String lastName, String emailId, String mobileNo, String username,
			String passwordSalt, String passwordHash) {
		super();
		Id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.emailId = emailId;
		this.mobileNo = mobileNo;
		this.username = username;
		this.passwordSalt = passwordSalt;
		this.passwordHash = passwordHash;
	}
	public int getId() {
		return Id;
	}
	public void setId(int id) {
		Id = id;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public String getMobileNo() {
		return mobileNo;
	}
	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPasswordSalt() {
		return passwordSalt;
	}
	public void setPasswordSalt(String passwordSalt) {
		this.passwordSalt = passwordSalt;
	}
	public String getPasswordHash() {
		return passwordHash;
	}
	public void setPasswordHash(String passwordHash) {
		this.passwordHash = passwordHash;
	}
	@Override
	public String toString() {
		return "SuperAdmin [Id=" + Id + ", firstName=" + firstName + ", lastName=" + lastName + ", emailId=" + emailId
				+ ", mobileNo=" + mobileNo + ", username=" + username + ", passwordSalt=" + passwordSalt
				+ ", passwordHash=" + passwordHash + "]";
	}
	
	
	
	
	
	
	
}
