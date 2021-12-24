package com.kh.devrun.shop.model.dao;

import com.kh.devrun.shop.model.vo.Attachment;
import com.kh.devrun.shop.model.vo.Review;

public interface ShopDao {

	int insertReview(Review review);

	int insertAttach(Attachment attach);

}
