package model;

public class Dailycare {
	private String caredate;
	private String id;
	private double weight;
	private int bcs;
	public String getCaredate() {
		return caredate;
	}
	public void setCaredate(String caredate) {
		this.caredate = caredate;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public double getWeight() {
		return weight;
	}
	public void setWeight(double weight) {
		this.weight = weight;
	}
	public int getBcs() {
		return bcs;
	}
	public void setBcs(int bcs) {
		this.bcs = bcs;
	}
	@Override
	public String toString() {
		return "dailycare [caredate=" + caredate + ", id=" + id + ", weight=" + weight + ", bcs=" + bcs + "]";
	}
	
}
