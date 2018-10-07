package com.project.app.util;

import java.util.List;

import org.springframework.stereotype.Component;


public class SearchValue {
	private String lastBuildDate;
	private int total;
	private int start;
	private int display;
	private List<Item> items;
	
	
	
	
	public String getLastBuildDate() {
		return lastBuildDate;
	}




	public void setLastBuildDate(String lastBuildDate) {
		this.lastBuildDate = lastBuildDate;
	}




	public int getTotal() {
		return total;
	}




	public void setTotal(int total) {
		this.total = total;
	}




	public int getStart() {
		return start;
	}




	public void setStart(int start) {
		this.start = start;
	}




	public int getDisplay() {
		return display;
	}




	public void setDisplay(int display) {
		this.display = display;
	}




	public List<Item> getItems() {
		return items;
	}




	public void setItems(List<Item> items) {
		this.items = items;
	}




	@Override
	public String toString() {
		return "SearchAPI {lastBuildDate=" + lastBuildDate + ", total=" + total + ", start=" + start + ", display="
				+ display + ", items=" + items + "}";
	}




	public static class Item{
		private String title;
		private String link;
		private String image;
		private String lprice;
		private String hprice;
		private String mallName;
		private String productId;
		private String productType;
		@Override
		public String toString() {
			return "title=" + title + ", link=" + link + ", image=" + image + ", lprice=" + lprice + ", hprice="
					+ hprice + ", mallName=" + mallName + ", productId=" + productId + ", productType=" + productType
					+ "";
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		public String getLink() {
			return link;
		}
		public void setLink(String link) {
			this.link = link;
		}
		public String getImage() {
			return image;
		}
		public void setImage(String image) {
			this.image = image;
		}
		public String getLprice() {
			return lprice;
		}
		public void setLprice(String lprice) {
			this.lprice = lprice;
		}
		public String getHprice() {
			return hprice;
		}
		public void setHprice(String hprice) {
			this.hprice = hprice;
		}
		public String getMallName() {
			return mallName;
		}
		public void setMallName(String mallName) {
			this.mallName = mallName;
		}
		public String getProductId() {
			return productId;
		}
		public void setProductId(String productId) {
			this.productId = productId;
		}
		public String getProductType() {
			return productType;
		}
		public void setProductType(String productType) {
			this.productType = productType;
		}

		
	}

}
