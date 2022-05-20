package com.dto;

import org.apache.ibatis.type.Alias;

@Alias("GoodsDTO")
public class GoodsDTO {
	private String gcode;
	private String gcategory;
	private String gname;
	private int gprice;
	private String variation;
	private String bundle;
	private int gamount;
	private String gimage;

	public GoodsDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public GoodsDTO(String gcode, String gcategory, String gname, int gprice, String variation, String bundle,
			int gamount, String gimage) {
		super();
		this.gcode = gcode;
		this.gcategory = gcategory;
		this.gname = gname;
		this.gprice = gprice;
		this.variation = variation;
		this.bundle = bundle;
		this.gamount = gamount;
		this.gimage = gimage;
	}

	@Override
	public String toString() {
		return "GoodsDTO [gcode=" + gcode + ", gcategory=" + gcategory + ", gname=" + gname + ", gprice=" + gprice
				+ ", variation=" + variation + ", bundle=" + bundle + ", gamount=" + gamount + ", gimage=" + gimage
				+ "]";
	}

	public String getGcode() {
		return gcode;
	}

	public void setGcode(String gcode) {
		this.gcode = gcode;
	}

	public String getGcategory() {
		return gcategory;
	}

	public void setGcategory(String gcategory) {
		this.gcategory = gcategory;
	}

	public String getGname() {
		return gname;
	}

	public void setGname(String gname) {
		this.gname = gname;
	}

	public int getGprice() {
		return gprice;
	}

	public void setGprice(int gprice) {
		this.gprice = gprice;
	}

	public String getVariation() {
		return variation;
	}

	public void setVariation(String variation) {
		this.variation = variation;
	}

	public String getBundle() {
		return bundle;
	}

	public void setBundle(String bundle) {
		this.bundle = bundle;
	}

	public int getGamount() {
		return gamount;
	}

	public void setGamount(int gamount) {
		this.gamount = gamount;
	}

	public String getGimage() {
		return gimage;
	}

	public void setGimage(String gimage) {
		this.gimage = gimage;
	}
	
	
	
}
