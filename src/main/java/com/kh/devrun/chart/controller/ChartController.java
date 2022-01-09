package com.kh.devrun.chart.controller;

import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.devrun.chart.model.service.ChartService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/chart")
public class ChartController {

	@Autowired
	private ChartService chartService;
	
	@GetMapping("/findMainChart")
	@ResponseBody
	public Map<String, Object> findMainChart(){
		
		Map<String, Object> map = chartService.findMainChart();
		
		return map;
	}
}
