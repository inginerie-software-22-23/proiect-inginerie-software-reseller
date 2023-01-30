package com.m15.Reseller;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.storage.Bucket;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.cloud.StorageClient;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;

import java.io.FileInputStream;
import java.io.IOException;

@SpringBootApplication
@EnableAsync
public class ResellerApplication {

	public static void main(String[] args) throws IOException {
		SpringApplication.run(ResellerApplication.class, args);

		FileInputStream serviceAccount = new FileInputStream("src/main/resources/serviceAccountKey.json");

		FirebaseOptions options = FirebaseOptions.builder()
				.setCredentials(GoogleCredentials.fromStream(serviceAccount))
				.setStorageBucket("reseller-1d2c9.appspot.com")
				.build();
		FirebaseApp.initializeApp(options);

		Bucket bucket = StorageClient.getInstance().bucket();

	}
}
