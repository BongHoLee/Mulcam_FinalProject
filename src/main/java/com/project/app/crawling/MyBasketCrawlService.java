package com.project.app.crawling;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.app.dao.ShareDao;

enum TargetValueType {
	 ATTRIBUTE, TEXT
}

@Service
public class MyBasketCrawlService {

	@Autowired
	private ShareDao dao;
	
	public Object getList(Object paramMap) {
		List<Object> resultObject = new ArrayList<Object>();
		Document doc;
		try {
			doc = Jsoup.connect("http://itempage3.auction.co.kr/DetailView.aspx?itemno=B433596023").get();
			Elements questions = doc.select("h1");
			for(Element link: questions) {
				if(link.attr("class").contains("itemtit"))
					resultObject.add(link.attr("abs:href"));
			}
		}catch (Exception e) {
			// TODO: handle exception
		}
		return resultObject;
	}
	
	public Object saveObject(Object paramMap) {
		String sqlMapId = "myBasket.merge";
		Integer resultKey = (Integer) dao.saveObject(sqlMapId, paramMap);
		
		// 솬봐야함.
		Object resultObject = dao.getObject(sqlMapId, paramMap);
		
		return resultObject;
	}
	
	public Object getProductInfoMap(Object dataMap) {
		Object resultObject = new HashMap<String, Object>();
		Map<String, Object> keywordsMap = new HashMap<>();
		
		// dataMap에서 uri를 꺼내어 대입해줭야 함.
		
		String uri= (String)((Map)dataMap).get("URI");
		
//		uri="http://www.11st.co.kr/product/SellerProductDetail.tmall?method=getSellerProductDetail&prdNo=2073028743&trTypeCd=PW02&trCtgrNo=585021&lCtgrNo=1001439&mCtgrNo=1002944";
//		uri="http://itempage3.auction.co.kr/detailview.aspx?ItemNo=B540743580&listqs=class%3dCorner.CategoryBest%26listorder%3d13&listtitle=%ba%a3%bd%ba%c6%ae100&frm2=through";
//		uri="http://item.gmarket.co.kr/Item?goodscode=793296786&pos_shop_cd=SH&pos_class_cd=111111111&pos_class_kind=T&keyword_order=%be%d6%c7%c3%c6%d2%bd%bd&keyword_seqno=15119573140&search_keyword=%ec%95%a0%ed%94%8c%ed%8c%ac%ec%8a%ac";
		
		// paramMap에서 uri 추출 필요
		
		//1. url 꺼내보고 어디 쇼핑몰인지 판단
		//2. 해당 쇼핑몰에 맞는 keyword(tag, attr 등) 선택 및 전달
		keywordsMap = (Map<String, Object>) getKeywordsMap(uri);
		
		//crawling
		resultObject = getObjectByCrawling(keywordsMap);
		
		return  resultObject;
	}
	
	//key값으로 URI와 KEYWORDS를 갖는 resultMap 생성
	public Object getKeywordsMap(String uri) {
		Map<String, Object> keywordsMap = new HashMap<>();
		List<List<Object>> targetList =  new ArrayList<List<Object>>();
		List<Object> keywordList = new ArrayList<Object>();
		
		// 사이트 판별(11번가 or gmarket or auction)
		final String regex_11st = ".*11st.*";
		final String regex_gmarket = ".*gmarket.*";
		final String regex_auction = ".*auction.*";
		if ( uri.matches(regex_11st)) {				//11st
			//get keywordsMap depending on uri(SITE)
			keywordsMap = (Map<String, Object>) get11stKeywordsMap(uri);
		}else if ( uri.matches(regex_gmarket)) {    //Gmarket
			keywordsMap = (Map<String, Object>) getGmarketKeywordsMap(uri);
		}else if ( uri.matches(regex_auction)) {    //Auction
			keywordsMap = (Map<String, Object>) getAuctionKeywordsMap(uri);
		}

		return keywordsMap;
	}
	
