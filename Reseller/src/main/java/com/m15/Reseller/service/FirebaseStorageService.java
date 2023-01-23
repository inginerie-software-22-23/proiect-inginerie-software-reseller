package com.m15.Reseller.service;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.storage.*;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Service
public class FirebaseStorageService {

    private final Storage storage;

    public FirebaseStorageService() throws IOException {
        storage = StorageOptions.newBuilder().setCredentials(GoogleCredentials.fromStream(new FileInputStream("src/main/resources/serviceAccountKey.json"))).build().getService();
    }

    public String storeFile(MultipartFile file, String folder) {
        try {
            String fileName = folder + UUID.randomUUID().toString() + "-" + file.getOriginalFilename().replace(" ", "_");
            byte[] fileByteArray = file.getBytes();
            Map<String, String> meta = new HashMap<>();
            meta.put("firebaseStorageDownloadTokens", fileName);
            BlobId blobId = BlobId.of("reseller-1d2c9.appspot.com", fileName);
            BlobInfo blobInfo = BlobInfo.newBuilder(blobId).setMetadata(meta).setContentType(file.getContentType()).build();
            storage.create(blobInfo, fileByteArray);
            return fileName;
        } catch (IOException e) {
            throw new IllegalStateException("Failed to store file to Firebase Storage", e);
        }
    }

    public  byte[] getFile(String fileName) throws IOException {
        BlobId blobId = BlobId.of("reseller-1d2c9.appspot.com", fileName);
        return storage.readAllBytes(blobId);
    }
}
