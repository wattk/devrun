package com.kh.devrun.common.aop;


import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoggingAspect {
	
	public Object logger(ProceedingJoinPoint joinPoint) throws Throwable {
		//주업무로직의 joinPoint 확인
		Signature signature = joinPoint.getSignature();
		String type = signature.getDeclaringTypeName(); //className
		String methodName = signature.getName(); //methodName
		
		//before
		log.debug("[Around1] {}.{}", type, methodName);
		
		Object obj = joinPoint.proceed();
		
		//after
		log.debug("[Around2] {}.{}", type, methodName);
		
		return obj;
	}
}
