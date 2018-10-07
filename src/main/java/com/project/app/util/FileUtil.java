package com.project.app.util;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component
public class FileUtil {

	@Autowired
	CommonUtil commonUtil;

	public String getNewFileName(String orgFileName) {

		// 월이 -1 되는 부분 처리 해야 함.
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddhhmmss");

		long time = System.currentTimeMillis();
		String timeStamp = dayTime.format(new Date(time));

		String transfedFileName = timeStamp + "_" + orgFileName;
		return transfedFileName;
	}

	public List<Object> setMultipartList(MultipartHttpServletRequest multipartRequest) {
		List<Object> fileList = new ArrayList<Object>();
		Iterator<String> multiFileList = multipartRequest.getFileNames();

			Map<Object, Object> fileMap = new HashMap<>();
			String fileName = multiFileList.next();

			MultipartFile multiFile = multipartRequest.getFile(fileName);

			String origFileName = multiFile.getOriginalFilename();

			if (origFileName != null && origFileName != "") {

				String multiFileName = getNewFileName(origFileName);
				String addRealPath = "//resources//uploads//";
				String physicalDirectory = multipartRequest.getSession().getServletContext().getRealPath(addRealPath)
						+ multiFileName;
				String attachFileName = physicalDirectory;
				
				String fileSize = multiFile.getSize() + "";
				String fileContextType = multiFile.getContentType();
				//System.out.println("###########"+physicalDirectory); // 실제 저장되는 경로 확인용 

				try {
					// 파일 전송
					multiFile.transferTo(new File(attachFileName));
					fileMap.put("IMG", multiFileName);
					fileList.add(fileMap);
				} catch (Exception e) {
					File file = new File(attachFileName);
					file.delete();
					e.printStackTrace();
				}
			}
		

		return fileList;

	}
}