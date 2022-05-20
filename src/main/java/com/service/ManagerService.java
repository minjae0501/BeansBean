package com.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.dao.ManagerDAO;
import com.dto.GoodsDTO;

@Service
public class ManagerService {
	@Autowired
	ManagerDAO dao;

	public void goodsADD(GoodsDTO gDTO) {
		// TODO Auto-generated method stub
		dao.goodsADD(gDTO);
	}

	public GoodsDTO goodsinfo(String gcode) {
		// TODO Auto-generated method stub
		return dao.goodsinfo(gcode);
	}


	public List<GoodsDTO> AllGoods() {
		// TODO Auto-generated method stub
		return dao.AllGoods();
	}

	public void goodsDelete(String gcode) {
		// TODO Auto-generated method stub
		dao.goodsDelete(gcode);
	}

	public void variationDelete(String gcode) {
		// TODO Auto-generated method stub
		dao.variationDelete(gcode);
	}

	public void bundleDelete(String gcode) {
		dao.bundleDelete(gcode);
		
	}

	public void goodsUpdate(GoodsDTO gDTO) {
		// TODO Auto-generated method stub
		dao.goodsUpdate(gDTO);
	}

}