	public Object getObjectByCrawling(Map<String,Object> keywordsMap) {
		
		String uri = (String) keywordsMap.get("URI");
		String siteName = (String) keywordsMap.get("SITE_NAME");
		List<List<Object>> targetList =  (List<List<Object>>) keywordsMap.get("TARGET_LIST");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		//크롤링할 URI
		resultMap.put("URI",uri);
		resultMap.put("SITE_NAME",siteName);
		
		Document doc;
		try {
			doc = Jsoup.connect(uri).get();
			for ( List<Object> keywordList : targetList ) {
				
				String			valueName 		= (String)			keywordList.get(0);
				String 			tagName 		= (String) 			keywordList.get(1);
				String 			attrName 		= (String)			keywordList.get(2);
				String 			attrValue 		= (String) 			keywordList.get(3);
				TargetValueType targetType 		= (TargetValueType) keywordList.get(4);
				String 			targetAttrValue = (String) 			keywordList.get(5); // targetType이 attribute일때만 사용
				
				Elements questions = doc.select(tagName);
				
				for(Element link: questions) {
					if(link.attr(attrName).contains(attrValue)) {
						//해당 태그의 특정 태그 값을 사용할 경우
						if( TargetValueType.ATTRIBUTE.equals(targetType) ) {
							resultMap.put(valueName, link.attr(targetAttrValue));
						}else { // 해당 태그 안의 text값을 직접 사용할 경우
							resultMap.put(valueName, link.text());
							
							//11번가 가격에 '원' 글자 붙여줌
							if ( valueName.equals("PRODUCT_PRICE") && siteName.equals("11번가") ) 
								resultMap.put(valueName, link.text()+'원');
						}
					}
				}
			}
		}catch (Exception e) {
			e.getStackTrace();
			e.getMessage();
			// TODO: handle exception
		}
		return resultMap;
	}
	
	public Object get11stKeywordsMap(String uri) {
		Map<String, Object> keywordsMap = new HashMap<>();
		List<List<Object>> targetList =  new ArrayList<List<Object>>();
		List<Object> keywordList = new ArrayList<Object>();
		
		// THE KEYS OF keywordsMap 
		// 				=> URI, SITE_NAME, TARGET_LIST
		keywordsMap.put("URI", uri);
		keywordsMap.put("SITE_NAME", "11번가");
		keywordsMap.put("TARGET_LIST", targetList);
		
		// DETAILS of targetList
		
		//[0] VALUE_NAME : what you want to find
		//[1] tagName
		//[2] attrName
		//[3] attrValue
		//[4] targetKeyword
		//[5] targetAttributeName
		
		//1. 상품이미지
		targetList.add( Arrays.asList("PRODUCT_IMG","img","alt","상품이미지",TargetValueType.ATTRIBUTE,"src"));
		//2. 상품명
		targetList.add( Arrays.asList("PRODUCT_NAME","title","","",TargetValueType.TEXT,""));
		//3. 상품가격
		targetList.add( Arrays.asList("PRODUCT_PRICE","strong","class","sale_price", TargetValueType.TEXT,""));

		keywordsMap.put("TARGET_LIST", targetList);

		return keywordsMap;
	}
	
	public Object getGmarketKeywordsMap(String uri) {
		Map<String, Object> keywordsMap = new HashMap<>();
		List<List<Object>> targetList =  new ArrayList<List<Object>>();
		List<Object> keywordList = new ArrayList<Object>();
		
		keywordsMap.put("URI", uri);
		keywordsMap.put("SITE_NAME", "Gmarket");
		
		//[0] valueName
		//[1] tagName
		//[2] attrName
		//[3] attrValue
		//[4] targetKeyword
		//[5] targetAttributeName
		
		//1. 상품이미지
		targetList.add( Arrays.asList("PRODUCT_IMG","meta","id","og_image",TargetValueType.ATTRIBUTE,"content"));
		//2. 상품명
		targetList.add( Arrays.asList("PRODUCT_NAME","h1","class","itemtit",TargetValueType.TEXT,""));
		//3. 상품가격
		targetList.add( Arrays.asList("PRODUCT_PRICE","strong","class","price_real", TargetValueType.TEXT,""));

		keywordsMap.put("TARGET_LIST", targetList);
		
		return keywordsMap;		
	}
	
	
	//same with Gmarket !!!
	public Object getAuctionKeywordsMap(String uri) {
		Map<String, Object> keywordsMap = new HashMap<>();
		List<List<Object>> targetList =  new ArrayList<List<Object>>();
		List<Object> keywordList = new ArrayList<Object>();
		
		keywordsMap.put("URI", uri);
		keywordsMap.put("SITE_NAME", "Auction");
		
		//[0] valueName
		//[1] tagName
		//[2] attrName
		//[3] attrValue
		//[4] targetKeyword
		//[5] targetAttributeName
		
		//1. 상품이미지
		targetList.add( Arrays.asList("PRODUCT_IMG","meta","id","og_image",TargetValueType.ATTRIBUTE,"content"));
		//2. 상품명
		targetList.add( Arrays.asList("PRODUCT_NAME","h1","class","itemtit",TargetValueType.TEXT,""));
		//3. 상품가격
		targetList.add( Arrays.asList("PRODUCT_PRICE","strong","class","price_real", TargetValueType.TEXT,""));
		
		keywordsMap.put("TARGET_LIST", targetList);
		
		return keywordsMap;		
	}
}
