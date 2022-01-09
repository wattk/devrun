package com.kh.devrun.chart.model.service;

import java.util.Map;

import org.json.simple.JSONObject;

public interface ChartService {

	Map<String, Object> findMainChart();

	Map<String, Integer> findMainCnt();

	Map<String, Object> findHomeMain();

	Map<String, Object> findUnifiedSearch(String searchKeyword);

}
