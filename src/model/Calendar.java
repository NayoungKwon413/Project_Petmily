package model;

import java.sql.Time;
import java.util.Date;

public class Calendar {
	private int calno;
	private String id;
	private Date startdate;
	private Date enddate;
	private String starttime;
	private String endtime;
	private String plan;
	public int getCalno() {
		return calno;
	}
	public void setCalno(int calno) {
		this.calno = calno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getStartdate() {
		return startdate;
	}
	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}
	public Date getEnddate() {
		return enddate;
	}
	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}
	public String getStarttime() {
		return starttime;
	}
	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public String getPlan() {
		return plan;
	}
	public void setPlan(String plan) {
		this.plan = plan;
	}
	@Override
	public String toString() {
		return "Calendar [calno=" + calno + ", id=" + id + ", startdate=" + startdate + ", enddate=" + enddate
				+ ", starttime=" + starttime + ", endtime=" + endtime + ", plan=" + plan + "]";
	}
	
}
