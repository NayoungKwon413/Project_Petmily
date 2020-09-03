package model;
import java.util.Date;

public class Board {
	private int boardno;
	private String id;
	private String pass;
	private String title;
	private String content;
	private String file1;
	private Date regdate;
	private int readcnt;
	
	
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
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFile1() {
		return file1;
	}
	public void setFile1(String file1) {
		this.file1 = file1;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
	@Override
	public String toString() {
		return "Board [boardno=" + boardno + ", id=" + id + ", pass=" + pass + ", title=" + title + ", content="
				+ content + ", file1=" + file1 + ", regdate=" + regdate + ", readcnt=" + readcnt + "]";
	}
	
}
