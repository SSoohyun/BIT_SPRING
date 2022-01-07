package org.conan.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

import org.conan.domain.BoardAttachVO;
import org.conan.mapper.BoardAttachMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {
	@Setter(onMethod_ = {@Autowired})
	private BoardAttachMapper attachMapper;
	
	@Scheduled(cron = "0 * * * * *")
	public void checkFiles() throws Exception {
		log.warn("File Check Task run. . . . . . . . . . . . . .");
		log.warn("==============================================");
		
		List<BoardAttachVO> fileList = attachMapper.getOldFiles();
		List<Path> fileListPaths = fileList.stream()
				.map(vo -> Paths.get("c:/upload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName()))
				.collect(Collectors.toList());
		fileList.stream().filter(vo -> vo.isFileType() == true)
				.map(vo -> Paths.get("c:/upload", vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName()))
				.forEach(p -> fileListPaths.add(p));
		
		log.warn("=======================================");
		fileListPaths.forEach(p -> log.warn(p));
												
		File targetDir = Paths.get("c:/upload", getFolderYesterday()).toFile();
		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);
		
		log.warn("-------------------------------");
		for(File file : removeFiles) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
	}
	
	private String getFolderYesterday() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal= Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		String str = sdf.format(cal.getTime());
		return str.replace("-", File.separator);
	}
}
