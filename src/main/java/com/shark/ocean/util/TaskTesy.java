package com.shark.ocean.util;

import org.springframework.scheduling.annotation.Scheduled;

public class TaskTesy {
	
	
	public void job1(){
		System.out.println("Task executed........");
	}
	
	@Scheduled(cron="30 * * * * ?")
	public void annoJob() {
		System.out.println("Task executed through annotation");
	}
}
