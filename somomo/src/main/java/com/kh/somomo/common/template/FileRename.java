package com.kh.somomo.common.template;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

public class FileRename {

	// 파일 원본명, 수정명 반환
	public static HashMap<String, String> saveFile(MultipartFile upfile, HttpSession session, String filePathName) {
		
		HashMap<String, String> map = new HashMap<>();
		
		// 파일 수정명 샘플
		// somomo_20220803111150_12345.jpg
        String originName = upfile.getOriginalFilename(); // 원본 파일 명
        
        String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()); //년월일시분초
        int randNum = (int)(Math.random() * 90000) + 10000; // 5자리 랜덤값
        String ext = originName.substring(originName.lastIndexOf(".")); // 확장자

        String changeName = "somomo_" + currentTime + "_" + randNum + ext;

        String savePath = session.getServletContext().getRealPath("/resources/"+filePathName+"/");
        
        try {
        	upfile.transferTo(new File(savePath + changeName));
        } catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
        
        map.put("originName", originName); // 원본명
        map.put("changeName", "resources/"+filePathName+"/"+changeName); // 수정명 (resources/uploadFiles/somomo_2022~~.jpg)
        
        return map;
	}
	
}
