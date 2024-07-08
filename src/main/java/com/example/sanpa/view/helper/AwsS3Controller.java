package com.example.sanpa.view.helper;

import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/s3")
public class AwsS3Controller {

    private final AwsS3Service awsS3Service;

    @Autowired
    AwsS3Config awsS3Config;

    @ApiOperation(value = "Amazon S3에 파일 업로드", notes = "Amazon S3에 파일 업로드")
    @PostMapping("/file")
    public ResponseEntity<List<String>> uploadFile(
            @ApiParam(value="파일들(여러 파일 업로드 가능)", required = true) @RequestParam("multipartFile") List<MultipartFile> multipartFile) {
        List<String> uploadedFiles = awsS3Service.uploadFile(multipartFile);
        return ResponseEntity.ok(uploadedFiles);
    }//uploadFile()-end

    @ApiOperation(value = "Amazon S3에 업로드 된 파일을 삭제", notes = "Amazon S3에 업로드된 파일 삭제")
    @DeleteMapping("/deleteFile")
    public ResponseEntity<Void> deleteFile(
            @ApiParam(value="파일 하나 삭제", required = true) @RequestParam String fileName) {
        awsS3Service.deleteFile(fileName);
        return ResponseEntity.ok().build(); // 이 부분을 수정했습니다.
    }//deleteFile()-end











}//AwsS3Controller()-end