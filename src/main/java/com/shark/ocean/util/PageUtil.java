package com.shark.ocean.util;

import java.util.ArrayList;
import java.util.List;

public class PageUtil {
	private List list = new ArrayList();
	private List pageList = new ArrayList();
	/**
	 * 每页展示记录数
	 */
	private int pageSize = 10;

	/**
	 * 当前第几页，默认1
	 */
	private int page = 1;

	/**
	 * 总页数 totalPage = size % pageSize ==0 ? size/pageSize : (size/pageSize +
	 * 1);
	 * 
	 */
	private int totalPage;

	/**
	 * 总记录数
	 * 
	 */
	private int size;

	private int prePage;

	private int nextPage;

	private int firstPage;

	private int lastPage;

	public PageUtil() {
	}

	public PageUtil(List list, int pageSize, int page, int size) {
		this.list = list;
		this.pageSize = pageSize;
		this.page = page;
		this.size = size;

		this.totalPage = size % pageSize == 0 ? size / pageSize : (size
				/ pageSize + 1);
		this.lastPage = totalPage;
		if (page <= 1) {
			prePage = 1;
		} else {
			prePage = page - 1;
			if (page > lastPage) {
				prePage = lastPage;
			}
		}

		if (page >= totalPage) {
			nextPage = totalPage;
		} else {
			nextPage = page + 1;
			if (nextPage > totalPage) {
				nextPage = totalPage;
			}
		}

		/**
		 * 计算起始
		 * 
		 */
		if (list != null) {
			int fromIndex = (page - 1) * pageSize + 1;
			int toIndex = page * pageSize;
			if (toIndex > size) {
				toIndex = size;
			}
			this.pageList = this.list.subList(fromIndex, toIndex);

		}

	}

	public List getPageList() {
		return pageList;
	}

	public void setPageList(List pageList) {
		this.pageList = pageList;
	}

	/**
	 * 获取上一页的页码
	 * 
	 * @return
	 */
	public int getPrePage() {
		return prePage;
	}

	public void setPrePage(int prePage) {
		this.prePage = prePage;
	}

	public int getNextPage() {

		return nextPage;
	}

	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}

	public int getFirstPage() {
		return 1;
	}

	public void setFirstPage(int firstPage) {
		this.firstPage = firstPage;
	}

	public int getLastPage() {
		return lastPage;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getTotalPage() {
		return size % pageSize == 0 ? size / pageSize : (size / pageSize + 1);
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	@Override
	public String toString() {
		return "PageUtil [pageSize=" + pageSize + ", page=" + page
				+ ", totalPage=" + totalPage + ", size=" + size + ", prePage="
				+ prePage + ", nextPage=" + nextPage + ", firstPage="
				+ firstPage + ", lastPage=" + lastPage + "]";
	}

}
