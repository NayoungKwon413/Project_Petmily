package model;

import java.util.Date;

public class Reply {
	private int replyno;
	private int boardno;
	private String id;
	private Date repdate;
	private String repcontent;
	public int getReplyno() {
		return replyno;
	}
	public void setReplyno(int replyno) {
		this.replyno = replyno;
	}
	public int getBoardno() {
		return boardno;
	}
	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getRepdate() {
		return repdate;
	}
	public void setRepdate(Date repdate) {
		this.repdate = repdate;
	}
	public String getRepcontent() {
		return repcontent;
	}
	public void setRepcontent(String repcontent) {
		this.repcontent = repcontent;
	}
	@Override
	public String toString() {
		return "Reply [replyno=" + replyno + ", boardno=" + boardno + ", id=" + id + ", repdate=" + repdate
				+ ", repcontent=" + repcontent + "]";
	}
	
}
