package model;

public class Carememo {
	private int memono;
	private String id;
	private String memo;
	
	public int getMemono() {
		return memono;
	}
	public void setMemono(int memono) {
		this.memono = memono;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	@Override
	public String toString() {
		return "Carememo [memono=" + memono + ", id=" + id + ", memo=" + memo + "]";
	}
	
	
}
