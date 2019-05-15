package com.go9.mall.service;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import com.go9.common.ServiceMessage;
import com.go9.mall.vo.IndexRoll;

@Service
public class IndexRollServiceImpl implements IndexRollService {
	@Value("${index.roll.url}")
	private String indexUrl;
	
	@Autowired
	private RestTemplate rest;
	
	@Override
	public List<IndexRoll> getAll() {
		//远程调用商品服务提供的轮播图接口，获取轮播图数据？？？
		//其实就是请求http+json的格式的协议接口
		/*ServiceMessage<List<IndexRoll>> serviceMessage = rest.getForObject(indexUrl, ServiceMessage.class);
		List<IndexRoll> data = serviceMessage.getData();*/
		
		HttpHeaders headers = new HttpHeaders();
		headers.add(HttpHeaders.ACCEPT, MediaType.APPLICATION_JSON_UTF8_VALUE);
		headers.add(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_UTF8_VALUE);
		HttpEntity requestEntity = new HttpEntity<>(headers);
		ParameterizedTypeReference<ServiceMessage<List<IndexRoll>>> typeRef = 
				new ParameterizedTypeReference<ServiceMessage<List<IndexRoll>>>() {};
		ResponseEntity<ServiceMessage<List<IndexRoll>>> exchange = rest.exchange(indexUrl, HttpMethod.GET, requestEntity, typeRef);
		ServiceMessage<List<IndexRoll>> body = exchange.getBody();
		if(body.getStatus() == 200) {
			List<IndexRoll> data = body.getData();
			return data;
		}else {
			return new ArrayList<>();
		}
	}

}
