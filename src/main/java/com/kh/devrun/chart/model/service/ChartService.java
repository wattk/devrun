package com.kh.devrun.chart.model.service;

import java.util.Map;

import org.json.simple.JSONObject;

public interface ChartService {

	Map<String, JSONObject> findMainChart();

	Map<String, Integer> findMainCnt();

}
